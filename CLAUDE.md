# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

StringShady is a Godot 4.5 beach-themed matching game where players match swimwear/underwear to the correct sunbathing humans before they get sunburnt. Features wave-based progression with visual burn timers and a highscore system.

## Development Commands

```bash
# Open project in Godot Editor (requires Godot 4.5+)
godot --editor project.godot

# Run the game
godot project.godot
```

## Architecture

### Game Flow
1. **Main Menu** (`Scenes/main_menu.tscn`) - Start/Exit buttons
2. **Game Level** (`Scenes/test_level.tscn`) - Wave-based matching gameplay
3. **End Scene** (`Scenes/EndScene.tscn`) - Highscore entry and display

### Core Systems

**Global State** (`Scripts/Globals.gd`)
- Singleton autoload for persistent data across scenes
- `Globals.score` - Current score (10 points per correct match)
- `Globals.lifes` - Lives remaining (3 starting)

**Game Logic** (`Scripts/test_level.gd`)
- Wave system: Starts with 3 humans, adds 1 per wave, max 5 waves
- Human types: 49 variants (humanSprite0-48), indexed as `randomnumber % 7` for underwear matching
- Gender handling: Index > 20 = male (uses stringSprite[type+7]), otherwise female
- Visual timer overlays: Brown layer (0-50% time), Burnt layer (50-100% time)
- Individual parallel timers per human (10-20 second range)

**Highscore System** (`Scripts/Highscore.gd`)
- JSON serialization to `user://highscores.json`
- Dictionary format: `{"PlayerName": score}`
- Auto-sorted descending, limited to top 10 entries
- Dynamic name input positioned by score rank

### Key Data Structures

```gdscript
# test_level.gd
underwareHumanConst: Array[int]  # Original underwear type (0-6) each human needs
underwareHuman_map: Array[int]   # Tracking (-1 = already matched)
ManOrWoman: Array[bool]          # Gender for sprite offset calculation
human_timers: Array[Timer]       # Individual countdown timers
human_brown_overlays: Array[TextureRect]  # Tanning overlay
human_burnt_overlays: Array[TextureRect]  # Sunburn overlay
```

### Scene Components
- HumanSpawnPoints contain: TextureButton (clickable), TextureRect (underwear slot), GPUParticles2D (correct/wrong effects)
- stringPoints: Two TextureRects showing current and next underwear
- AnimationPlayer for string/clothesline animations

### Important Patterns
- Human sprites are arrays of 3 textures: `[base, brown, burnt]`
- Underwear sprites: First 7 = female versions, next 7 = male versions (14 total)
- Scene transitions via `get_tree().change_scene_to_file()`
- Button signals connected with extra_arg binding for human index identification
