# Workspace Memory & Rules

## Core Guidelines
1. **Target File Integrity**: Always write code directly into the game's designated `.luau` file (e.g. `RollAnimeFight.luau`, `StealAEgg.luau`, etc.).
2. **Fluent UI**: Use Fluent UI (Theme Aqua, Dark mode, Acrylic glassmorphism) titled `"2K Script"`.
3. **UI Cleanup Rule**: Prior to creating any GUI, always execute full teardown: disconnect events, stop worker loops, destroy old FluentWindow and matching ScreenGuis.
4. **Validation Before Remotes**: Check player currencies against item/upgrade costs before firing remotes to prevent error notification spam.
5. **Auto-Execution**: Run and verify scripts inside Roblox using the executor MCP tool.
