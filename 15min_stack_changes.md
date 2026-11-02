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
  :not(pre) > code { font-size: .78em; padding: .05em .3em; }
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

<!-- Slide 1: Title (target 0:30) -->
# How to Stack Changes like a Pro
### Chains that survive. Conventions that stick.


<sub><b>Jacek:</b> hands-on engineer & architect, code reviews daily, Gerrit maintainer</sub>
<!--
Hi, I'm Jacek. I'm a hands-on engineer and architect. I review code every day, and I maintain Gerrit.

Last year we talked about how to do code review like a pro. Today: how to stack changes like a pro.

The answer is simple again. The agent will stack. Your job is to give it the rules and the guards. Then the stack survives rework and it stays reviewable.

[alt subtitles: a. Chains that survive - and conventions the agent keeps. · b. Stacked changes, team conventions, enforced on the agent.]
-->

---

<!-- paginate: true -->
<!-- Slide 2: Last year in one slide (target 0:25) -->
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

<!-- Slide 3: Mega-PRs faster than review (target 0:40) -->
## Mega-PRs faster than review

- **Faros 2025:** PR size **+154 %**, review time **+91 %**
- **Faros 2026:** time in code review **+200 %**, time to first review **+157 %**
- **LinearB 2026**, 8.1 M PRs: AI PRs **~2.5× bigger**, wait **>16 h** for a reviewer (was ~200 min)
- **Anthropic 2026:** output per engineer **+200 %** - *"code review has become a bottleneck"*
- **GitHub 2026:** a **1,721-line** agent PR → a **4-layer** stack

#### Review is the new bottleneck.

<sub>[Faros 2025](https://www.faros.ai/blog/ai-software-engineering) · [Faros 2026](https://www.faros.ai/blog/ai-acceleration-whiplash-takeaways) · [LinearB](https://linearb.io/blog/8-million-prs-engineering-productivity) · [Anthropic](https://claude.com/blog/code-review) · [GitHub](https://github.blog/engineering/turn-one-giant-ai-generated-pull-request-to-a-reviewable-stack/)</sub>

<!--
Here's the data. Four sources, one picture. Pull requests got bigger, and review got slower. The interesting one is GitHub engineering, in August. One agent pull request, 1,721 lines. Their fix? They cut it into a stack of four layers - data, API, grounding and UI - four layers out of one pull request.

Anthropic says it in their own words: "code review has become a bottleneck".
-->

---

<!-- Slide 4: Meme (target 0:15) -->
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

<!-- Slide 5: Welcome to 2008 (target 1:00) -->
## Welcome to 2008

- **2010s** Phabricator at Meta: stacked diffs
- **2022** Meta open-sources **Sapling** + ReviewStack
- **2025-12** **Graphite** acquired by Cursor
- **2026-07** **GitHub stacked pull requests**, public preview, `gh-stack`

#### Gerrit, October 2008: one commit per change, uploaded in series - day one.

<sub>[Gerrit's first commit, 2008-10-21](https://gerrit.googlesource.com/gerrit/+/38966837f9f0b331b3cafa3dccb8b41f8c42c671) · [review.source.android.com, Dec 2008](https://web.archive.org/web/20081202081235/http://review.source.android.com/) · [GitHub preview](https://github.blog/changelog/2026-07-30-stacked-pull-requests-are-now-in-public-preview/) · [Gerrit 3.8](https://www.gerritcodereview.com/3.8.html)</sub>

<!--
So everybody arrives at the same answer: small changes, stacked.

Meta had stacked diffs in Phabricator for over ten years, and in 2022 they open-sourced Sapling. Graphite built a business on stacked pull requests; in December, Cursor bought them. In July, GitHub shipped stacked pull requests as a public preview.

Welcome to 2008. Gerrit 1.0 reviewed the Android Open Source Project from its launch in October 2008. One commit per change, a series of commits reviewed as a chain, on day one. The Change-Id footer came in 2009, and since 3.8 you rebase a whole chain with one click.

And the Change-Id isn't only ours anymore: in 2025, Gerrit, GitButler and Jujutsu agreed to share it.

Now let me show you what a good chain looks like.
-->

---

<!-- Slide 6: What a good chain looks like, in practice (target 1:15) -->
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
Four things, plus one rule for the repo.

First, one concern per change. It builds on its own, it carries its tests and docs, it's green in CI, and you can revert it alone.

Second, size is a warning, not a target. SmartBear says 200 to 400 lines per sitting. But a migration or a rename stays one change. Don't cut it to hit a number.

Third, chain length follows the concerns. Any length is fine, as long as the bottom keeps landing.

Fourth, the chain survives the rework. An agent amends and rebases a lot, and every step has to keep the Change-Id. The honest number: in 30,000 Gerrit chains, chain changes merged 2.6 times slower, and a third were restructured in review. Restacking is the price of a chain. Pay it with tooling, not with authors.

And the rule for the repo: conventions travel with it, written down in AGENTS.md. The agent follows the team, not the chat.

That's the target. Here is how an agent misses it.
-->

---

<!-- Slide 7: Where an agent breaks the chain (target 1:15) -->
## Where an agent breaks the chain

<style scoped>
  section { font-size: 21px; }
  h2 { font-size: 38px; }
</style>

![width:800px](assets/chain.svg)

⓪ **wrong cut** - layers, halves, merged concerns &nbsp;·&nbsp; ① hand-made Change-Id
② `--amend -m` &nbsp;·&nbsp; ③ `push … refs/heads/*` → no review
④ team conventions missed → a human fixes the chain before the push

<!--
You know this picture. Three commits, one push, three changes in a chain. Amend the middle one, push again: new patch sets, same Change-Ids.

What's new is the author. An agent walks through this many times a day, and it can break it in multiple places.

Number zero, and the biggest, is the cut itself: layers instead of concerns, a concern cut in half, two concerns merged. No guard catches that; only the plan does. More on it at the end.

One: a hand-made Change-Id. One typo, and Gerrit opens a new change, or lands on somebody else's.

Two: amend with dash m. The trailer is gone, and the old change is orphaned with its review.

Three: a push to refs heads instead of refs for. The review is simply skipped or closed.

Four: the team's conventions. Commit style, review labels. The agent follows what it can read; a rule that lives only in a tool's config, it never sees. So a human fixes the message, or labels the comment, before the push. That's a broken chain too, just a quieter one: the agent did the work, and you did the rework.

None of them is free: the agent burns tokens, and a human cleans up.

The pull-request world ships skills for this. None of them is built for Gerrit. The official plugin has a part of it.
-->

---

<!-- Slide 8: The PR world ships agent stacking skills. Gerrit ships half of one. (target 1:05) -->
## The PR world ships agent stacking skills. Gerrit ships half of one.

- *Everyone else:* gh-stack, Graphite, GitButler, Cursor, PostHog, thoughtbot, Codex - all PR-shaped; small single-purpose changes; two plan first; **none asks before the push**.
- *Gerrit:* the official plugin reviews; `gerrit-workflow` knows `refs/for` and chains - no planning, no guards, no push. **The gap.**
- *The proposal:* an **author workflow** for the official plugin - open for review on gerrit-review.

<sub>[gh-stack](https://github.com/github/gh-stack) · [Graphite](https://github.com/withgraphite/agent-skills) · [gerrit-mcp](https://github.com/GerritCodeReview/gerrit-mcp-server)</sub>

<!--
Everybody else already ships something for coding agents. All of it is PR-shaped. GitHub's gh-stack and PostHog have a stacking skill, Graphite a how-to for its CLI, GitButler and Cursor split finished work into PRs. Two of them plan before the code. Most want small, single-purpose changes. Not one asks you before the push. And the word GitHub and PostHog use for a step is "layer".

Gerrit has the official MCP plugin. It's good on the review side, and its gerrit-workflow skill knows refs for and chains. But it has no planning step, no guards and no push step. That's the gap.

So I built the missing half: an author workflow for the official plugin. First as a standalone prototype, then ported upstream, open for your review on gerrit-review. Here it is, one round.
-->

---

<!-- Slide 9: The author workflow, in one round (target 1:50) -->
## The author workflow, in one round

<style scoped>
  section { font-size: 22px; }
</style>

![width:1040px](assets/proposal.svg)

<sub>[the proposal on gerrit-review](https://gerrit-review.googlesource.com/c/gerrit-mcp-server/+/648752) · [try it yourself](TODO-try-it-link)</sub>

<!--
Here's the proposal, end to end.

A plain feature request comes in: three behaviours, no Gerrit words, no "split it" instruction. The planner cuts it into concerns and proposes three steps, one per behaviour. You say yes. That's the first time it asks you.

Then the chain: three commits, one per concern. The Change-Id comes from the commit-msg hook, the subject in the style your repo documents. The guard sits right here: no hand-written Change-Id, no amend dash m, no no-verify.

Then the push. The whole chain, one push, to refs for, and it asks you first. That's the second yes. On the server: three changes, one relation chain.

Then review. A reviewer leaves a blocking comment on the middle change. The review skill reads the threads and drafts the replies. The fix goes in as a fixup, autosquash folds it into the right change, the Change-Ids are checked, and the whole chain is pushed again. The middle change gets patch set two, the one above is rebased, the one below is untouched. Then it shows you the replies and asks. Third yes. Nothing is posted before it.

Three times it asks you: the plan, the push, the reply. Everything in between is the agent's work, inside the guards. And the conventions come from the repo, not from the prompt.

Did it hold beyond one round? I measured it.

[TODO try-it-link: a short "try it yourself" page for the audience. Content: (1) fetch the author-workflow chain from gerrit-review into a gerrit-mcp-server checkout (git fetch the tip change's ref, or clone + fetch by change number); (2) install the plugin from that checkout: claude plugin marketplace add <checkout path> → claude plugin install gerrit@gerrit-mcp, or per session claude --plugin-dir <checkout>; build its environment (uv sync) so the guard and session context have their console scripts; (3) point it at a Gerrit host with /gerrit:setup; (4) in any Gerrit-backed repo with an AGENTS.md: a plain feature request → plan → chain → push question → review round. Could live as docs/try-it.md in gerrit-mcp-server (in the chain) or in gerrit-stack. Link goes on slides 9 and 12.]

[If asked how the other arms reworked: all landed the fix on the right change and kept the Change-Id set; vanilla used rebase -i "edit" + amend --no-edit; MCP-only rewrote the message in a heredoc and re-typed the Change-Id in five of six runs; the plugin: fixup, autosquash, verify-ids.]
-->

---

<!-- Slide 10: The team's rules, enforced on the agent (target 1:55 -->
## Does the chain survive?

<style scoped>
  table { font-size: 18px; }
  section { font-size: 22px; }
  h2 { font-size: 36px; }
  th:nth-child(3), td:nth-child(3) { color: #8a8a8a; }
</style>

| 3 runs per cell | gerrit-mcp + author workflow | prototype | gerrit-mcp only | vanilla | enforced by |
|---|---|---|---|---|---|
| unprompted runs that produced a chain | **6 / 6** | 6 / 6 | 6 / 6 | 6 / 6 | the model |
| rework all green (+ "squash it" advice) | **5 / 6** | 6 / 6 | 1 / 6 | 4 / 6 | skill rule |
| Change-Id re-typed in the rework | **1 / 6** | 0 / 6 | 5 / 6 | 1 / 6 | guard + hook |
| labelled comments (opt-in) | **16 / 16** | 19 / 19 | 0 / 16 | 6 / 18 | `AGENTS.md` |

*The author workflow keeps what the prototype measured; what differed is **how** the chain survived.*

<sub>[gerrit-stack](https://github.com/geminicaprograms/gerrit-stack) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md)</sub>

<!--
A hundred and twenty sandboxed runs. Same model, same prompts, four arms: vanilla, the official plugin, the prototype, and the official plugin with the author workflow. Three runs per cell, so one run of difference is noise.

First surprise: every arm splits the work into chains. Six of six unprompted runs, in every arm. Even vanilla Claude Code pushed a three-change chain without being asked. The model learned that. So the default is there; the value is in keeping the chain.

The difference is the rework. Six changes, a blocking comment on change three, and the fix conflicts with change five. And half the runs get bad advice: "amend with dash m and squash the rest".

With the author workflow, five of six runs were green on every check. The prototype six, MCP-only one, vanilla four. The chain survived in every arm; the difference is how. The MCP-only arm re-typed the Change-Id by hand in five of six runs. Right value, zero benefit, and one typo opens a new change. The author workflow retyped it once. Nothing was lost, but it's on my list to tighten.

And review comments, where the repo says "use Conventional Comments": the author workflow labelled sixteen of sixteen. MCP-only: none.

Within noise, the author workflow keeps what the prototype measured.

[If asked: D ran 13 days after A–C, Claude Code 2.1.302 vs 2.1.289; the seven qualification evals score 6/7 for both on today's CLI. Commitlint showed no difference: every arm's subjects passed it; its value is catching drift.]

[If asked: the benchmark also has a "skip the hook with no-verify" variant; left out - a hook is not slow - numbers in the repo.]
-->

---

<!-- Slide 11: Cut by concern, not by layer (target 2:05) -->
## Cut by concern, not by layer

<style scoped>
  section { font-size: 22px; }
</style>

![width:1000px](assets/cut.svg)

<sub>Chain on concerns - not on layers, not on lines.</sub>

<!--
Back to break number zero, the one no guard can catch: the cut.

A concern is what a reviewer can judge in one sitting, and what you can revert without unpicking the rest. It runs through every layer it needs. That's why a layer is never a change.

Take the request on top: three behaviours. Look at the left side. Config in one change, then the service, then REST, then SSH. "Part one of four." Nothing works on its own, and the reviewer of part two has to read part four to understand it. That's exactly what gh-stack and PostHog teach. GitHub's own showcase cut its 1,721 lines into data, API, grounding and UI. Not one of those four is a feature.

Now the right side: the REST greeting with its setting, the SSH command, the per-project override. Each slice is one behaviour: the code, its caller and its test, through every layer it touches. It builds on its own, and it reads on its own. And the revert is honest: the SSH command and the override come out on their own. In the layer stack, reverting one means reverting all. So copy the stacking, not the cut.

Two more ways to get it wrong. Splitting by size: a big slice is a warning for the reviewer, not a reason to cut it in half. And merging concerns because someone says "just squash it": a fix goes in as a fixup, into the change it belongs to.

Everything else on that list is cheap: a guard denies it or asks. Chain on concerns, not on layers, not on lines.
-->

---

<!-- Slide 12: Summary & call to action (target 1:30) -->
## Summary & call-to-action
#### The agent will stack. Let it keep the chain. Follow the team.

<style scoped>
  section { font-size: 25px; }
  .left-align { text-align: left }
  pre > code { font-size: 15px; }
</style>
<div class="left-align"><b>By next Friday:</b></div>

- Install the **author workflow** from its chain on gerrit-review; then review it: should Gerrit adopt it?
- Let it **cut by concern** - one behaviour per change, the test inside - and do the stack and the rework.
- Write the team's conventions in `AGENTS.md`; the agent follows the team.

```
git clone https://gerrit.googlesource.com/gerrit-mcp-server && cd gerrit-mcp-server
git fetch origin refs/changes/52/648752/1 && git checkout FETCH_HEAD
claude plugin marketplace add "$PWD" && claude plugin install gerrit@gerrit-mcp   →   /gerrit:setup
```

<sub>Thanks! [slides](https://geminicaprograms.github.io/code_review_like_a_pro/stack/) · [the proposal on gerrit-review](https://gerrit-review.googlesource.com/c/gerrit-mcp-server/+/648752) · [benchmark](https://github.com/geminicaprograms/gerrit-stack/blob/main/docs/benchmark.md) · [Discord](https://discord.gg/eEZQrtzAwV)</sub>

<!--
Three things to take home.

The agent will stack. You don't need to teach it that anymore.

Let it keep the chain. The guards sit where it breaks: the Change-Id, the amend, and the push.

Follow the team. Write your conventions in the repo, and the agent follows the team, not the prompt.

By next Friday, three things. First, install the author workflow. The official plugin gives you the review side; the author side is the chain on gerrit-review. The three lines are on the slide. Second, let it do the cut. The planner splits the request by concern - one behaviour per change, the test inside - and you say yes, or move a line. Third, put two team rules into the AGENTS.md you already have: your commit style and your review labels. The agent follows the team.

One more thing. That chain is open for review as of today. Review it like any other chain. All comments are welcome, on the changes or on Discord. Thank you.

[The fetch line points at patch set 1 of the tip change, 648752. A new patch set changes the /1. The change is private until you flip it; flip it before the talk, or the room gets a 404. The "try it yourself" page carries the long form incl. uv sync.]
-->
