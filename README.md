# PawnDynamic

**Author:** Behmen  
**Version:** `1.2.0-beta` (Pre-Release / Beta)  
**Target Client:** World of Warcraft: Classic Forever (Interface `16001`)  
**License:** MIT License (100% clean-room Lua, no XML)

**PawnDynamic** is a modern, dynamic gear evaluation addon for **WoW Classic Forever**. It combines classic Pawn-style profile management and Pawn-v1 string import/export with an automatic, delta-based cap engine, live talent/aura tracking, pairwise weapon comparison, and a Stat Priority Generator.

> **Beta & Localization Status (`v1.2.0-beta`):** This build is an active pre-release/beta. `enUS` and `deDE` are verified in-game. Eight additional locales (`frFR`, `esES`, `itIT`, `ptBR`, `ruRU`, `koKR`, `zhCN`, `zhTW`) are included and open for community refinement via `/pd dump`.

---

## Features
* **Automatic Dynamic Cap Engine:** Level- and target-scaled (`+0`, `+2`, `+3`) delta evaluation for Hit (incl. Dual-Wield & Hybrid Hit Mode), Spell Hit, Defense (`Level × 5 + 125/135/140`), Expertise, Armor (`75%` DR), Avoidance (`Uncrushable`), Haste (`50%` GCD), Magic Resistances (`(Level + Offset) × 5` + optional `+60` Raid Buff offset), and optional `< 60` percentage stat scaling (`Scale % stats below level 60`).
* **Pairwise Weapon & Multi-Slot Comparison:** Evaluates `2H` vs. `1H + Shield/Off-Hand` (including bag partner matching), Dual-Wield MH/OH pairing with real Dual-Wield availability checks, temporarily higher-level/untrained items, and explicit multi-slot replacement notes in tooltips (Rings, Trinkets, Main Hand, Off Hand, and MH→OH swaps).
* **Stat Priority Generator:** Turns plain priority lists (including 17+ stats, with drag-and-drop reordering and context-aware loading/persistence per profile) into item-budget-normalized weights with automatic primary-stat synergies (e.g., Armor → Agility, AP → Strength/Agility) and strict `0`-weighting for irrelevant stats.
* **Talent & Buff Tracking:** Language-independent `C_Traits` / `C_ClassTalents` parsing and `UNIT_AURA` / `UPDATE_SHAPESHIFT_FORM` live updates with strict double-count protection.
* **Multi-Language Tooltip Parsing:** Reads and evaluates item tooltips directly across all 10 supported client languages (`enUS`, `deDE`, `frFR`, `esES`, `itIT`, `ptBR`, `ruRU`, `koKR`, `zhCN`, `zhTW`).
* **Automatic Class Filters & Pawn-v1 Compatible:** Pre-configures permanent class armor/weapon restrictions automatically across starter profiles, new profiles, generator profiles, and hardened Pawn-v1 imports (with cloaks exempted from cloth filtering).
* **UI & Bag/Quest Integration:** Native Lua ElvUI-style 6-tab interface, side-by-side item compare, tooltip scoring, quest reward markers, and bag arrows for Blizzard Bags, Bagnon, and Baganator.
* **Secret-Value Safe:** Full `Plain()` wrapper (`issecretvalue`) and `pcall`-guarded callbacks for zero combat Lua errors on Build `16001`.

## Screenshots

### Caps & Dynamics
![Caps & Dynamics](imgs/caps.png)

### Stat Priority Generator
![Stat Priority Generator](imgs/Generator.png)

### Item Tooltip
![Item Tooltip](imgs/item.png)

### Profiles & Weights
![Profiles](imgs/profil.png)
![Weights](imgs/weight.png)

### Direct Compare, Options & About
![Compare](imgs/compare.png)
![Options](imgs/options.png)
![About](imgs/about.png)

---

## Installation
1. Download the latest beta ZIP from **[CurseForge](https://www.curseforge.com/wow/addons/pawndynamic)** or **[GitHub Releases](https://github.com/Behmen-hub/PawnDynamic/releases)** *(do not download the raw source repository)*.
2. Extract the `PawnDynamic` folder into:
   `...\World of Warcraft\_forever_\Interface\AddOns\PawnDynamic`
3. Launch the game and type `/pd` to open the interface.

---

## Slash Commands
| Command | Description |
| :--- | :--- |
| `/pd` / `/pawndynamic` | Opens the PawnDynamic UI |
| `/pd status` | Prints current target mode, resolved caps, and session error count |
| `/pd dump` | Dumps parsed tooltip data for the hovered/linked item (helpful for locale reports) |
| `/pd scan` | Forces a full equipped/bag rescan |
| `/pd refresh` | Invalidates caches and refreshes UI/tooltips |
| `/pd debug` | Toggles debug logging |

---

## Contributing & Bug Reports
* **Missing translations or stat phrases:** Hover an affected item, run `/pd dump`, and paste the output into a GitHub Issue.
* **Class/spec cap edge cases:** Include the output of `/pd status` along with your class, spec, and active profile.

---

## Changelog
See [`changelog.md`](changelog.md) for the full version history.