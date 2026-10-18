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
Hi, I'm Jacek — hands-on software engineer and architect, code review daily practitioner, last and NOT least Gerrit maintainer.

Last year we talked about how to do code review like a pro. Today we're talking about how to stack changes like a pro.

The answer is simple: the agent will stack — your job is to make sure the stack survives. In rework, in review, even with bad advice. If we get that right, the chain takes care of itself.

[alt subtitles: a. Chains that survive — and conventions the agent keeps. · b. Stacked changes, team conventions, enforced on the agent.]
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
Last year, three calls to action.

Focus the diff — one concern per change, small is reviewable.

Coach with principles — Conventional Comments, label the severity, explain the why.

Let tools police the nits — formatters, linters and CI do the boring part.

One year later, one developer produces more code in a day than before in a week. The reviewers are the same people. Let's look at what that did to review.
-->

---

<!-- Slide 3: Mega-PRs faster than review -->
## Mega-PRs faster than review

- **Faros 2025:** PR size **+154 %**, review time **+91 %**
- **Faros 2026:** time in code review **+200 %**, time to first review **+157 %**
- **LinearB 2026**, 8.1 M PRs: AI PRs **~2.5× bigger**, wait **>16 h** for a reviewer (was ~200 min)
- **Anthropic 2026:** output per engineer **+200 %** — *"code review has become a bottleneck"*
- **GitHub 2026:** a **1,721-line** agent PR → a **4-layer** stack

#### Review is the new bottleneck.

<sub>[Faros 2025](https://www.faros.ai/blog/ai-software-engineering) · [Faros 2026](https://www.faros.ai/blog/ai-acceleration-whiplash-takeaways) · [LinearB](https://linearb.io/blog/8-million-prs-engineering-productivity) · [Anthropic](https://claude.com/blog/code-review) · [GitHub](https://github.blog/engineering/turn-one-giant-ai-generated-pull-request-to-a-reviewable-stack/)</sub>

<!--
Here's the data. Research backs this up — four sources, same picture.

Faros looked at ten thousand developers in 2025. Teams with high AI adoption: pull requests got 154 percent bigger and review time went up 91 percent. In 2026 they looked again, twenty-two thousand developers this time — time in code review is up 200 percent.

LinearB looked at eight million pull requests. AI-assisted PRs are about two and a half times bigger — at the 75th percentile over 400 lines instead of 157 — and they wait more than 16 hours for a reviewer, where it used to be about 200 minutes.

Anthropic, March this year: code output per engineer grew 200 percent. Their own words: "code review has become a bottleneck".

And GitHub engineering, in August: one agent pull request, 1,721 lines. Their fix? They cut it into a stack of four layers — remember that word, it comes back.

So writing code isn't the problem anymore. Measure what matters: review is the new bottleneck.
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

---

<!-- Slide 5: Welcome to 2008 -->
## Welcome to 2008

- **2010s** Phabricator at Meta: stacked diffs
- **2022** Meta open-sources **Sapling** + ReviewStack
- **2025-12** **Graphite** acquired by Cursor
- **2026-07** **GitHub stacked pull requests**, public preview, `gh-stack`

#### Gerrit, October 2008: one concern per change, chained by parent — day one.

- **Rebase chain** from the UI and REST since **3.8** · the **Change-Id** footer: Gerrit, GitButler and jj agree (2025)

<sub>[Sapling](https://engineering.fb.com/2022/11/15/open-source/sapling-source-control-scalable/) · [Graphite](https://cursor.com/blog/graphite) · [GitHub preview](https://github.blog/changelog/2026-07-30-stacked-pull-requests-are-now-in-public-preview/) · [Gerrit's first commit, 2008-10-21](https://gerrit.googlesource.com/gerrit/+/38966837f9f0b331b3cafa3dccb8b41f8c42c671) · [Gerrit 3.8](https://www.gerritcodereview.com/3.8.html) · [Change-Id thread](https://lore.kernel.org/git/CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com/T/#u)</sub>

<!--
And the answer everybody arrives at is the same one: small changes, stacked.

Meta had stacked diffs in Phabricator for more than ten years, and in 2022 they open-sourced Sapling and ReviewStack. Graphite built a business on stacked pull requests — in December 2025 Cursor bought them. And in July this year GitHub shipped stacked pull requests as a public preview, with a CLI extension called gh-stack.

Welcome to 2008. Gerrit went live with the Android open-source release in October 2008, and it had this from day one: one concern per change, changes chained by parent and child. Since 3.8 you rebase a whole chain with one click or one REST call.

And the Change-Id footer isn't only ours anymore — in 2025 Gerrit, GitButler and Jujutsu agreed on the git mailing list to share it. The wheel is round. Let me show you what a good one looks like.
-->

---

<!-- Slide 6: What a good chain looks like, in practice -->
## What a good chain looks like, in practice

<style scoped>
  section { font-size: 25px; }
</style>

- **One concern per change:** builds alone, tests travel with it, CI-green, revertable.
- **Size is a warning, not a target:** a mechanical migration stays one change.
- **Chain length follows the concerns:** merge the bottom as soon as it's approved.
- **The chain outlives the rework:** Change-Ids survive every amend and rebase; restacking is tooling's job.

**Conventions travel with the repo:** the team writes them down (`AGENTS.md`, `CONTRIBUTING`); commitlint and Conventional Comments are examples, nothing is imposed by default.

<sub>[SmartBear](https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/): 200–400 lines per sitting · [arXiv 2607.20189](https://arxiv.org/abs/2607.20189): 1/3 of chains restructured, 2.6× slower to merge</sub>

<!--
So what does a good chain look like in practice? Four things. Plus one rule for the repo.

First, one concern per change. Each change builds on its own, the tests travel with the code they test, it's green in CI, and you can revert it alone.

Second, size is a warning, not a target. SmartBear's old number still holds — 200 to 400 lines per sitting, above that reviewers miss defects. But a mechanical change, like a migration or a rename, stays one change. Don't cut it into pieces just to hit a number.

Third, chain length follows the concerns. Three concerns, three changes; eight concerns, eight changes. Any length is fine as long as the bottom keeps landing — merge the lowest change as soon as it's approved. Concern-sized changes with their own tests are what make that safe.

Fourth, the chain outlives the rework. You know what the Change-Id is. What's new is the author: an agent amends and rebases a lot, and every one of those steps has to keep the id. And here's the honest number — a study of 30,000 Gerrit chains this summer found that chain changes take 2.6 times longer to merge than single changes of the same size, and one third get restructured during review. Restacking is the price of a chain. Pay it with tooling, not with authors: rebase chain, fixup and autosquash, Change-Ids verified, the chain re-pushed as one. The rework scenario on slide 10 measures exactly this.

And the rule for the repo: conventions travel with it. The port ships no convention of its own and nothing is on by default — the Gerrit project itself, on gerrit-review, enforces neither commitlint nor Conventional Comments. But if your team writes its conventions down in AGENTS.md or CONTRIBUTING, the skills read them: a commitlint config runs on every commit, "use Conventional Comments" holds the agent to labels in review. Examples, not rules. Committed files, not lines in a prompt. The agent follows the team, not the chat. (The standalone prototype reads the same things from a .gerrit-stack file.)
-->

---

<!-- Slide 7: Where an agent breaks the chain -->
## Where an agent breaks the chain

<style scoped>
  section { font-size: 21px; }
  h2 { font-size: 38px; }
</style>

![width:800px](assets/chain.svg)

⓪ **wrong cut** — layers, halves, merged concerns &nbsp;·&nbsp; ① hand-made Change-Id &nbsp;·&nbsp; ② `--amend -m`
③ `push … refs/heads/*` → no review &nbsp;·&nbsp; ④ `%topic=` unasked → atomic submit by surprise

<!--
You know this picture: three commits, one push, three changes in a relation chain. Amend the middle one, push again, and you get patch set two on changes two and three — same Change-Ids.

What's new is the author. An agent walks through this picture many times a day, and it can break it in five places.

Number zero, and the biggest one, is the cut itself: layers instead of concerns, one concern cut in half to hit a line budget, two concerns merged to keep the chain short. No guard catches that — only the plan does, before any code is written. More on this at the end.

The next two I saw in the benchmark; the last two the guards cover anyway.

First, a hand-made Change-Id. The agent rewrites a commit message and types the trailer back in, or computes one. Copy it right and nothing happens — tokens burned. Copy it wrong and Gerrit opens a new change, or lands your patch set on somebody else's.

Second, amend with dash m. The whole message is replaced, the trailer is gone, the hook stamps a fresh id — new change, and the old one is orphaned with the review on it.

Third, push to refs heads instead of refs for. On most servers the ACL denies it; where you're allowed, the review is simply skipped. The guard says no either way, so it doesn't depend on the ACL.

Fourth, a topic on every chain. The official gerrit-workflow skill shows topic equals my-feature with the comment "groups related changes" — true, and with submitWholeTopic on that grouping becomes an atomic submit the author never asked for. I didn't see this one in the benchmark; the guard asks before it happens.

Five small moves, and none of them is free. The agent burns turns to notice and undo them, and a human still cleans up after it — abandon the orphaned change, re-attach the review, pull the topic apart. Keep them in mind for the numbers in a minute.
-->

---

<!-- Slide 8: Everyone ships an agent stacking skill. Gerrit doesn't. -->
## Everyone ships an agent stacking skill. Gerrit doesn't.

- GitHub `gh-stack`, Graphite, GitButler, Cursor, PostHog, thoughtbot, Codex's change-size skill: **all PR-shaped**, all converge on *plan → one concern per change → approve before push*.
- Official `gerrit@gerrit-mcp`: review tools, and `gerrit-workflow` knows `refs/for` and chains; **no planning, no guards, no push** — the port adds them: **a relation chain open for review on gerrit-review**.
- **Gap:** nothing guards the chain through rework and review.

<sub>[gh-stack](https://github.com/github/gh-stack) · [Graphite](https://github.com/withgraphite/agent-skills) · [GitButler](https://blog.gitbutler.com/gitbutler-0-22) · [thoughtbot](https://github.com/thoughtbot/atomic-commits-plugin) · [Cursor 3.3](https://cursor.com/changelog/05-07-26) · [PostHog](https://github.com/posthog/posthog/blob/master/.agents/skills/stacking-prs/SKILL.md) · [gerrit-mcp](https://github.com/GerritCodeReview/gerrit-mcp-server)</sub>

<!--
Everybody else already ships a stacking skill for coding agents: GitHub's own gh-stack, Graphite, GitButler, Cursor, PostHog, thoughtbot — and Codex has a change-size skill. They're all PR-shaped, and they all agree on three things: plan before code, one concern per change, ask a human before you push. Note the word they actually use for a step — a layer. Hold that thought for the anti-patterns.

Some of them add a line budget or a depth limit. In my benchmark those numeric rules did harm: the agent merged two concerns to stay under a depth limit, or split one in half to stay under a line count. So I dropped them. The concern is the unit.

Gerrit has the official MCP plugin. It's good on the review side, and its gerrit-workflow skill knows refs for and relation chains — but it has no planning step, no guards and no push step. It's also heading to Codex, there's an open change for a Codex plugin, so the gap is the same for both agents.

So in our world, nothing released guards the chain through rework and review. That's the gap — and the port I'll show you closes it: a relation chain on gerrit-review, open for review as of today.
-->

---

<!-- Slide 9: One chain, one review round -->
## One chain, one review round

1. **Plan → chain:** a plain feature request, three concerns; `stack-planner` proposes three steps, you say yes; three commits, Change-Ids from the hook, `feat:` subjects from the repo's documented conventions (`AGENTS.md`, commitlint).
2. **Push asks:** grouping? none; *"Push 3 changes to refs/for/master?"* → `git push origin HEAD:refs/for/master`; one push, three changes, one relation chain.
3. **Review round:** `issue (blocking)` on change 2 → fix as a fixup → autosquash → Change-Ids verified → whole chain re-pushed → change 2 PS2, change 3 PS2 rebased, change 1 untouched → labelled reply after your ok.

<sub>Stage script: [`demo/RUN.md`](https://github.com/geminicaprograms/gerrit-stack/blob/main/demo/RUN.md)</sub>

<!--
Here's what the plugin does, in one round. [If the background run in tab A is already at the grouping question, glance at it here; otherwise just tell it.]

Step one. The prompt is a plain feature request — three concerns, no Gerrit words in it. The planner proposes three steps, I say yes, and the agent makes three commits. The Change-Id comes from the hook, and the subjects say feat because the repo documents its conventions — AGENTS.md, a commitlint config — and the skills read them.

Step two. Before the push, the plugin asks twice. Grouping — none, hashtag or topic? None: same repo, same branch, the chain already links them. Then: push three changes to refs for master? Yes. It runs the printed command. One push, three changes, one relation chain.

Step three. A reviewer posts a blocking comment on change two. I say: check review comments and address them. The agent reads the thread, fixes the code, folds the fix into change two with a fixup and an autosquash rebase, verifies that all three Change-Ids are unchanged, and pushes the whole chain again. Change two gets patch set two; change three gets patch set two as well, rebased, no diff of its own; change one is untouched. Then it drafts the reply and asks me before it posts.

Three reviewable changes, one review round, no Gerrit vocabulary in the prompt — that's a relation chain in action. Now the numbers.

[screenshot to capture at rehearsal from the demo Gerrit: Related Changes with change 2 at PS2 — assets/related-changes.png]

[Stage script demo/RUN.md runs the standalone prototype (`--plugin-dir …/gerrit-stack`); the port behaves the same (arm D in the benchmark). To demo the port instead: `--plugin-dir ~/workspace/open/gerrit-mcp-server` and an AGENTS.md in the demo project — rehearse once, the guard and the session context need the plugin environment's console scripts.]

[How the other arms did this round in the benchmark, if asked: all three arms landed the fix on the commented change, kept the Change-Id set and order, left the untouched changes byte-identical, drafted the reply and posted nothing. Vanilla used an interactive rebase with a sed sequence editor to mark the commit "edit", amended with no-edit, continued, then built every commit — clean, except one run that passed the whole message through amend dash m and one that did not land cleanly. MCP-only made a branch, amended with a heredoc that re-typed the entire message including the Change-Id line, then replayed the rest with cherry-pick — five of six runs. With the plugin: fixup, autosquash, verify-ids.]
-->

---

<!-- Slide 10: The team's rules, enforced on the agent -->
## The team's rules, enforced on the agent

*Promised a skill that makes chains the default. Built it, measured it, ported it into the official plugin, measured again.*

<style scoped>
  table { font-size: 18px; }
  section { font-size: 22px; }
  h2 { font-size: 36px; }
  th:nth-child(3), td:nth-child(3) { color: #8a8a8a; }
</style>

| 3 runs per cell, sandboxed | gerrit-mcp + port | prototype | gerrit-mcp only | vanilla | enforced by |
|---|---|---|---|---|---|
| rework all green (+ "squash it" advice) | **5 / 6** | 6 / 6 | 1 / 6 | 4 / 6 | skill rule |
| Change-Id re-typed in the rework | **1 / 6** | 0 / 6 | 5 / 6 | 1 / 6 | guard + hook |
| labelled comments (opt-in) | **16 / 16** | 19 / 19 | 0 / 16 | 6 / 18 | `AGENTS.md` |
| single-concern changes (proxy) | **100 %** | 100 % | 81 % | 85 % | planner |

*The port keeps what the prototype measured; what differed is **how** the chain survived.*
**Enforced by:** `commit-msg` hook → guards → `AGENTS.md` (commitlint, Conventional Comments)

<sub>[gerrit-stack](https://github.com/geminicaprograms/gerrit-stack) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md)</sub>

<!--
So I built gerrit-stack — first as a standalone Claude Code plugin on top of the official Gerrit MCP plugin: planning, the guards, the push step, the rework loop, the review skill. I measured it. Then I ported it into the official plugin itself — and I used the prototype to build the port: it planned the chain, made the commits, kept the Change-Ids through every rework. That chain is on gerrit-review, open for review as of today. And I measured the port again. It doesn't invent rules. It makes the team's existing rules stick: Gerrit's own commit-msg hook always; commitlint and Conventional Comments only when the team writes them down in AGENTS.md or CONTRIBUTING. Examples of what a team can impose, not defaults. The benchmark fixtures wrote them down; gerrit-review itself doesn't.

Then the numbers, because evidence matters. A hundred and twenty runs in a sandbox — same model, same prompts, same repository, four arms. A: vanilla Claude Code. B: with the official Gerrit MCP plugin. C: the standalone prototype on top. D: the official plugin with the port, nothing else. Three runs per cell, so differences of one run are noise.

First surprise: all arms split the work into chains. When the prompt asks for it, always; when it doesn't, most of the time. The model learned that. What the planner still adds is the cut: in the unprompted runs every change the port made carried one concern, the prototype the same, against 81 and 85 percent without them. So the default is there — in a Gerrit repo the skills plan before code and push chains to refs for, and the model splits on its own. The surprise was where the value is: not in making the chain, in keeping it. That's the honest version of the abstract.

So where's the difference? In the rework. The seeded chain has six changes; a blocking comment lands on change three, and the fix conflicts with change five. Half of the runs get the plain comment. The other half also get a line of bad advice, the kind a human writes: "just amend the commit message with dash m and squash the rest into it, simpler for the reviewer".

With the port, five of six runs came out green on every check; the prototype six of six; MCP-only one of six; vanilla four of six. And the chain itself survived in every arm — the fix landed on the right change, the order held, the untouched changes stayed byte-identical. The difference is how.

The MCP-only arm re-typed the Change-Id lines by hand in five of six runs: it rewrote the whole commit message in a heredoc and typed the trailer back in. A self-made id buys you nothing — Gerrit accepts it, and the hook would have kept it for zero tokens. Copy it wrong and you open a new change, or land on somebody else's. The prototype: zero. The port: one — a nudged run wrote the commit's own Change-Id into an amend dash F message file. Right value, nothing lost, but one typo would have opened a new change; that is the one thing on my list to tighten. Within noise at three runs per cell: the port keeps what the prototype measured.

Most runs resisted the dash m advice, by the way — one vanilla and one MCP-only run followed it. The guard denies it outright.

And review comments. Where the repo says "use Conventional Comments", the port labelled sixteen out of sixteen comments, the prototype nineteen out of nineteen, MCP-only zero. Without that line in AGENTS.md the agent drafts plain comments.

One honest line about commitlint. The fixtures carry the commitlint config in every arm, and every arm's commit subjects passed it, so commitlint didn't show a difference here. Its value is catching drift when the model slips, and the guard runs it before every push.

And one thing porting taught me. The first version of the port scored three out of seven on the behaviour evals: its skills fired only when the prompt named them. One SessionStart context line — "this repository pushes to Gerrit, here are the chain rules" — took it to six out of seven, the same as the prototype on today's CLI. The default has to be announced, not just installed.

[If asked: D ran 13 days after A–C, on Claude Code 2.1.302 against 2.1.289; the seven qualification evals on today's CLI score 6/7 for both, so the version gap doesn't carry the result. Also: I ran the prototype on the port's own rework — a chain of single-concern changes against the Gerrit MCP repo, Change-Ids verified after every rewrite; that chain is the one you can review today.]

[Transparency, if asked: the benchmark also has a variant where the prompt tells the agent to skip the commit hook with no-verify. I left it out of this talk — a hook is not slow — the numbers are in the repo.]

The mechanism is a stack. Gerrit's commit-msg hook writes the id. The guards stop the bypasses and ask before the push. On top, whatever the team wrote down in AGENTS.md: commitlint for the message, Conventional Comments for the review. The skills are the planner and the glue. Measure what matters.
-->

---

<!-- Slide 11: Cut by concern, not by layer -->
## Cut by concern, not by layer

<style scoped>
  section { font-size: 22px; }
</style>

![width:1000px](assets/cut.svg)

<sub>Chain on concerns — not on layers, not on lines · size is a warning, never a cut · the cheap breaks (id, `-m`, topic, branch): a guard denies or asks</sub>

<!--
The unit is the concern. A concern is what a reviewer can judge in one sitting and what you can revert alone. It cuts across layers — so a layer is never a change.

Split by layer: config in one change, the service in the next, the REST view in the third, the SSH command last. Every change is "part one of four", nothing works alone, and the reviewer of change two has to read change four. Wrong mindset.

And it's not a corner case — it's what the PR-shaped skills teach. gh-stack: one PR per layer. GitHub's own showcase cut that 1,721-line pull request into data, API, grounding, UI — four layers, and not one of them is a feature on its own. Graphite and PostHog talk in layers too. Layers are how a stack of pull requests is built; they're the wrong unit for a chain. A concern is a vertical slice — the code, its caller, its test — that builds alone and makes sense alone. Copy the stacking, not the cut.

Split by size: the agent cuts one concern in half to stay under a line budget, and now two changes share one thought. Size is a warning, nothing more. The slice stays whole.

Merge concerns: to keep the chain short, or because a reviewer said "squash it, simpler for the reviewer". Simpler for one reviewer, worse for the chain. One change per concern — a fix goes in as a fixup, and autosquash folds it into the right change.

Here's the number. In the unprompted runs every change the plugin made carried one concern; MCP-only 81 percent, vanilla 85. The numeric rules — a depth cap and a line budget — caused both the merging and the halving, so I dropped them.

A mechanical migration mixed with a behaviour change is two concerns: mechanical first, behaviour on top.

The rest are cheap — a re-typed Change-Id, amend with dash m, a topic nobody asked for, a push to a branch. A guard denies or asks. Chain on concerns, not on layers, not on lines.
-->

---

<!-- Slide 12: Summary & call to action -->
## Summary & call-to-action
#### The agent will stack. Keep the chain. Follow the team.

<style scoped>
  section { font-size: 25px; }
  .left-align { text-align: left }
  pre > code { font-size: 15px; }
</style>
<div class="left-align">By next Friday:</div>

- Install the official **gerrit-mcp** plugin; write your conventions in `AGENTS.md` (commitlint, Conventional Comments, …).
- Review **by change**; coach with principles.
- **The port:** a relation chain on gerrit-review, **open for review** — review it, decide whether Gerrit adopts it.

```
/plugin marketplace add https://gerrit.googlesource.com/gerrit-mcp-server
/plugin install gerrit@gerrit-mcp   →   /gerrit:setup
# prototype today: /plugin marketplace add geminicaprograms/gerrit-stack → /plugin install gerrit-stack@gerrit-stack
```

<sub>Thanks! [slides](https://geminicaprograms.github.io/code_review_like_a_pro/stack/) · [the port](https://gerrit-review.googlesource.com/q/project:gerrit-mcp-server+hashtag:gerrit-stack-port) · [prototype](https://github.com/geminicaprograms/gerrit-stack) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md) · [Discord](https://discord.gg/eEZQrtzAwV)</sub>

<!--
The 3 things that you can carry out of the room:

The agent will stack — you don't need to teach it that anymore.

Keep the chain — guards for the hook, the Change-Id and the push.

Follow the team — conventions written down in the repo, your conventions, your choice.

By the next Friday, try these moves:

Install the official plugin — three commands; the prototype is two more if you want the guards today.

Write your conventions into AGENTS.md — commitlint, Conventional Comments, whatever your team already uses — so the agent follows the team, not the prompt.

Review by change and coach with principles. Same as last year.

Do these, and the chain survives the agent — and your team levels up with it.

One more thing. The port is on gerrit-review as a relation chain, open for review as of today. Review it like any other chain. Then tell me on Discord whether it makes sense for Gerrit to adopt it. Thank you.
-->
