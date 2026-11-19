# Contributing to Spanish Inquisition CMS

Follow these guidelines for branches, commits, and pull requests.

## 1. Branch Naming Convention
Branches must follow:
```text
type/JiraKey-Priority-ShortDescription
```
- **Type**: `feat`, `fix`, `docs`, `refactor`, `test`, `chore`
- **JiraKey**: Jira ticket key (e.g. `ICMSSI-9`)
- **Priority**: `must` (core requirements) or `nice` (secondary features)
- **ShortDescription**: kebab-case description

*Example:* `feat/ICMSSI-9-must-rejestracja-db`

## 2. Starting Work
Always branch from an up-to-date `main`:
```bash
git checkout main
git pull origin main
git checkout -b <branch-name>
```

## 3. Commit Messages
Format:
```text
<JiraKey>: <Imperative description in English>
```
*Example:* `ICMSSI-9: Add heretic registration entity and repository`

## 4. Pull Requests (PRs)
- **Target:** `main`
- **Policy:** Never push directly to `main` and never self-merge.
- **Reviewer:** Add **KirinToru** as a mandatory reviewer.
- **Automated CI:** Every PR automatically triggers GitHub Actions (`Java Backend CI`).
  - Compilation and automated tests against PostgreSQL 15 must pass (green checkmark).
  - If CI fails (red cross), open the **Checks** tab on the PR, inspect the build log, fix the issue locally, and push the update.
- Merge occurs only after approval by **KirinToru** and passing CI checks.

## 5. Definition of Done (DoD)
A task is **Done** when:
1. Jira acceptance criteria are met.
2. Code compiles cleanly (`./gradlew build` for backend, Holy C runs for frontend).
3. Unit and integration tests pass.
4. Documentation is updated if architecture or features changed.
5. PR is approved by **KirinToru** and merged into `main`.
