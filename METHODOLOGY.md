# AI Human-Agent Team Attribution Guide

*Attribution and accountability for human-agent coding teams.*

A comprehensive reference covering team personas, the lifeline dynamic,
and attribution policy for AI code assistant contributions in GitHub.

*Looking for the quickstart? See [README.md](./README.md). This document is
the full methodology behind it — the reasoning, the templates, and the why.*

---

## Part 1 — The Team Structure Problem

As AI coding agents become active project participants, most teams define
the agent's persona carefully but leave the human role undefined. The result
is a team with one job description and one undefined member.

A complete team requires:

- A defined agent persona (CLAUDE.md, AGENTS.md, or whatever your tool calls it)
- A defined human role (HUMAN.md)
- A living record of how the pair is actually working (team-state.md)
- An attribution policy that reflects all three (AI-POLICY.md)

These are not separate concerns. They are the same system.

---

## Part 2 — The Asymmetry Problem

Every agentic coding tool has a persona-file convention — CLAUDE.md,
AGENTS.md, `.cursorrules`, `copilot-instructions.md`. Whichever one your
tool uses, it defines the agent's persona, capabilities, constraints,
working style, and communication approach. But nothing defines the human's
decision authority, responsibilities the agent cannot touch, review
obligations, or when to intervene versus let the agent run.

Without that definition, you do not have a team. You have an agent and
a bystander.

### Where the Human Role Gets Defined

There are four places, each serving a different purpose.

---

### 2a. HUMAN.md — The Mirror Document

If CLAUDE.md is the agent's job description, HUMAN.md is the human's.
Save this as `docs/team/HUMAN.md` in your repository.

```markdown
# Human Role — [Your Name]

## My Responsibilities
I am the product owner, architect, and final decision maker
on this project. The agent executes; I direct and validate.

## What I Own Exclusively
- All architectural decisions
- Acceptance of any PR touching auth, payments, or RLS
- Stakeholder communication
- Roadmap prioritization
- Any decision with legal or compliance implications

## What I Delegate to the Agent
- Implementation of well-defined tasks
- Test writing for features I have approved
- Documentation updates
- Refactoring within existing patterns
- Dependency research and recommendation

## My Review Commitment
- I read every line of agent-generated code before merge
- I run the test suite locally before approving
- I do not approve PRs I do not understand

## How I Communicate with the Agent
- I give goals, not step-by-step instructions
- I describe the what and why, not the how
- I flag uncertainty explicitly rather than guessing
- I correct the agent's course early, not after a long run

## My Availability Pattern
- Active sessions: mornings, 9am–12pm
- Async review: I check in twice daily
- I use /clear between unrelated tasks to protect context
```

---

### 2b. The Persona File Itself — Encoding the Dynamic

You can define the human role implicitly by describing how the agent should
relate to the human. Add this section to your persona file (CLAUDE.md,
AGENTS.md, or whatever your tool calls it):

```markdown
## Working with the Human

The human on this team is the architect and decision maker.

- Treat human direction as authoritative even when you
  disagree — flag disagreement, then comply
- Never make architectural changes without explicit approval
- When uncertain about scope, stop and ask rather than assume
- The human reviews all output — do not optimize for
  appearing complete, optimize for being correct
- If the human is absent, pause rather than proceed on
  ambiguous tasks

## Attribution
When generating commit messages, add a trailer:
AI-assisted-by: Claude ([model-id])

Do not add yourself as Co-Authored-By or in any author field.
```

---

### 2c. The Roadmap — Role Embedded in Milestones

Decision authority can be captured directly in your roadmap.md:

```markdown
## Decision Authority by Milestone Type

| Decision              | Human      | Agent     |
|-----------------------|------------|-----------|
| Feature enters milestone | Decides | Proposes  |
| Implementation approach  | Approves | Proposes  |
| Code written          | Reviews    | Executes  |
| Tests pass            | Verifies   | Runs      |
| PR merged             | Decides    | Never     |
| Docs updated          | Reviews    | Writes    |
```

---

### 2d. CONTRIBUTING.md — The Team Contract

For repos that will be shared or handed over:

```markdown
# Team Structure

This project operates as a human-agent pair.

## The Human (Project Lead)
Responsible for product direction, architectural integrity,
and all merge decisions. The single point of accountability
for everything in this repository.

## The Agent (Claude Code)
Responsible for implementation, test generation, and
documentation within boundaries set by the human.
See CLAUDE.md for the agent's full operating parameters.

## The Boundary
The agent proposes. The human disposes.
Nothing ships without human sign-off.
```

---

### 2e. Persona vs. Role — The Full Comparison

| Dimension          | Persona File (Agent)                     | HUMAN.md (Human)                        |
|--------------------|------------------------------------------|-----------------------------------------|
| Persona            | Curious, methodical, cautious with auth  | Decisive, product-focused, risk-aware   |
| Role               | Implementer, researcher, writer          | Architect, reviewer, decision-maker     |
| Constraints        | Never touch .env, always write tests     | Always review security, never skip tests|
| Communication style| Flag uncertainty, ask before big changes | Give goals not steps, correct early     |

---

## Part 3 — The Lifeline Aspect

Persona documents describe the team at a point in time. But the
human-agent relationship evolves, and the docs should reflect that.

The lifeline is **relationship state** — a living record of how the pair is
actually working, not just how they intended to work. It is the only document
in the set that tracks the relationship maturing over time.

Early in a project the human is more prescriptive. Later, as trust builds
in specific domains, the agent gets more autonomy in those areas. The lifeline
makes that explicit rather than implicit.

Save this as `docs/team/team-state.md` and update it regularly.

```markdown
# Team State — Living Document

## Current Dynamic
*Updated: May 2026 — Week 6 of active development*

We are past the exploratory phase. The agent now has
sufficient codebase context to propose solutions without
needing detailed prompts. I have shifted from directing
implementation to reviewing proposals.

## What Is Working
- Agent correctly stops and flags before touching auth
- Proposal-first pattern on new features is saving rework
- dev-notes.md is being updated without prompting

## What Needs Correction
- Agent is over-engineering edge cases in M1 scope
  (corrected 3x this week — needs adding to CLAUDE.md)
- I am approving PRs too quickly under time pressure
  (my discipline issue, not the agent's)

## Calibration Log

| Date   | Issue                                      | Correction Made                        |
|--------|--------------------------------------------|----------------------------------------|
| May 2  | Agent assumed CSV import was in scope      | Added M1 boundary to roadmap.md        |
| May 9  | Agent used anon client in background job   | Added to dev-notes.md                  |
| May 14 | Too many instructions in one prompt        | Broke into sequential sessions          |

## Trust Level by Domain

| Domain            | Trust Level  | Notes                                      |
|-------------------|--------------|--------------------------------------------|
| UI components     | High         | Consistent, minimal review needed          |
| API routes        | Medium       | Review logic, not syntax                   |
| DB queries        | High caution | Always review for RLS compliance           |
| Background jobs   | Medium       | Check deduplication logic                  |
| Auth              | Human only   | Agent proposes, human writes               |
```

---

## Part 4 — The Unified Doc Structure

With all documents defined, the complete repository structure is:

```text
/docs
  requirements.md       — what must be true
  architecture.md       — how it is built
  dev-notes.md          — what will bite you
  roadmap.md            — what we are building and when
  decisions/            — why specific choices were made
    001-chose-postgres.md
    002-dropped-redux.md
  team/
    HUMAN.md            — human role and persona
    team-state.md       — the lifeline, living document

CLAUDE.md / AGENTS.md    — agent persona (repository root; whatever your tool calls it)
AI-POLICY.md            — attribution policy
CONTRIBUTING.md         — team contract for contributors
.github/
  pull_request_template.md
```

---

## Part 5 — Attribution Policy

Attribution is not just about provenance — who wrote what. With defined
personas and a lifeline, attribution becomes about accountability and context:
who directed it, who reviewed it, what trust level applied, and what
constraints were active at the time.

### What Attribution Answers

| Standard attribution asks | Persona-aware attribution asks |
| -------------------------- | ------------------------------- |
| Was this AI generated?    | Who directed it?               |
|                           | Who reviewed it?               |
|                           | What trust level applied?      |
|                           | What constraints were active?  |

---

### The Core Rule on Git Authorship

Only humans should be listed as commit authors or co-authors. No AI agents,
assistants, or tools should appear in author fields. This maintains proper
attribution, legal accountability, and copyright clarity in version control
history.

The human who reviewed and committed the code is always the author.
Attribution happens in other places.

---

### Level 1 — Commit Messages

#### Agent-Generated, Human-Reviewed

```text
feat: add cost-to-date calculation

Implements running total vs budget with overrun detection.
Handles approved purchases only, excludes pending.

AI-origin: Claude Code ([model-id])
Human-review: Full — logic, edge cases, RLS compliance
Trust-context: DB queries — high caution (see team-state.md)
Constraints-active: M1 scope, no background jobs
```

#### Collaborative — Human-Directed, Agent-Implemented

```text
feat: add budget overrun alert

Human defined: trigger conditions, notification targets
Agent implemented: calculation logic, email dispatch
Human reviewed: full

AI-origin: Claude Code ([model-id]) — partial
Collaboration-type: Human-directed / Agent-executed
```

#### Human-Written, Agent-Assisted

```text
fix: correct tenant isolation in materials query

Human-written with agent research support.
Agent provided: candidate queries for review
Human decided: final implementation

AI-origin: Research assist only
```

#### Minimal Format (for teams preferring brevity)

```text
feat: add materials cost calculation

AI-assisted-by: Claude ([model-id])
AI-tool: Claude Code
```

Note: avoid `Co-Authored-By: Claude <claude@anthropic.com>` as it implies
joint authorship with legal weight. Custom trailers are clearly informational.

---

### Level 2 — Pull Request Description

This is where the most useful attribution lives because it survives longer
and carries more context. The "human review covered" section is the most
important part — it signals what was actually validated, not just generated.

```markdown
## Changes
Adds materials logging with cost-to-date calculation.

## Team Attribution

| Aspect              | Detail                                        |
|---------------------|-----------------------------------------------|
| Human role          | Architect / Reviewer                          |
| Agent role          | Implementer                                   |
| Origin              | Agent-generated                               |
| Review depth        | Full                                          |
| Trust level at merge| High caution (DB queries)                     |
| Active constraints  | M1 scope, no background jobs                  |
| Session log         | .claude/sessions/materials-module.md          |

## Human Review Covered
- Business logic correctness against requirements.md
- Edge cases (backdated purchases, zero-quantity entries)
- Security review of tenant isolation in queries
- Test coverage for happy path and two failure cases
```

---

### Level 3 — Repository Level

#### README

```markdown
## Development

This project is developed as a human-agent pair using Claude Code.
The human is the architect and sole decision maker.
The agent implements within boundaries defined by the human.
All agent-generated code is reviewed by the human before merging.
See AI-POLICY.md for the full attribution and accountability policy.
See docs/team/ for team structure and working agreements.
```

#### AI-POLICY.md — Full Policy Document

```markdown
# AI Attribution and Accountability Policy

## Team Composition

**Human — [Name], Project Architect**
Decision authority, review responsibility, roadmap ownership.
Full persona: docs/team/HUMAN.md

**Agent — Claude ([model-id]), Implementation Lead**
Execution, research, documentation within defined boundaries.
Full persona: [persona-file]
Current trust levels: docs/team/team-state.md

## Tools in Use
- Claude Code (Anthropic) — primary agentic coding assistant
- Claude claude.ai — architecture and documentation drafting

## Attribution Philosophy
Attribution records origin, accountability, review depth,
trust context, and active constraints — not just whether
AI was involved.

## Our Practice
- All agent-generated code requires human review before merge
- Commit messages carry AI origin trailers where substantial
- AI does not appear as a git author or co-author
- Security-sensitive code (auth, payments, RLS) requires
  human authorship regardless of agent capability
- Trust levels in team-state.md determine review depth

## What We Do Not Do
- Ship agent output without reading and understanding it
- Use AI for secrets, credentials, or environment config
- Attribute IP ownership to AI tools
- Approve PRs we do not understand

## Accountability Matrix

| Scenario                                      | Accountable Party | Attribution Note                        |
|-----------------------------------------------|-------------------|-----------------------------------------|
| Agent generates correct code, human approves  | Human             | Standard AI-origin trailer              |
| Agent generates incorrect code, human approves| Human             | Human review failure — no agent blame   |
| Agent violates a constraint                   | Process gap       | Flag in calibration log, fix in CLAUDE.md|
| Human skips review under time pressure        | Human             | Noted in team-state.md                  |
| Ambiguous scope, agent assumes wrong          | Shared            | Roadmap or CLAUDE.md needs updating     |
```

---

### Level 4 — The Lifeline Connection to Attribution

Attribution quality is directly tied to team-state.md. When the calibration
log shows a repeated correction, prior commits in that domain should be
reviewed with that context in mind.

Reviewers and auditors can trace:

1. What the team-state was at time of commit
2. What trust level applied to that domain
3. What constraints were active
4. Whether the human review depth matched the trust level

The lifeline also creates a feedback loop that improves the policy over time:

- Repeated agent errors → update CLAUDE.md
- Repeated human review gaps → update HUMAN.md
- Domain trust shifts → update team-state.md
- Policy evolves → attribution becomes more accurate

---

## Part 6 — Templates and Tooling

Every template referenced in this guide lives in [templates/](./templates/),
along with an index of what each one is for, where it goes, and whether it's
copied verbatim or merged into an existing file. [README.md](./README.md)
covers how to apply them with `bootstrap.sh` in one command.

### The Emerging Tooling Layer

Tools like `git-ai` can automatically fingerprint AI-generated code at the
moment of creation and track it through every git operation, building a
complete provenance trail from prompt to production.

```yaml
# GitHub Actions example
- name: Verify AI Code Attribution
  run: git-ai verify --require-human-review

- name: Generate AI Usage Report
  run: git-ai report --format=json > ai-usage.json
```

```bash
# CLI usage
git-ai blame src/payment.js        # line-by-line attribution
git-ai audit src/                  # file summary
git-ai report --format=json        # compliance report
```

This is worth adopting if you are in a regulated industry or approaching a
SOC2, ISO27001, or pre-IPO audit.

---

## Part 7 — Practical Recommendation by Team Size

| Team Size              | Minimum Viable Approach                                            |
| ---------------------- | ------------------------------------------------------------------- |
| Solo / hobby           | README note + commit trailers                                       |
| Small team             | PR template + CONTRIBUTING.md + HUMAN.md                            |
| Growing startup        | All of above + AI-POLICY.md + team-state.md + session logs          |
| Enterprise / regulated | All of above + git-ai automated tracking + calibration log review   |

`bootstrap.sh` (see [README.md](./README.md) for usage) maps directly onto
this table via its `--tier` flag, defaulting to `small-team` since that's the
tier that captures the actual thesis of this guide — a defined human role,
not just a commit trailer. Tiers are cumulative: `growing-startup` also
applies everything `small-team` and `solo` would have.

The script is agentic-IDE-agnostic: `--persona-file` (default `CLAUDE.md`)
tells it which file to append the agent-attribution note to, so it works
identically whether your tool uses CLAUDE.md, AGENTS.md, `.cursorrules`, or
something else entirely.

The script never overwrites a file that already exists, so re-running it (or
moving up a tier later) is safe. The persona file and `README.md` merges are
skipped, with a note, if those files don't exist yet in the target repo.
`.gitignore` is the exception: it holds no project prose, so
`docs/team/HUMAN.md` and `docs/team/team-state.md` are gitignored by creating
the file if needed rather than skipping — leaving PII-bearing files
untracked-but-not-ignored would defeat the point. From the `solo` tier
onward, the script also copies this directory's `.markdownlint.json` (and
the `.github/`-scoped override) into the target repo, since
`commit_template.md` and `pull_request_template.md` need `MD041` disabled to
lint clean as partial documents.

---

## Part 8 — Compliance Checklist

For teams in regulated industries or approaching audits:

- [ ] Persona file (CLAUDE.md, AGENTS.md, etc.) defines agent persona and constraints
- [ ] HUMAN.md defines human role and review commitments
- [ ] team-state.md exists and is updated regularly
- [ ] AI-POLICY.md is committed to the repository root
- [ ] PR template includes team attribution block
- [ ] Commit messages carry AI origin trailers
- [ ] AI does not appear as git author or co-author
- [ ] Enable signed commits: `git config --global commit.gpgsign true`
- [ ] Session logs retained in `.claude/sessions/` for significant features
- [ ] AI tool versions documented at time of each release
- [ ] Calibration log reviewed before major releases
- [ ] git-ai or equivalent tooling configured (enterprise / regulated)

---

## Part 9 — Why This Matters

As of 2025, over 51% of all code committed to GitHub was either generated
or substantially assisted by AI. A persona-aware attribution policy matters for:

- **Legal clarity** — IP ownership questions during acquisitions or audits
- **Security traceability** — tracing vulnerabilities to their origin and
  the trust level that applied at the time
- **Compliance** — SOC2, ISO27001, and pre-IPO audit requirements
- **Team accountability** — knowing what was reviewed versus auto-generated
- **Code review prioritization** — focusing human attention appropriately
- **Institutional memory** — understanding how and why the codebase was built
  the way it was, long after the sessions that produced it

A well-maintained set of team documents is not a compliance exercise.
It is a record of a working relationship — which is the most useful artifact
anyone can have when they need to understand a codebase built by a human-agent pair.

---

*Last updated: May 2026*
*Applies to: Claude Code, GitHub Copilot, Cursor, Cline, Windsurf, and other AI coding assistants*
*Covers: team personas, the lifeline dynamic, commit attribution, PR attribution,
repository-level policy, tooling, and compliance*
