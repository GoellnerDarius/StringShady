# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

StringShady is a Godot 4.5 game where players match underwear/clothing items to the correct human characters. The game features a timed challenge with a highscore system.

## Development Commands

```bash
# Open project in Godot Editor (requires Godot 4.5+)
godot --editor project.godot

# Run the game
godot project.godot

# Run specific scene
godot --main-pack Scenes/test_level.tscn
```

## Architecture

### Game Flow
1. **Main Menu** (`Scenes/main_menu.tscn`) - Entry point with Start and Exit buttons
2. **Game Level** (`Scenes/test_level.tscn`) - Core gameplay with timed matching
3. **End Scene** (`Scenes/EndScene.tscn`) - Highscore display and entry

### Core Systems

**Game Logic** (`Scripts/test_level.gd`)
- Spawns human characters with randomized underwear types
- Manages underwear queue (current and next items)
- Validates player matching decisions
- Tracks round progression

**Timer System** (`Scripts/TimerScript.gd`)
- Countdown timer with visual progress bar
- Triggers game end on timeout

**Highscore System** (`Scripts/Highscore.gd`)
- JSON serialization to `user://highscores.json`
- Dictionary format: `{"PlayerName": score}`
- Auto-sorted by score (descending)
- Limited to top 10 entries with input for new scores

### Scene Components
- `StringButton.tscn` - Underwear/clothing item UI element
- `HumanButton.tscn` - Clickable human character
- `Timer.tscn` - Countdown timer with progress bar

### Key Patterns
- Uses `@export` variables for Inspector configuration
- Scene transitions via `get_tree().change_scene_to_file()`
- Dynamic UI creation using `add_child()` for runtime elements
- Texture arrays for sprite variations (9 underwear types, multiple human variants)