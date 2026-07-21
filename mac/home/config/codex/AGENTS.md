In a Jujutsu repository, prefer `jj` for version-control operations; Git is also allowed when useful or required by tooling.
Consider using `jj` workspaces when appropriate.
A workspace should have an easy to understand name and should usually be located in a sibling directory relative to the primary workspace.
When cloning repositories, prefer doing it via `jj`.

When creating a commit, add an `Assisted-by: AGENT_NAME:MODEL_VERSION` trailer; example: `Assisted-by: Codex:gpt-5.6-sol`.
Aim for commit subjects of 52 characters or fewer when practical, and wrap body text at 72 characters.

If a repository has no `AGENTS.md` but has `CLAUDE.md`, read it.
When relevant, read `CONTRIBUTING.md` or other contributor documentation as well.

Do not push commits or create issues or pull requests without explicit approval.
Treat tentative language as discussion, not authorization; if unsure, ask first.
