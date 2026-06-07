---
name: remember
description: "Save anything to persistent memory permanently. Use this skill whenever the user says 'remember that', 'save this', 'note that', 'don't forget', 'keep this in mind', or asks to update their preferences/goals/context. The saved info persists forever via git. Triggers on: /remember, remember this, save to memory, note this down."
argument-hint: "<anything you want me to always remember>"
---

# Remember — Persistent Memory Writer

## What I Do

I write information to `memory.md` in the repo and immediately commit + push it to GitHub so it survives forever, across all future sessions.

## Instructions

When this skill is invoked:

1. **Read** the current `/home/user/Design/memory.md` to understand what's already there.
2. **Decide** which section the new information belongs in (About Me, Goals, Preferences, Projects, Things I've Learned, or create a new section if needed).
3. **Edit** `memory.md` to add the new entry cleanly. Keep it concise. Format: bullet point with date if time-sensitive.
4. **Update** the `*Last updated: DATE*` line at the bottom.
5. **Commit and push**:
   ```bash
   cd /home/user/Design
   git add memory.md
   git commit -m "memory: <one-line summary of what was saved>"
   git push -u origin claude/ai-capability-expansion-JTH6f
   ```
6. **Confirm** to the user: "Saved to memory. Will be loaded in all future sessions."

## Important

- Never overwrite existing entries — append or update in place.
- If the user gives a correction ("actually I prefer X not Y"), find and update the existing entry.
- Keep entries short — they load into every session and shouldn't become bloated.
- Group related facts together.
