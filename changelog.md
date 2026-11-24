# Changelog

All notable changes to **PawnDynamic** (World of Warcraft: Classic Forever, Interface `16001`) are documented in this file.

---

## [1.2.0-beta] - 2026-11-24
### Added
* **Drag-and-Drop Priority Reordering (`UI.lua`, all 10 `Locales\*.lua`):** Replaced the `^`/`v` arrow buttons in Column 2 (*Your priority*) of the Stat Priority Generator with native drag-and-drop reordering featuring grip handles, a floating ghost row, an insertion indicator bar, automatic edge-scrolling for long 17+ stat lists, and instant live preview updates in Column 3 (while keeping the `x` remove button).
* **Context-Aware Stat Priority Generator Loading & Persistence (`PrioGenerator.lua`, `Scales.lua`, `UI.lua`):** Opening the Stat Priority Generator now initializes based on the active profile context instead of always resetting to defaults: new empty profiles start empty, generator-created/applied and copied profiles preserve their exact saved `prioList` and `genRole`, and templates or existing/imported profiles without a saved list derive their priority descending from weights `> 0` (budget-normalized). *Load default prio* remains available for manual resets.
* **Expertise Support for `RANGED` / Hunter (`PrioGenerator.lua`):** Unlocked `EXPERTISE` (item-budget factor `11.0`) for the `RANGED` role in the Stat Priority Generator so ranged Hunter profiles (e.g., Beast Mastery) can weight Expertise and track the Expertise cap bar in *Caps & Dynamics*.

### Changed
* **Ranged Hit Mode Auto-Resolution (`PrioGenerator.lua`):** `BuildCapsForRole` now sets `hitMode = "auto"` for `RANGED` profiles so `Caps:ResolveHitKind` resolves `"ranged"` cleanly without triggering the melee Dual-Wield white-hit soft cap on dual stat-sticks.
* Added localized strings `Drag to reorder` and `Click + on the left to add stats.` across all 10 client locales (`275 / 275` keys aligned).
* Unified addon metadata version to `1.2.0-beta` in `PawnDynamic.toc` and `Core.lua`.

---

## [1.1.0-beta] - 2026-11-20
### Added
* **Optional Percentage Stat Scaling Below Level 60 (`Caps.lua`, `UI.lua`, all 10 `Locales\*.lua`):** Added the per-profile `Scale % stats below level 60` checkbox (`scalePercentByLevel`) with live scaling factor indicator and tooltip in *Caps & Dynamics*, proportionally scaling multiplicative percentage stats (`Crit`, `Hit`, `Haste`, `Expertise`, `Dodge`, `Parry`, `Block`) by `PlayerLevel / 60` while leveling (`1.00` at level 60).
* **Pairwise Weapon Evaluation & Bag Partner Matching (`Upgrades.lua`, `Scales.lua`, `PrioGenerator.lua`, `Caps.lua`):** Added full pairwise weapon comparisons (`2H` vs `1H + Shield/Off-Hand`, Dual-Wield MH/OH combinations, and best-partner lookup from bags) alongside `MELEE_HIT` / `RANGED_HIT` / `OFFHAND_DPS` synergies.
* **Explicit Multi-Slot Replacement Notes in Tooltips (`Upgrades.lua`, `Tooltip.lua`, all 10 `Locales\*.lua`):** Upgrade tooltip lines now display which slot or equipped item would be replaced (Rings, Trinkets, Main Hand, Off Hand, `MH + OH`), including clear MH-to-OH swap notes (e.g., `(Main hand, Worn Dagger → Off hand)`).
* **Automatic Permanent Class Unusable Filters (`Scales.lua`, `PrioGenerator.lua`, `ImportExport.lua`, `UI.lua`):** Applied `CLASS_UNUSABLE_DEFAULTS` across starter profiles, newly created profiles, Stat Prio Generator outputs, and Pawn-v1 imports for all 9 classes while keeping lower wearable armor classes and Level-40 unlockable armor types unlocked.

### Changed
* **Full 10-Locale `Getting started / About` Localization (`UI.lua`, all 10 `Locales\*.lua`):** Localized the entire *Getting started / About* tab (author/license header, section descriptions, Druid Bear Form notice, and slash-command reference) across all 10 client locales (`273 / 273` keys aligned).
* **Temporary Equip Restrictions Kept Eligible for Upgrades (`Parser.lua`, `Upgrades.lua`):** Separated permanent class usability (`IsUsable`) from temporary equip requirements (`CanEquipNow` such as `minLevel > PlayerLevel()`, untrained weapon skills, or Level-40 mail/plate locks) so future upgrades still show percentage gains in tooltips.
* Unified addon metadata version to `1.1.0-beta` in `PawnDynamic.toc` and `Core.lua`.

### Fixed
* **Cloak Exemption from Cloth Filter (`Parser.lua`, `Scales.lua`, `Upgrades.lua`):** Explicitly exempted `INVTYPE_CLOAK` from the `IsCloth` unusable check (`classID = 4, subclassID = 1`) so cloaks are always evaluated.
* **Real Dual-Wield Availability Check & MH→OH Swap Guard (`Upgrades.lua`):** Replaced the unconditional class check in `CanDualWield` with `IsSpellKnown(674)` / `IsPlayerSpell(674)` / `_G.CanDualWield()` plus Classic level fallbacks (`ROGUE >= 10`, `WARRIOR`/`HUNTER >= 20`), prevented inferior weapons from swapping the current Main Hand into an empty Off Hand (`sMH > mainOnlyScore + 0.01`), and fixed `replacedName` falling back to `main.name` when the Off Hand slot was empty.

---

## [1.0.0-beta] - 2026-11-19
### Added
* **Branding & Addon Icon:** Added high-resolution `PD` CurseForge logo (`512x512`) and native in-game `Media\Icon.tga` (`128x128`, 32-bit uncompressed TGA) wired via `## IconTexture: Interface\AddOns\PawnDynamic\Media\Icon`.
* **WoW-Style Profile Deletion Confirmation:** Deleting a custom profile now requires typing the localized confirmation keyword (`DELETE` in `enUS`, `LÖSCHEN` in `deDE`, and equivalent localized words in all 10 supported locales; case-insensitive) with live validation keeping the confirmation button disabled until the keyword matches.
* **Beta Release Packaging:** Added MIT `LICENSE`, `.gitignore`, `README.md`, `changelog.md`, and clean release packaging (`PawnDynamic_v1.0.0-beta.zip`).

### Changed
* Unified addon metadata version to `1.0.0-beta` in `PawnDynamic.toc` and `Core.lua`.

---

## [0.2.4] - 2026-11-18
### Added
* **Stat Priority Generator (`PrioGenerator.lua`):** Integrated priority-to-weight builder supporting `TANK`, `MELEE`, `RANGED`, `CASTER`, and `HEALER` roles filtered by class. Converts plain priority order into balanced stat weights using WoW Classic item-budget factors, automatic primary-stat synergies (e.g., Armor → Agility, AP → Strength/Agility, Spell Crit → Intellect), class/role baselines, and strict `0`-weighting for irrelevant stats.
* **Two-Column Priority UI & Dynamic Scrollbars (`UI.lua`):** Added the modal Stat Prio Generator dialog (up/down reordering, quick add/remove, live weight preview, create-as-new or apply-to-profile) and vertical scrollbars for long 17+ priority lists.

### Fixed
* **UI Overlap in `Caps & Dynamics` (`UI.lua`):** Wrapped cap bars inside a clipped scroll area (`barsScroll`) so large sets of active caps and resistance bars never overflow into notes or configuration controls.
* **Hybrid Auto Hit-Mode Heuristic (`Caps.lua`):** Refined `ResolveHitKind` for `PALADIN`, `SHAMAN`, and `DRUID` to compare weighted `casterScore` vs. `meleeScore` instead of treating any hybrid spell weight as pure caster.
* **Avoidance Detail Line Readability (`Caps.lua`, `Locales\*.lua`):** Replaced overly terse single-letter tags with clean single-line localized labels separated by middots (`Miss ... · Dodge ... · Parry ... · Block ...`).

---

## [0.2.3] - 2026-11-17
### Added
* **Manual Hit Mode Selector (`Caps.lua`, `UI.lua`, all 10 `Locales\*.lua`):** Added per-profile `hitMode` (`Auto` / `Melee` / `Spell`) toggle for hybrid classes.
* **Pawn v1 Import Hardening (`ImportExport.lua`, `Scales.lua`):** Added quote-aware splitting, `NaN`/`inf` guards, safe ignoring of unknown retail/SimC tags, and guaranteed `caps` table initialization.

### Fixed
* Fixed **Normalize values** checkbox click handler (`and nil or 1` Lua evaluation bug) in `UI.lua` and cache invalidation in `Scales.lua`.
* Enforced single-line formatting (`SetWordWrap(false)`) and uniform row spacing on `Avoidance (Uncrushable)` details in `UI.lua`.

---

## [0.2.2] - 2026-11-16
### Added
* **Magic Resistance Cap Engine (`Caps.lua`, `UI.lua`, all 10 `Locales\*.lua`):** Added level- and target-scaled hard caps (`(PlayerLevel + TargetOffset) * 5`, 75% average DR) for Fire, Frost, Nature, Shadow, and Arcane Resistance (including `AllResist` handling), read via `UnitResistance("player", school)`.
* **Optional `+60` Raid Resistance Buff Offset:** Added per-profile toggle (`Include Raid Resistance Buff (+60)`) with live `UNIT_AURA` double-counting protection; dynamically hidden in `Caps & Dynamics` unless a resistance stat has weight `> 0`.

---

## [0.2.1] - 2026-11-15
### Added
* **Form & Stance Awareness (`Core.lua`):** Registered `UPDATE_SHAPESHIFT_FORM` for instant cache invalidation and UI updates on Druid forms and Warrior stances.
* **Context-Filtered Cap Bars (`UI.lua`):** Dynamically hides irrelevant cap bars without gaps and filters `Avoidance (Uncrushable)` strictly to shield-bearing classes (`WARRIOR`, `PALADIN`, `SHAMAN` without `INVTYPE_HOLDABLE`).
* **Druid Bear Form Notice & Spirit Target UX (`UI.lua`, `Caps.lua`):** Added contextual Bear Form reminder when tanking/weighting armor, plus clear help text and live current value next to the Spirit Target input.

### Changed
* Replaced legacy cap terminology across all 10 locales with player-friendly labels (`Hit cap (%)`, `Spell hit cap (%)`, `Defense (Crit immune)`, `Avoidance (Uncrushable)`, `Haste cap (GCD)`).

---

## [0.2.0] - 2026-11-14
### Added
* **Exact Level- & Target-Dynamic Cap Formulas (`Caps.lua`):** Introduced per-profile `targetMode` (`auto`, `+0`, `+2`, `+3`) with exact physical/spell Hit caps (`5/4%`, `6/6%`, `8/17%`), Defense crit-immunity (`Level * 5 + 125/135/140`), dynamic Dual-Wield off-hand/white-hit de-weighting, Armor 75% DR cap, and Avoidance uncrushable caps (`100% / 101.6% / 102.4%`).
* **Double-Count Prevention (`Talents.lua`, `Core.lua`):** Registered `UNIT_AURA` (`player` filter) and separated passive character-sheet talents, school-specific talents, and active combat buffs (e.g., *Holy Shield*, *Shield Block*).

---

## [0.1.0] - 2026-11-13
### Added
* **Initial Clean-Room Architecture (`PawnDynamic`):** Pure-Lua (zero XML) modular addon for WoW Classic Forever (`16001`) featuring `issecretvalue`-safe `Plain()` wrappers, two-tier generation caching, native `C_TooltipInfo` + multi-locale tooltip stat parser (`10` client locales), `C_Traits` / `C_ClassTalents` scanner, delta-based cap valuation, Pawn v1 import/export, ElvUI-style 6-tab UI, direct item compare, quest/loot arrows, and bag integration (Blizzard Bags, Bagnon, Baganator).
