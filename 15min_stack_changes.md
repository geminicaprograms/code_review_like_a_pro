---
marp: true
title: How to Stack Changes like a Pro
description: 15-minute talk, Gerrit User Summit 2026
theme: uncover
style: |
  section { font-size: 28px; }
  h1 { font-size: 54px; }
  h2 { font-size: 42px; }
  pre > code { font-size: 19px; }
  sub {
    position: absolute;
    bottom: 0px;
    padding-bottom: 110px;
    right: 1.2rem;
    font-size: 18px;
  }
  /* ensure footer stays bottom-left; keep page number on the right */
  section>footer {
    left: 1.2rem;
    right: auto;
  }
---

<!-- Slide 1: Title -->
# How to Stack Changes like a Pro
### Chains that survive. Conventions that stick.


<sub><b>Jacek:</b> hands-on engineer & architect, code reviews daily, Gerrit maintainer</sub>
<!--
Hi, I'm Jacek - hands-on software engineer and architect, code review daily practitioner, and Gerrit maintainer.

Last year we talked about how to do code review like a pro. Today: how to stack changes like a pro.

The answer is again simple: the agent will stack. Your job is to hand the agent the rules and the guards, so the stack survives rework and review without you restacking by hand - and, above all, so that it stays reviewable.

[alt subtitles: a. Chains that survive - and conventions the agent keeps. · b. Stacked changes, team conventions, enforced on the agent.]
-->

---

<!-- paginate: true -->
<!-- Slide 2: Last year in one slide -->
## Last year in one slide

- **Focus the diff.** Small, single-concern changes.
- **Coach with principles.** Conventional Comments, severity labels.
- **Let tools police nits.** Formatters, linters, CI.

#### One year later: more code, same reviewers.

<sub>2025 talk: [How to do Code Review like a Pro](https://youtu.be/7pcb1p3hTtg)</sub>

<!--
Last year I left you with three calls to action: focus the diff, coach with principles, and let tools take care of the nits.

One year later, one developer produces in a day what used to take a week. The reviewers are the same people. Let's see what that did to review.
-->

---

<!-- Slide 3: Mega-PRs faster than review -->
## Mega-PRs faster than review

- **Faros 2025:** PR size **+154 %**, review time **+91 %**
- **Faros 2026:** time in code review **+200 %**, time to first review **+157 %**
- **LinearB 2026**, 8.1 M PRs: AI PRs **~2.5× bigger**, wait **>16 h** for a reviewer (was ~200 min)
- **Anthropic 2026:** output per engineer **+200 %** - *"code review has become a bottleneck"*
- **GitHub 2026:** a **1,721-line** agent PR → a **4-layer** stack

#### Review is the new bottleneck.

<sub>[Faros 2025](https://www.faros.ai/blog/ai-software-engineering) · [Faros 2026](https://www.faros.ai/blog/ai-acceleration-whiplash-takeaways) · [LinearB](https://linearb.io/blog/8-million-prs-engineering-productivity) · [Anthropic](https://claude.com/blog/code-review) · [GitHub](https://github.blog/engineering/turn-one-giant-ai-generated-pull-request-to-a-reviewable-stack/)</sub>

<!--
Here's the data - four sources, one picture. Faros, LinearB, Anthropic: pull requests got bigger, review got slower, and Anthropic says it in their own words: "code review has become a bottleneck". The numbers are on the slide; I won't read them.

The interesting one is GitHub engineering, in August. One agent pull request, 1,721 lines. Their fix? They cut it into a stack of four layers - data, API, grounding and UI - four layers out of one pull request. Review is the new bottleneck.
-->

---

<!-- Slide 4: Meme -->
<style scoped>
  blockquote { font-size: 34px; text-align: left; border-left: 6px solid #999; padding-left: 1rem; }
</style>

> Ask a programmer to review **10 lines** of code, he'll find **10 issues**.
>
> Ask him to do **500 lines** and he'll say it **looks good**.

<sub>Giray Özil, [2013](https://x.com/girayozil/status/306836785739210752)</sub>

<!--
And here's why size is the bottleneck.
-->
---

<!-- Slide 5: Welcome to 2008 -->
## Welcome to 2008

- **2010s** Phabricator at Meta: stacked diffs
- **2022** Meta open-sources **Sapling** + ReviewStack
- **2025-12** **Graphite** acquired by Cursor
- **2026-07** **GitHub stacked pull requests**, public preview, `gh-stack`

#### Gerrit, October 2008: one commit per change, uploaded in series - day one.

<sub>[Gerrit's first commit, 2008-10-21](https://gerrit.googlesource.com/gerrit/+/38966837f9f0b331b3cafa3dccb8b41f8c42c671) · [review.source.android.com, Dec 2008](https://web.archive.org/web/20081202081235/http://review.source.android.com/) · [GitHub preview](https://github.blog/changelog/2026-07-30-stacked-pull-requests-are-now-in-public-preview/) · [Gerrit 3.8](https://www.gerritcodereview.com/3.8.html)</sub>

<!--
So everybody arrives at the same answer: small changes, stacked.

Meta had stacked diffs in Phabricator for over ten years; in 2022 they open-sourced Sapling. Graphite built a business on stacked pull requests; in December Cursor bought them. In July, GitHub shipped stacked pull requests as a public preview.

Welcome to 2008. Gerrit 1.0 was the review server of the Android Open Source Project from its launch in October 2008 - one commit per change, a series of commits reviewed as a chain, on day one. Gerrit 2 put the depends-on list on the change page in January 2009, the Change-Id footer came in mid-2009, and since 3.8 you rebase a whole chain with one click.

And the Change-Id footer isn't only ours anymore: in 2025 Gerrit, GitButler and Jujutsu agreed to share it. Now let me show you what a good one looks like.
-->

---

<!-- Slide 6: What a good chain looks like, in practice -->
## What a good chain looks like, in practice

<style scoped>
  section { font-size: 25px; }
</style>

- **One concern per change:** builds alone, tests/docs travel with it, CI-green, revertable.
- **Size is a warning, not a target:** a mechanical migration stays one change.
- **Chain length follows the concerns:** merge the bottom as soon as it's approved.
- **The chain outlives the rework:** Change-Ids survive every amend and rebase; restacking is tooling's job.

**Conventions travel with the repo:** the team writes them down (`AGENTS.md`, `CONTRIBUTING`); commitlint and Conventional Comments etc. are examples.

<sub>[SmartBear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/): 200–400 lines per sitting · [arXiv 2607.20189](https://arxiv.org/abs/2607.20189): 1/3 of chains restructured, 2.6× slower to merge</sub>

<!--
What does a good chain look like? Four things, plus one rule for the repo.

First, one concern per change: it builds on its own, it carries its tests and docs, it's green in CI, and you can revert it alone.

Second, size is a warning, not a target. SmartBear's number: 200 to 400 lines per sitting. But a migration or a rename stays one change. Don't cut it to hit a number.

Third, chain length follows the concerns. Any length is fine as long as the bottom keeps landing.

Fourth, the chain outlives the rework. An agent amends and rebases a lot; every step has to keep the Change-Id. The honest number: in 30,000 Gerrit chains, chain changes merged 2.6 times slower, and a third got restructured in review. Restacking is the price of a chain. Pay it with tooling, not with authors.

The rule for the repo: conventions travel with it, written down in AGENTS.md. Commitlint and Conventional Comments are examples, not rules; nothing is on by default. The agent follows the team, not the chat.

That's the target. Here is how an agent misses it.
-->

---

<!-- Slide 7: Where an agent breaks the chain -->
## Where an agent breaks the chain

<style scoped>
  section { font-size: 21px; }
  h2 { font-size: 38px; }
</style>

![width:800px](assets/chain.svg)

⓪ **wrong cut** - layers, halves, merged concerns &nbsp;·&nbsp; ① hand-made Change-Id &nbsp;·&nbsp; ② `--amend -m`
③ `push … refs/heads/*` → no review &nbsp;·&nbsp; ④ `%topic=` unasked → atomic submit by surprise

<!--
You know this picture. Three commits, one push, three changes in a chain. Amend the middle one, push again: new patch sets, same Change-Ids.

What's new is the author. An agent walks through this many times a day and can break it in five places.

Number zero, and the biggest one, is the cut itself: layers instead of concerns, a concern cut in half, two concerns merged. No guard catches that; only the plan does. More on it at the end.

First, a hand-made Change-Id. Copy it right, nothing happens. Copy it wrong, Gerrit opens a new change, or lands on somebody else's.

Second, amend with dash m. The trailer is gone. New change, old one orphaned with the review on it.

Third, a push to refs heads instead of refs for: the review is simply skipped.

Fourth, a topic on every chain: with submitWholeTopic on, that becomes an atomic submit nobody asked for.

I saw the first two in the benchmark. None of them is free: the agent burns turns, and a human cleans up afterwards. Keep them in mind; the numbers come right after the demo.
-->

---

<!-- Slide 8: Everyone ships an agent stacking skill. Gerrit doesn't. -->
## Everyone ships an agent stacking skill. Gerrit doesn't.

- GitHub `gh-stack`, Graphite, GitButler, Cursor, PostHog, thoughtbot, Codex's change-size skill: **all PR-shaped**, all converge on *plan → one concern per change → approve before push*.
- Official `gerrit@gerrit-mcp`: review tools, and `gerrit-workflow` knows `refs/for` and chains; **no planning, no guards, no push** - nothing guards the chain through rework and review. **That's the gap.**
- **The proposal, tailored for Gerrit:** planning, guards and the push, ported into the official plugin - a relation chain open for review on gerrit-review.

<sub>[gh-stack](https://github.com/github/gh-stack) · [Graphite](https://github.com/withgraphite/agent-skills) · [GitButler](https://blog.gitbutler.com/gitbutler-0-22) · [thoughtbot](https://github.com/thoughtbot/atomic-commits-plugin) · [Cursor 3.3](https://cursor.com/changelog/05-07-26) · [PostHog](https://github.com/posthog/posthog/blob/master/.agents/skills/stacking-prs/SKILL.md) · [gerrit-mcp](https://github.com/GerritCodeReview/gerrit-mcp-server)</sub>

<!--
Everybody else already ships a stacking skill for coding agents: GitHub's gh-stack, Graphite, GitButler, Cursor, PostHog, thoughtbot, Codex. They're all PR-shaped, and they all agree on three things: plan before code, one concern per change, ask a human before you push. And the word they use for a step is "layer".

Some add a line budget or a depth limit. In my benchmark those rules did harm: the agent merged concerns to stay under a depth limit, or split one in half for a line count. so I dropped them: the concern is the unit.

Gerrit has the official MCP plugin. It's good on the review side, and its gerrit-workflow skill knows refs for and chains - but it has no planning step, no guards and no push step. That's the gap.

So I built the missing half: gerrit-stack - first a standalone plugin, then ported into the official one, open for your review on gerrit-review. Here it is, one round.
-->

---

<!-- Slide 9: The proposal, in one round -->
## The proposal, in one round

**In the official plugin:** stack-planner · chain workflow · git guard · gerrit-review - conventions from `AGENTS.md`, Change-Ids from the hook, one push to `refs/for`.

1. **Plan → chain:** a plain feature request, three concerns; `stack-planner` proposes three steps, you say yes; three commits, Change-Ids from the hook, `feat:` subjects from the repo's documented conventions (`AGENTS.md`, commitlint).
2. **Push asks:** grouping? none; *"Push 3 changes to refs/for/master?"* → `git push origin HEAD:refs/for/master`; one push, three changes, one relation chain.
3. **Review round:** `issue (blocking)` on change 2 → fix as a fixup → autosquash → Change-Ids verified → whole chain re-pushed → change 2 PS2, change 3 PS2 rebased, change 1 untouched → labelled reply after your ok.

<sub>Stage script: [`demo/RUN.md`](https://github.com/geminicaprograms/gerrit-stack/blob/main/demo/RUN.md)</sub>

<!--
[SETUP - T-30, from ~/workspace/open/gerrit-stack (talk-day runbook: docs/demo-runbook.md in this repo). Installed plugin = the PORT (gerrit@gerrit-mcp from the local checkout); gerrit-stack is not installed. Start plain `claude`, no --plugin-dir:
  make demo-up demo-seed demo-warm        (seed writes .gerrit-stack, AGENTS.md and the commitlint config into the demo project)
  tab A:  cd demo/work/demo-plugin && DISABLE_AUTOUPDATER=1 claude   → /mcp shows gerrit green, first line "This repository is reviewed on Gerrit. For any change that touches more than one file, invoke the gerrit-workflow skill…" (no line = not detected, stop)
  tab B:  shell at the gerrit-stack root (reviewer script)
  browser tab 1: http://localhost:8080/q/status:open+project:demo-plugin (empty, logged in as admin); tab 2 free
  dry-run once and answer "yes, don't ask again" to the git / quick-check permission prompts]

[PRE-WARMED OPTION - at the end of slide 2 paste the prompt in tab A and answer "yes" to the plan; the commits run while you talk; arrive here at the grouping question. Otherwise do it all now.]

[STEP 1 - TYPE in tab A: paste demo/feature-request.md:
  "Feature request: greeting for demo-plugin. We want demo-plugin to greet a project the same way it already answers ping.
   1. REST: GET /projects/{name}/demo-plugin~greeting returns {"greeting":"<prefix>, <project>!"}. The prefix comes from [plugin "demo-plugin"] greetingPrefix in gerrit.config, default Hello.
   2. SSH: demo-plugin greet <project> prints the same greeting.
   3. A project can override the prefix in its own project.config ([plugin "demo-plugin"] greetingPrefix); the server value stays the default.
   When it is done, push the work to Gerrit for review."
  (no "split" instruction, no verify command - both arms planned 3 steps unprompted; if a run proposes 2, answer: three steps please: REST, SSH, project override)
  WAIT for the 3-step plan (Step 1 - feat: serve project greeting over REST / Step 2 - feat: add greet SSH command / Step 3 - feat: let project.config override greeting prefix) → TYPE: yes
  WAIT for three commits (each: edit → quick-check → git add → git commit → "one Change-Id ✓, size")]

Step one. A plain feature request: three behaviours, no Gerrit words, no "split it" instruction. The planner proposes three steps, I say yes, the agent makes three commits - Change-Ids from the hook, subjects as the repo documents them.

[STEP 2 - WAIT for: "All 3 changes target demo-plugin/master. Group them? none / hashtag / topic" → TYPE: none
  WAIT for: "Push 3 changes to refs/for/master on origin? (y/n/wip)" → TYPE: yes
  the agent runs the printed `git push origin HEAD:refs/for/master`; Gerrit prints three change URLs
  BROWSER tab 1: reload → 3 open changes; open change 2 in tab 2 → Related Changes shows one above, one below; note its number <n2>]

Step two. It asks twice: grouping? None - the chain already links them. Push three changes to refs for master? Yes. One push, one relation chain.

[STEP 3 - tab B: bash demo/reviewer-comment.sh <n2>   → prints the change URL
  BROWSER tab 2: reload → Code-Review −1 from Rena Reviewer, unresolved thread "issue (blocking): an empty or unknown project name must produce a clear error here…"
  TYPE in tab A: Check review comments on the chain and address them
  WAIT: threads table (one row, change <n2>) → fix → git commit --fixup → rebase --autosquash → "verify-ids: ok"
  WAIT for: "Push 3 changes to refs/for/master on origin?" → TYPE: yes
  WAIT for: "Ready to post 1 reply … Post? (y/n)" → TYPE: yes
  BROWSER: change 2 → Patch set 2, thread resolved; change 3 → Patch set 2 (rebased, no diff of its own); change 1 untouched]

Step three. A blocking comment on change two. "Check review comments and address them." The agent fixes the code, folds it into change two with a fixup and autosquash, verifies all three Change-Ids, re-pushes the whole chain. Change two: patch set two. Change three: rebased. Change one: untouched. Then it drafts the reply and asks me before posting.

That's a relation chain in action - and this same workflow produced the port chain you can review today. Did it hold beyond a demo? I measured it.

[FALLBACKS (RUN.md table): any step silent > 60 s → demo/recording/full-7min.mp4 from the matching chapter; /mcp not green → run to the push, then short-3min.mp4 for the review round; verify > 30 s → git config gerrit-stack.verify-cmd 'bash tools/quick-check.sh'; Gerrit down → docker compose restart (~40 s). Reset between runs: bash demo/reset.sh && make demo-up demo-seed demo-warm.]

[PROTOTYPE INSTEAD OF THE PORT (only if the port misbehaves on stage): claude plugin disable gerrit@gerrit-mcp && claude plugin install gerrit-stack@gerrit-stack (marketplace geminicaprograms/gerrit-stack, pulls the released gerrit@gerrit-mcp as a dependency); first line then reads "[gerrit-stack] This repository pushes to Gerrit…"; same prompts, same answers. Re-check the guard in the dry run either way: ask for `git commit --amend -m x` once and expect the deny.]

[If asked how the other arms reworked: all landed the fix on the right change and kept the Change-Id set; vanilla used rebase -i "edit" + amend --no-edit; MCP-only rewrote the message in a heredoc and re-typed the Change-Id in five of six runs; the plugin: fixup, autosquash, verify-ids.]
-->

---

<!-- Slide 10: The team's rules, enforced on the agent -->
## Does the chain survive? 120 runs, four arms

*Promised a skill that makes chains the default. Built it, measured it, ported it into the official plugin, measured again.*

<style scoped>
  table { font-size: 18px; }
  section { font-size: 22px; }
  h2 { font-size: 36px; }
  th:nth-child(3), td:nth-child(3) { color: #8a8a8a; }
</style>

| 3 runs per cell, sandboxed · rework rows pool two variants | gerrit-mcp + port | prototype | gerrit-mcp only | vanilla | enforced by |
|---|---|---|---|---|---|
| unprompted runs that produced a chain | **6 / 6** | 6 / 6 | 6 / 6 | 6 / 6 | the model |
| rework all green (+ "squash it" advice) | **5 / 6** | 6 / 6 | 1 / 6 | 4 / 6 | skill rule |
| Change-Id re-typed in the rework | **1 / 6** | 0 / 6 | 5 / 6 | 1 / 6 | guard + hook |
| labelled comments (opt-in) | **16 / 16** | 19 / 19 | 0 / 16 | 6 / 18 | `AGENTS.md` |

*The port keeps what the prototype measured; what differed is **how** the chain survived.*
**Enforced by:** `commit-msg` hook → guards → `AGENTS.md` (commitlint, Conventional Comments)

<sub>[gerrit-stack](https://github.com/geminicaprograms/gerrit-stack) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md)</sub>

<!--
Evidence matters. A hundred and twenty sandboxed runs, same model, same prompts, four arms: vanilla, the official plugin, the prototype on top, the official plugin with the port. Four suites; the table shows three of them - the prompted-split suite came out equal in every arm, numbers in the repo. Three runs per cell - one run of difference is noise.

First surprise: every arm splits the work into chains - six of six unprompted runs, in every arm. The model learned that. Even vanilla Claude Code, given the demo prompt, pushed a three-change chain without being asked. The default is there; the value is in keeping the chain. That's the honest version of the abstract.

The difference is the rework. Six changes, a blocking comment on change three, the fix conflicts with change five, and half the runs get bad advice: "amend with dash m and squash the rest".

With the port, five of six runs came out green on every check; the prototype six of six; MCP-only one; vanilla four. The chain itself survived in every arm - the difference is how. The MCP-only arm re-typed the Change-Id by hand in five of six runs: right value, zero benefit, and one typo would open a new change. The prototype never did. The port did it once - the commit's own id, written into an amend message file; nothing was lost, but that is the one thing on my list to tighten. Within noise, the port keeps what the prototype measured.

And review comments, where the repo says "use Conventional Comments": the port labelled sixteen of sixteen, the prototype nineteen of nineteen, MCP-only none.

One thing porting taught me. The first port scored three of seven on the behaviour evals: its skills fired only when the prompt named them. One SessionStart line - "this repo pushes to Gerrit, here are the chain rules" - took it to six of seven. The default has to be announced, not just installed. Measure what matters.

[If asked: D ran 13 days after A–C, Claude Code 2.1.302 vs 2.1.289; the seven qualification evals score 6/7 for both on today's CLI. Commitlint showed no difference: every arm's subjects passed it; its value is catching drift.]

[If asked: the benchmark also has a "skip the hook with no-verify" variant; left out - a hook is not slow - numbers in the repo.]
-->

---

<!-- Slide 11: Cut by concern, not by layer -->
## Cut by concern, not by layer

<style scoped>
  section { font-size: 22px; }
</style>

![width:1000px](assets/cut.svg)

<sub>Chain on concerns - not on layers, not on lines · size is a warning, never a cut · the cheap breaks (id, `-m`, topic, branch): a guard denies or asks</sub>

<!--
Back to break number zero, the one no guard can catch: the cut.

A concern is what a reviewer can judge in one sitting and what you can revert on its own. It runs through every layer it needs. That's why a layer is never a change.

Look at the left side. Config in one change, the service in the next, then REST, then SSH. Each one says "part one of four". Nothing works on its own, and the reviewer of part two has to read part four to understand it. Wrong mindset - and it's exactly what the PR-shaped skills teach. GitHub's own showcase cut that 1,721-line pull request into data, API, grounding and UI, and not one of those four is a feature. Layers are how you build a stack of pull requests. They're the wrong unit for a chain.

Now the right side. Each slice is one behaviour: the code, its caller and its test, through every layer it touches. It builds on its own and it reads on its own. So copy the stacking, not the cut.

Two more ways to get the cut wrong. Splitting by size: when a slice is big, that's a warning for the reviewer, not a reason to cut it in half. And merging concerns, to keep the chain short or because someone says "just squash it": one change per concern, and a fix goes in as a fixup, into the change it belongs to. A mechanical change - a rename, a migration - goes first, behaviour on top.

Everything else on that list - the hand-typed id, amend dash m, the unasked topic, the push to a branch - is cheap: a guard denies it or asks. Chain on concerns, not on layers, not on lines.
-->

---

<!-- Slide 12: Summary & call to action -->
## Summary & call-to-action
#### The agent will stack. Let it keep the chain. Follow the team.

<style scoped>
  section { font-size: 25px; }
  .left-align { text-align: left }
  pre > code { font-size: 15px; }
</style>
<div class="left-align">By next Friday:</div>

- Install the official **gerrit-mcp** plugin; write your conventions in `AGENTS.md` (commitlint, Conventional Comments, …).
- Review **by change**; coach with principles.
- **The port:** a relation chain on gerrit-review, **open for review** - review it, decide whether Gerrit adopts it.

```
/plugin marketplace add https://gerrit.googlesource.com/gerrit-mcp-server
/plugin install gerrit@gerrit-mcp   →   /gerrit:setup
```

<sub>Thanks! [slides](https://geminicaprograms.github.io/code_review_like_a_pro/stack/) · [the port](TODO-port-link) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md) · [Discord](https://discord.gg/eEZQrtzAwV)</sub>

<!--
Three things to carry out of the room.

The agent will stack - you don't need to teach it that anymore.

Let it keep the chain. The agent does the rework; the guards sit at the three places it breaks: the hook that writes the Change-Id, the amend that has to keep it, and the push that has to go to refs for and ask you first.

Follow the team. Write your conventions down in the repo - commit style, review labels - and the agent follows the team, not the prompt.

By next Friday: install the official plugin, three commands. Write your conventions into AGENTS.md. Review by change and coach with principles - same as last year.

One more thing. The port is on gerrit-review, a relation chain open for review as of today. Review it like any other chain, and tell me on Discord whether Gerrit should adopt it. Thank you.
-->
