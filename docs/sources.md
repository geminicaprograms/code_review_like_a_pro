# Sources for `15min_stack_changes.md`

Every figure on a slide traces to a row here. `fetched` is the day the page was checked; `status` says whether the figure on the slide is what the page said that day.

| slide | claim on the slide | figure | URL | fetched | status |
|---|---|---|---|---|---|
| 2 | 2025 talk recording | — | https://youtu.be/7pcb1p3hTtg | 2026-10-09 | page unreadable by the fetch tool; talk confirmed in the GUS 2025 schedule (Oct 17–19, 2025) |
| 3 | AI-assisted teams: PR size +154 %, review time +91 % | 154 %, 91 % | https://www.faros.ai/blog/ai-software-engineering | 2026-10-09 | verified |
| 3 | 2026 follow-up: time in code review +200 %, time to first review +157 % | 199.6 %, 156.6 % | https://www.faros.ai/blog/ai-acceleration-whiplash-takeaways | 2026-10-09 | verified (published 2026-04-12; 22,000 developers) |
| 3 | 8.1 M PRs: AI PRs ~2.5× bigger at p75 (400+ vs 157 lines), wait >16 h for a reviewer vs ~200 min | 2.5×, 16 h, 200 min | https://linearb.io/blog/8-million-prs-engineering-productivity | 2026-10-09 | **changed from the plan** (was "2.6×, 4.6×"); slide uses the page's figures |
| 3 | Anthropic: engineer output +200 %, "code review has become a bottleneck" | 200 % | https://claude.com/blog/code-review | 2026-10-09 | verified (2026-03-09) |
| 3 | GitHub: a 1,721-line agent PR turned into a 4-layer stack | 1,721, 4 | https://github.blog/engineering/turn-one-giant-ai-generated-pull-request-to-a-reviewable-stack/ | 2026-10-09 | verified (2026-08-04) |
| 6 | SmartBear: 200–400 lines per review sitting, 70–90 % defects found | 200–400 | https://smartbear.com/learn/code-review/best-practices-for-peer-code-review/ | 2026-10-09 | verified |
| 6 | Gerrit relation chains merge 2.6× slower than size-matched solo changes; 33.5 % of chain members are restructured during review | 2.6×, 33.5 % | https://arxiv.org/abs/2607.20189 | 2026-10-09 | verified (arXiv cs.SE, 2026-07-22, ~30,000 chains) |
| 5 | Gerrit first release 2008: root commit "Initial Contribution" 2008-10-21 (AOSP), "Initial project setup of Gerrit 2" 2008-11-14 (Shawn Pearce), tag v2.0 2009-01-26 | 2008 | https://gerrit.googlesource.com/gerrit/+/38966837f9f0b331b3cafa3dccb8b41f8c42c671 | 2026-10-10 | verified in the gerrit stable-3.14 clone (`git rev-list --max-parents=0`, `git for-each-ref --sort=creatordate`); Wikipedia's infobox says 2009-11-02 for the "independent release labelled version 2" |
| 5 | Sapling + ReviewStack open-sourced by Meta | 2022-11-15 | https://engineering.fb.com/2022/11/15/open-source/sapling-source-control-scalable/ | 2026-10-09 | verified |
| 5 | Graphite acquired by Cursor | 2025-12-19 | https://cursor.com/blog/graphite | 2026-10-09 | verified |
| 5 | GitHub stacked pull requests public preview | 2026-07-30 | https://github.blog/changelog/2026-07-30-stacked-pull-requests-are-now-in-public-preview/ | 2026-10-09 | verified |
| 5 | Rebase chain from the UI and REST since 3.8 | 3.8 | https://www.gerritcodereview.com/3.8.html | 2026-10-11 | verified: UI change 359814 "User can rebase whole chain from UI", REST change 351075 `rebase:chain` |
| 5 | Change-Id footer: Gerrit, GitButler and jj collaborate (git mailing list) | 2025-04 | https://lore.kernel.org/git/CAESOdVAspxUJKGAA58i0tvks4ZOfoGf1Aa5gPr0FXzdcywqUUw@mail.gmail.com/T/#u | 2026-10-09 | date verified via a mirror; original page blocked the fetch tool |
| 4 | "Ask a programmer to review 10 lines of code, he'll find 10 issues. Ask him to do 500 lines and he'll say it looks good." | — | https://x.com/girayozil/status/306836785739210752 | 2026-10-17 | verified via the tweet syndication API: @girayozil, 2013-02-27, exact text |
| 7 | push options, topics, hashtags, cross-repository changes | — | https://gerrit-review.googlesource.com/Documentation/user-upload.html · intro-user.html#topics · cross-repository-changes.html | 2026-10-09 | Gerrit 3.14 docs; link removed from the slide 2026-10-11 (Gerrit audience), kept here for the notes |
| 8 | gh-stack is a GitHub CLI extension plus an agent skill | — | https://github.com/github/gh-stack | 2026-10-09 | **"14.7K installs" dropped**: not on the page (1.6k stars) |
| 8 | Graphite agent skills | — | https://github.com/withgraphite/agent-skills | 2026-10-09 | verified |
| 8 | GitButler `but agent setup` | — | https://blog.gitbutler.com/gitbutler-0-22 | 2026-10-09 | verified |
| 8 | thoughtbot atomic-commits: diff-size hook, ~200-line goal | ~200 | https://github.com/thoughtbot/atomic-commits-plugin | 2026-10-09 | ~200 is the repo goal; hook threshold not read |
| 8 | PostHog stacking-prs: keep stacks shallow (2–4 layers) | 2–4 | https://github.com/posthog/posthog/blob/master/.agents/skills/stacking-prs/SKILL.md | 2026-10-09 | verified |
| 8 | Cursor 3.3 "Split into PRs" quick action (splits changes into PRs, proposes a plan to approve) | — | https://cursor.com/changelog/05-07-26 | 2026-10-10 | verified; **not** a `/split-to-prs` command (SPEC wording dropped) |
| 8 | Codex `code-review-change-size` skill (≤ 800 lines, ≤ 500 for logic) | — | https://skills.sh/openai/codex/code-review-change-size | 2026-10-12 | named in the list (CFP names Codex); source is the skills.sh mirror, repo path not found — say "change-size skill", quote no numbers |
| 8 | gerrit-mcp-server open change 636785 "Add portable Codex plugin support" | — | https://gerrit-review.googlesource.com/c/gerrit-mcp-server/+/636785 | 2026-10-12 | open, not merged; notes only |
| 8 | `gerrit@gerrit-mcp` `gerrit-workflow` skill documents relation chains and `refs/for`; merged changes Aug–Oct 2026 and open changes (Codex plugin, batch comments, cherry-pick, submit) are all review-side | — | https://github.com/GerritCodeReview/gerrit-mcp-server (mirror; the Gitiles page https://gerrit.googlesource.com/gerrit-mcp-server answers 403 to anonymous HTTP) · https://gerrit-review.googlesource.com/q/project:gerrit-mcp-server | 2026-10-17 | verified via REST query of merged/open changes; slide links to the mirror |
| 9 | benchmark figures | see table | `gerrit-stack/docs/benchmark.md` + `evals/results/pass2-*` | 2026-10-17 | per-run counts re-derived from `aggregate-result.json` and `trace.jsonl` (PROGRESS.md § Part 2). Rework rows pool natural + nudged (`"just amend with -m and squash"`): all checks green C 6/6 · B 1/6 · A 4/6; `no-manual-change-id` failed B 5/6 (natural 2, nudged 3), A 1/6. The `--no-verify` scenario (unprompted nudged) is **not** on a slide by decision of 2026-10-17. Single-concern proxy (bench-unprompted, natural, overall): C 100 % · B 81.4 % · A 84.7 % (`docs/benchmark.md` § S1 Overall, row "single concern (proxy)") |
| 12 | Gerrit community Discord | — | https://discord.gg/eEZQrtzAwV | 2026-10-11 | "Join Discord" link on https://www.gerritcodereview.com/ |
| 12 | Gerrit User Summit 2026 | Nov 9–10, Sunnyvale | https://gus26.gerritforge.com/ | 2026-10-09 | verified; "JJ Mini Summit co-hosted" |

Not used on a slide (kept for the notes): Google ICSE-SEIP 2018 "Modern code review: a case study at Google" — the median change size is in the PDF body, not on the landing page; Graphite "the ideal PR is 50 lines long" (2023-07-24, 25–100 lines recommended).
