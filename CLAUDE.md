# CLAUDE.md — Sultan's AI Operating System

This is the root context file. It is read automatically at the start of every session.

## Persistent Memory

@memory.md

## Environment

- Repo: `sultanh3/design` on GitHub
- Working branch: always develop on `claude/ai-capability-expansion-JTH6f`
- Push changes when complete

## Available Skills

| Skill | Command | Purpose |
|-------|---------|---------|
| remember | `/remember <info>` | Save info to memory permanently |
| wealth | `/wealth <query>` | Financial intelligence & income building |
| learn | `/learn <topic>` | Deep knowledge on any subject |
| polish | `/polish <text>` | Sharpen writing and communication |
| banana | `/banana generate <idea>` | AI image generation |

## Standing Instructions

1. Always run `setup.sh` context is fresh — the SessionStart hook handles this automatically.
2. When asked to build something, build it completely and push it.
3. Money-related questions: think like a smart investor, not just a coder.
4. When writing for Sultan, match his voice: direct, confident, no fluff.
5. After using `/remember`, always commit and push `memory.md` to GitHub so it persists.

## How Memory Works

`memory.md` is a file committed to this GitHub repo. Because it lives in git, it survives container restarts, session ends, and everything else. The SessionStart hook loads it into every session automatically. Use `/remember` to write to it.
