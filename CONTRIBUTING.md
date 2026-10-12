# Contributing to Spanish Inquisition CMS

Thank you for contributing to the **Internal Court Management System of the Spanish Inquisition** (Spanish Inquisition CMS). This project implements a distributed client-server architecture consisting of a **Java (Spring Boot) backend**, a **Holy C frontend**, and a **PostgreSQL database**.

To ensure seamless collaboration, code quality, and consistency across the team, all contributors must adhere strictly to the guidelines and workflows described below.

---

## Table of Contents
1. [Branch Naming Convention](#1-branch-naming-convention)
2. [Starting Work](#2-starting-work)
3. [Commit Messages](#3-commit-messages)
4. [Pull Requests (PRs)](#4-pull-requests-prs)
5. [Jira Workflow & Definition of Done](#5-jira-workflow--definition-of-done)

---

## 1. Branch Naming Convention

All branches created in this repository must strictly adhere to the following naming structure:

```text
type/JiraKey-Priority-ShortDescription
```

### Components Breakdown:
- **`type`**: The kind of change being introduced. Permitted values:
  - `feat`: New feature implementation
  - `fix`: Bug fix
  - `docs`: Documentation updates or additions
  - `refactor`: Code changes that neither fix a bug nor add a feature
  - `test`: Adding or correcting unit/integration tests
  - `chore`: Build scripts, dependencies, or tooling adjustments
- **`JiraKey`**: The exact Jira issue key assigned to the task (e.g., `ICMSSI-9`).
- **`Priority`**: The priority tier defined in Jira:
  - `must`: For **Must-have** requirements
  - `nice`: For **Nice-to-have** requirements
- **`ShortDescription`**: A brief summary of the task using lowercase alphanumeric characters separated by hyphens (kebab-case).

### Examples:
- `feat/ICMSSI-9-must-rejestracja-db`
- `feat/ICMSSI-14-must-interrogation-management`
- `feat/ICMSSI-22-nice-stake-statistics-ui`
- `fix/ICMSSI-31-must-postgres-connection-timeout`
- `docs/ICMSSI-5-must-deployment-instructions`
- `chore/ICMSSI-18-nice-gradle-wrapper-update`

---

## 2. Starting Work

Always ensure that any new work originates from the most up-to-date version of the `main` branch. Never branch off of outdated local branches or unmerged feature branches.

### Step-by-Step Procedure:

1. **Verify Working Directory State**:
   Make sure you have no uncommitted changes in your current workspace:
   ```bash
   git status
   ```

2. **Switch to `main`**:
   Checkout the local `main` branch:
   ```bash
   git checkout main
   ```

3. **Fetch and Pull the Latest Remote Changes**:
   Fetch updates from the remote repository and fast-forward your local `main`:
   ```bash
   git fetch origin
   git pull origin main
   ```

4. **Create and Checkout Your New Feature Branch**:
   Create a new branch following the [Branch Naming Convention](#1-branch-naming-convention):
   ```bash
   git checkout -b feat/ICMSSI-9-must-rejestracja-db
   ```

5. **Proceed with Development**:
   Make your changes, verify them locally, and prepare atomic commits.

---

## 3. Commit Messages

Every single commit message must start with the **Jira Issue Key**, followed by a colon, a space, and a clear, descriptive summary written in English.

### Format:
```text
<JiraKey>: <Description>
```

### Rules & Best Practices:
- Always prefix the message with the issue key (e.g., `ICMSSI-9:`).
- Use clear, professional English.
- Use the imperative mood for the commit subject (e.g., "Add", "Fix", "Update", "Refactor").
- Keep the first line concise (under 72 characters if possible).
- Provide additional context in the commit body when necessary, separated by a blank line.

### Examples:
- `ICMSSI-9: Added PostgreSQL mapping`
- `ICMSSI-9: Create heretic registration repository and entity mapping`
- `ICMSSI-14: Implement interrogation session scheduling endpoint`
- `ICMSSI-22: Add Holy C view for stake statistics`
- `ICMSSI-31: Fix connection pool exhaustion in database datasource`

---

## 4. Pull Requests (PRs)

To maintain code integrity and prevent regressions in production and shared branches:

- **Strict Merging Policy**: **Nobody merges their own branches directly to `main`**. Direct pushes to `main` are strictly prohibited.
- **Mandatory Reviewer**: A Pull Request (PR) must be created targeting the `main` branch, and **Maksym** must be added as a reviewer.

### PR Creation and Review Workflow:

1. **Push Feature Branch to Remote**:
   ```bash
   git push -u origin feat/ICMSSI-9-must-rejestracja-db
   ```

2. **Open Pull Request**:
   - Target branch: `main`
   - Source branch: your feature branch (e.g., `feat/ICMSSI-9-must-rejestracja-db`)
   - Title: Include the Jira key and a concise description (e.g., `[ICMSSI-9] Add PostgreSQL mapping for heretic registration`).

3. **Assign Reviewer**:
   - Add **Maksym** as a reviewer on the Pull Request.

4. **Address Feedback**:
   - Respond to all review comments promptly.
   - Push additional commits to your feature branch as needed to resolve remarks.

5. **Approval & Merge**:
   - The PR can only be merged into `main` after **Maksym** approves the changes and all automated CI checks (if applicable) pass.

---

## 5. Jira Workflow & Definition of Done

We track all project deliverables and iterations using Jira.

### Task Categorization:
- **Must-have (`must`)**:
  - Essential core functionality required for system operation.
  - Examples: Heretic Registration, Interrogation Management, Sins Registry, Core Database Schema.
  - Must-have tasks always take priority over nice-to-have items.
- **Nice-to-have (`nice`)**:
  - Secondary or supplemental features implemented when core deliverables are on track.
  - Examples: Stake Statistics, Interrogation Room Inventory, Advanced File Filtering.

### Task Progression:
1. `Backlog` &rarr; `To Do`: Ticket prioritized and scoped.
2. `To Do` &rarr; `In Progress`: Branch created and development initiated.
3. `In Progress` &rarr; `In Review`: Code pushed, PR created, and Maksym assigned for review.
4. `In Review` &rarr; `Done`: All criteria met, PR approved and merged.

### Definition of Done (DoD):
**Before moving any task to `Done`, all Definition of Done (DoD) criteria defined on the Jira issue must be met.**

A task is considered **Done** only when:
1. **Scope Fulfilled**: All acceptance criteria outlined in the Jira issue description are fully satisfied.
2. **Quality & Compilation**:
   - Backend: Java code compiles cleanly without errors or regressions (`./gradlew build`).
   - Frontend: Holy C client builds and interacts as expected with backend endpoints.
   - Database: Migrations/DDL scripts execute successfully against PostgreSQL.
3. **Tests Passed**: All relevant unit and integration tests pass.
4. **Documentation**:
   - In-code documentation and comments are present.
   - Project documentation and `changelog.md` are updated if architectural changes or major features were introduced.
5. **Code Review & Approval**: The Pull Request was reviewed and approved by **Maksym**.
6. **Merged to `main`**: The Pull Request has been merged into the `main` branch and the feature branch deleted.
