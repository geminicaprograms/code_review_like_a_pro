# Demo runbook — "One chain, one review round" (slide 9)

Everything you type, in order, with what you should see. Source of the stage
script: `~/workspace/open/gerrit-stack/demo/RUN.md`; this file is the talk-day
version. Paths are relative to `~/workspace/open/gerrit-stack` unless absolute.

## 0. Which plugin runs the demo

The `gerrit-stack` plugin is **installed** from the marketplace (user scope), so
start `claude` **without** `--plugin-dir` — with both, every skill registers
twice and every guard asks twice. Dev mode only if you first run
`claude plugin disable gerrit-stack@gerrit-stack`.

Port instead of the prototype (what the slides lead with): see section 7.

## 1. T-30 — bring the stage up (≈ 3 min, once)

```
cd ~/workspace/open/gerrit-stack
make demo-up demo-seed demo-warm        # Gerrit 3.14 on :8080 (first init ~90 s), admin + reviewer "rena",
                                        # project demo-plugin with the skeleton + .gerrit-stack + commitlint config,
                                        # ~/.netrc entry, gerrit-mcp config, in-tree Bazel build warmed
bash demo/work/demo-plugin/tools/quick-check.sh    # < 1 s, exit 0
docker compose -f demo/docker-compose.yml ps        # "healthy"
```

Then:

- **Browser tab 1:** `http://localhost:8080/q/status:open+project:demo-plugin` — empty list. If you look logged out: `http://localhost:8080/login/?user_name=admin`. **Tab 2** stays free for change 2.
- **Terminal tab A** (the demo): `cd ~/workspace/open/gerrit-stack/demo/work/demo-plugin && DISABLE_AUTOUPDATER=1 claude`
  - first line must be `[gerrit-stack] This repository pushes to Gerrit …` (no line = repo not detected, stop here)
  - `/mcp` → `gerrit` green
- **Terminal tab B** (the reviewer): `cd ~/workspace/open/gerrit-stack`, keep `cat demo/feature-request.md` and `bash demo/reviewer-comment.sh` in the history.
- Font 18+, `Ctrl-L` in both tabs, notifications off, Finder open on `demo/recording/`.

**Dry run once on the day** (section 3 end to end), answering **"yes, don't ask
again"** to the permission prompts for `git …` and `bash tools/quick-check.sh`,
so the show runs without prompts. The push guard still asks — by design, that is
the on-stage confirmation. Then reset (section 6).

## 2. Pre-warmed variant (recommended, D1)

At the end of slide 2, in tab A, paste the prompt (section 3, step 1) and answer
**yes** to the plan. Say one sentence: *"The agent is already working; we come
back to it."* The three commits run while you present slides 3–8. Arriving at
slide 9 you should see the grouping question waiting. If it is still committing,
narrate the `chain-status` line and continue; if it errored, go to the recording.

## 3. The round — what to type, what you see, what to say

### Step 1 — plan → chain

**Type in tab A** (paste the whole file `demo/feature-request.md`):

```
Feature request: greeting for demo-plugin

We want demo-plugin to greet a project the same way it already answers `ping`.

1. REST: `GET /projects/{name}/demo-plugin~greeting` returns `{"greeting":"<prefix>, <project>!"}`. The prefix comes from `[plugin "demo-plugin"] greetingPrefix` in gerrit.config, default `Hello`.
2. SSH: `demo-plugin greet <project>` prints the same greeting.
3. A project can override the prefix in its own project.config (`[plugin "demo-plugin"] greetingPrefix`); the server value stays the default.

When it is done, push the work to Gerrit for review.
```

No "one concern per change", no verify command: the plugin plans the chain on
its own and `seed.sh` sets `verify-cmd`. Both the prototype and the port
planned this prompt as the same three steps in headless tests (2026-10-18):
`feat: serve project greeting over REST` (setting + endpoint + tests),
`feat: add greet SSH command`, `feat: let project.config override greeting
prefix`. If a run proposes two, answer: `three steps please: REST, SSH, project
override` — the plan is the contract, the author sets the granularity.

**You see:** the `gerrit-stack` skill fires (no `/command` needed — the repo is
Gerrit), runs the preflight, then `stack-planner` prints a 3-step plan
(`Step 1 — feat: serve project greeting over REST`, `Step 2 — feat: add greet SSH command`, `Step 3 — feat: let project.config override greeting prefix`)
with files, estimated lines, verify command, and ends with
*"Approve this 3-step plan? Reply yes …"*.

**Type:** `yes`

**You see:** per step: edit → `bash tools/quick-check.sh` → `git add <paths>` →
`git commit` → the post-commit line "exactly one Change-Id ✓, +N/−M production
lines". Three commits, subjects `feat: …` (commitlint config in the repo).

**Say:** Step one. A plain feature request: three behaviours, no Gerrit words, no "split it" instruction.
The planner proposes three steps, I say yes, the agent makes three commits —
Change-Ids from the hook, subjects as the repo documents them.

If you want the guard on screen (D3), type now:
`Change the subject of the last commit to "feat: greeting prefix setting" with git commit --amend -m`
→ the guard denies (`--amend -m` drops the Change-Id), the agent rewrites with
`git log -1 --format=%B > file`, edit, `--amend -F file`. One sentence: *"Same
change, new patch set — the trailer survived."*

### Step 2 — push

**You see:** *"All 3 changes target demo-plugin/master. Group them? none
(recommended) / hashtag <tag> / topic <slug>"*

**Type:** `none`

**You see:** *"Push 3 changes to refs/for/master on origin? (y/n/wip)"*

**Type:** `yes`

**You see:** the printed command `git push origin HEAD:refs/for/master` runs;
Gerrit answers with three URLs `http://localhost:8080/c/demo-plugin/+/<n>`; the
skill confirms the chain with `get_related_changes`.

**Browser:** reload tab 1 → three open changes. Open **change 2** in tab 2 →
*Related Changes* shows one above, one below. **Note its number `<n2>`.**

**Say:** Step two. It asks twice: grouping? None — the chain already links
them. Push three changes to refs for master? Yes. One push, one relation chain.

### Step 3 — the review round

**Tab B:**

```
bash demo/reviewer-comment.sh <n2>
```

(as `rena`: `Code-Review −1` + one unresolved thread on the first `.java` under
`src/main`, line 1: *"issue (blocking): an empty or unknown project name must
produce a clear error here, not a stack trace; add a unit test for it."* — fits
whichever change sits in the middle; prints the change URL.)

**Browser tab 2:** reload → the −1 and the thread. One sentence: *"Conventional
Comments — the label says what kind of feedback this is."*

**Type in tab A — this is how you "call review":**

```
Check review comments on the chain and address them
```

(Equivalent explicit call: `/gerrit-stack:gerrit-review` reads the threads and
hands the fix to `gerrit-stack` Phase 5. The sentence triggers the same skills.)

**You see, in order:**
1. the threads table `change | file:line | author | unresolved | summary` — one row, change `<n2>`;
2. the fix in the code, `git commit --fixup=<sha of change 2>`;
3. `git -c sequence.editor=true rebase -i --autosquash <base>`;
4. `chain-status.sh --verify-ids` → `ok` (three Change-Ids unchanged);
5. *"Push 3 changes to refs/for/master on origin? (y/n/wip)"* → **Type:** `yes`
6. the push; then the reply batch: *"Ready to post 1 reply … Done. …
   Post? (y/n/edit N)"* → **Type:** `yes`

**Browser:** tab 2 → **Patch set 2**, thread resolved, −1 gone. Tab 1 → change 3
also **Patch set 2** (rebased, no diff of its own), change 1 still patch set 1.

**Say:** Step three. A blocking comment on change two. "Check review comments
and address them." The agent fixes the code, folds it into change two with a
fixup and autosquash, verifies all three Change-Ids, re-pushes the whole chain.
Change two: patch set two. Change three: rebased. Change one: untouched. Then
it drafts the reply and asks me before posting. That's a relation chain in
action. Now the numbers.

## 4. Timing (from the headless run and RUN.md)

| part | expect |
|---|---|
| plan | 20–40 s |
| three commits | 2–4 min (why the pre-warmed variant exists) |
| grouping + push | 20 s |
| review round (read → fixup → rebase → verify → push → reply) | 1.5–2.5 min |

## 5. Fallbacks (switch without apology)

| trigger | do |
|---|---|
| any step silent > 60 s | play `demo/recording/full-7min.mp4` from the matching chapter |
| `/mcp` not green at T-30, or the push cannot confirm the chain | run to the push (works without MCP), then `short-3min.mp4` for the review round |
| verify > 30 s (Bazel picked instead of quick-check) | `git -C demo/work/demo-plugin config gerrit-stack.verify-cmd 'bash tools/quick-check.sh'`, tell the agent to re-run verification |
| Gerrit not healthy | `docker compose -f demo/docker-compose.yml restart` (~40 s), else the recording |
| `reviewer-comment.sh` fails | it prints the equivalent `curl`; or post the comment in the UI as rena (`http://localhost:8080/login/?user_name=rena`) |
| guard denies something unexpected and drops a `git add` | `git -C demo/work/demo-plugin status` and tell the agent "stage the fix and amend again" |

Recordings are made at rehearsal #2 (`demo/recording/` is git-ignored).

## 6. Reset between rehearsals (~2 min)

```
cd ~/workspace/open/gerrit-stack
bash demo/reset.sh && make demo-up demo-seed demo-warm
```

`reset.sh` removes the container + volumes, `demo/work/`, the init artefacts
and the permission answers (`demo/work/demo-plugin/.claude/settings.local.json`),
so the dry-run step in section 1 is needed again. `seed.sh` is idempotent.

## 7. Running the port instead of the prototype

What the slides lead with (arm D). Same round, different plugin:

1. `claude plugin disable gerrit-stack@gerrit-stack` (avoid two sets of guards).
2. In `demo/work/demo-plugin` add an `AGENTS.md` stating the conventions the
   skills read (the benchmark fixture's wording: commitlint config in the repo,
   "use Conventional Comments in review"), commit it on `master` and push it
   to `refs/heads/master` as admin, or let the seed carry it.
3. Tab A: `cd demo/work/demo-plugin && DISABLE_AUTOUPDATER=1 claude --plugin-dir ~/workspace/open/gerrit-mcp-server`
   — the checkout must be at the pushed chain's head; the guard and the
   SessionStart context need the plugin environment's console scripts
   (benchmark "Open after arm D" #6): confirm the `[gerrit…]` session line and
   one denied `--amend -m` **in the dry run**, not on stage.
4. Prompts and answers are identical to section 3; the review step is triggered
   by the same sentence (the ported `gerrit-review` skill).
5. Rehearse once before deciding; if it misbehaves, the prototype path above is
   measured and known.

## 8. Day-of checklist

- [ ] `claude --version` noted; `DISABLE_AUTOUPDATER=1` in tab A
- [ ] `make demo-up demo-seed demo-warm` green; `quick-check.sh` < 1 s
- [ ] tab A: `[gerrit-stack] …` line, `/mcp` green; dry run done; reset done
- [ ] tab B: `demo/feature-request.md` and `reviewer-comment.sh` in history
- [ ] browser tab 1 at the project query, logged in as admin
- [ ] recordings present and playable; Wi-Fi off except hotspot (Claude API)
- [ ] `<n2>` written on paper after the push
