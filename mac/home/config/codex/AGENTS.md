In a Jujutsu repository, prefer `jj` for version-control operations; Git is also allowed when useful or required by tooling.
For parallel work in the same repository, consider a separate `jj` workspace per agent, usually in a sibling directory of the primary workspace.
When Git-dependent tooling is needed, verify that the workspace is colocated with Git.

When creating a commit, add an `Assisted-by: AGENT_NAME:MODEL_VERSION` trailer, for example `Assisted-by: Codex:gpt-5.6-sol`.
Aim for commit subjects of 52 characters or fewer when practical, and wrap body text at 72 characters.

If a repository has no `AGENTS.md` but has a `CLAUDE.md`, read `CLAUDE.md` as repository guidance.

Do not push commits or create issues or pull requests without explicit approval. Treat tentative language as discussion, not authorization; if unsure, ask first.
