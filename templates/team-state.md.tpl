# Team State — Living Document

## Current Dynamic

*Updated: [date] — [milestone or week marker]*

[One or two sentences on where the human-agent working relationship
currently stands — exploratory, past exploratory, high trust in specific
domains, etc.]

## What Is Working

- [Pattern that is saving rework or catching problems early]

## What Needs Correction

- [Recurring issue, with enough detail to act on it]

## Calibration Log

| Date   | Issue                                       | Correction Made                         |
| ------ | -------------------------------------------- | ----------------------------------------- |
|        |                                              |                                          |

## Trust Level by Domain

| Domain          | Trust Level  | Notes                             |
| ---------------- | ------------- | ----------------------------------- |
| UI components   |              |                                    |
| API routes      |              |                                    |
| DB queries      |              | Always review for RLS compliance  |
| Background jobs |              |                                    |
| Auth            | Human only   | Agent proposes, human writes      |
| Data Model      |              |                                    |

<!--
Save this file as docs/team/team-state.md and gitignore it — it is a
living, instance-specific record (calibration history, trust levels) that
should not be committed or reused verbatim across projects.
-->
