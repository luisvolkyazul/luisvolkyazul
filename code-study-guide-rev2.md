# Frogger Clone for Agon Light 2 — REV2 Code Study Guide

## Overview

This is the refactored version (FROGGER_REV2.BAS) of the Frogger game for Agon Light 2. All subroutines have been converted from GOSUB/RETURN to named DEF PROC/ENDPROC structures. The frog draw/erase logic has been split into separate procedures, and the unconditional per-frame erase has been removed — the frog is now only erased when it actually moves. ROWS% is corrected to 30, and named pad constants (PAD0%–PAD4%) replace hardcoded column literals. No gameplay behaviour has changed.

Key differences from REV1:
- 0 GOSUB statements (all replaced with named PROC calls)
- 0 RETURN statements (all replaced with ENDPROC)
- 47 DEF PROC declarations
- Frog split: `PROCdraw_frog`, `PROCerase_frog`, `PROCrestore_home_tile`
- Movement-gated erase: no unconditional erase every frame
- Median row (MROW%) properly restores `"="` character on erase
- FBG% recomputed independently in `PROCerase_frog`

---

## Lines 1–7: Program Header & Colour Reference

```basic
10 REM =========================================
20 REM  FROGGER CLONE for Agon Light 2
30 REM  BBC BASIC V - Mode 8 (320x200, 64col)
40 REM  40 cols x 25 rows, 64 colours
50 REM  Colour map: 0=Blk 1=Red 2=Grn 3=Yel
55 REM               4=Blu 5=Mag 6=Cyn 7=Wht
57 REM               +8=bright variants
```

REM statements are comments ignored by the interpreter. Lines 50–57 document the colour numbering: add 8 to any colour number for the bright variant (e.g., colour 10 is bright green, colour 6 is cyan).

---

## Lines 8–13: Screen & Row Constants

```basic
60 COLS%=40:ROWS%=30
65 REM Row 0=hdr, 1=home, 2-8=river, 9=median
66 REM 10-17=road, 18=safe, 19=status, 20-29=grass
70 HROW%=1:RV1%=2:RV2%=8:MROW%=9
72 RD1%=10:RD2%=17:SROW%=18:BROW%=19
73 PAD0%=3:PAD1%=11:PAD2%=19:PAD3%=27:PAD4%=35
80 MAXO%=5
```

Variables ending in `%` are integers. `ROWS%` is corrected to 30 (MODE 8 has rows 0–29, not 0–24). Line 73 defines five named pad-column constants (columns 3, 11, 19, 27, 35) that replace hardcoded literals throughout the program.

- **Row 0** — Header bar
- **Row 1** — Home row (5 lily pads)
- **Rows 2–8** — River (logs and turtles)
- **Row 9** — Median strip (road centre line)
- **Rows 10–17** — Road (cars and buses)
- **Row 18** — Safe zone (grass strip before the river)
- **Row 19** — Status bar (score, timer, lives)
- **Rows 20–29** — Bottom grass (decorative, extended from 24 to 29)

`MAXO%` = maximum objects per lane (5).

---

## Lines 14–30: Global Variable Initialization

```basic
81 REM --- UNCONDITIONAL GLOBAL VARIABLE INITIALIZATION ---
82 TIMEACC%=0
83 movedThisFrame%=0
84 LASTTIME%=0
85 RVRFLAG%=0
86 PREVRVRFLAG%=0
87 LUPDATE%=0
88 DONE%=0
89 NHOME%=0
90 LIVES%=3:BONUSLIFE%=0:FDIR%=0:DTYPE%=0:PLAYAGAIN%=0:HPOS%=0:TL_MAX%=2000:TLBAR%=18:SNROW%=2:WAVECLR%=0:WAVETICK%=20:INVTICK%=0:CROCPAD%=-1:CROCTICK%=0:CROCWAIT%=300:CROCACTIVE%=0
91 FX%=0
92 FY%=0
93 TL%=0
94 SCORE%=0
95 LEVEL%=1
96 SNOBJ%=0:SNOFF%=0:SNTICK%=400:SNCX%=0:FLYPAD%=-1:FLYSHOW%=0:FLYTICK%=0:FLYWAIT%=200:DIFF%=1:DBIAS%=0:RESPAWN%=0:LFROW%=2:LFOBJ%=0:LFOFF%=0:LFCARRY%=0:LFTICK%=600:LFACTIVE%=0:LFCX%=0
```

Key variables:
- `LIVES%` — Remaining lives (starts at 3)
- `TL%` — Time limit counter (decrements each tick)
- `TL_MAX%` — Starting time limit for the level
- `SCORE%` — Player's score
- `LEVEL%` — Current level number
- `DONE%` — Game state flag (0=playing, 1=level complete, 2=dead, 9=quit)
- `FDIR%` — Frog facing direction (0=up, 1=down, 2=left, 3=right)
- `INVTICK%` — Invulnerability timer after respawn (counts down to 0)
- `RESPAWN%` — Set to 1 after dying, triggers respawn logic
- `CROCACTIVE%` — Whether a crocodile is currently on a home pad
- `DIFF%` — Difficulty (0=easy, 1=normal, 2=hard)
- `NHOME%` — Number of frogs safely home this level

---

## Lines 31–33: Array Dimensions

```basic
97 DIM LDIR%(18),LSPD%(18),LCH%(18),LLEN%(18),LTICK%(18),LREDRAW%(18)
98 DIM LX%(18,5),HFILL%(4)
99 DIM TDIVE%(18),TTICK%(18):DIM HS%(5),HN$(5)
```

- `LDIR%` — Direction of each lane (1 = right, -1 = left)
- `LSPD%` — Speed of each lane (tick threshold)
- `LCH%` — Character code of objects in each lane (225=log, 226=turtle, etc.)
- `LLEN%` — Length (in tiles) of objects in each lane
- `LTICK%` — Per-lane movement tick counter
- `LREDRAW%` — Flag: set to 1 when lane needs redrawing
- `LX%(18,5)` — X-position of each object in each lane (rows 2-18, up to 5 objects)
- `HFILL%(4)` — Which home pads have been filled (0-4)
- `TDIVE%` / `TTICK%` — Turtle dive state and timer per row
- `HS%(5)` / `HN$(5)` — High scores and initials

---

## Lines 34–39: Main Program Flow

```basic
100 PROCload_scores
101 MODE 8
110 VDU 23,1,0,0,0,0,0,0,0,0
115 PROCdefine_tiles
117 PROCintro_animation
120 PROCtitle_screen
130 PROCouter_loop
```

In REV1, these were `GOSUB 3000`, `GOSUB 5000`, etc. The named PROC calls are self-documenting — you can read the program's flow without a line-number table.

- `PROCload_scores` — Load high scores from file (or set defaults)
- `MODE 8` — Set screen mode to 320x200, 40 columns, 64 colours
- `VDU 23,1,0,0,0,0,0,0,0,0` — Disable cursor
- `PROCdefine_tiles` — Define custom sprite tiles (VDU 23)
- `PROCintro_animation` — Play intro animation
- `PROCtitle_screen` — Show title screen
- `PROCouter_loop` — Enter the main play-again loop

---

## PROCload_scores (3000)

```basic
3000 DEF PROCload_scores REM 3000
3005 FOR HI%=1 TO 5:HS%(HI%)=0:HN$(HI%)="---":NEXT HI%
3010 HSF%=OPENIN("FROGGER.DAT")
3015 IF HSF%=0 THEN ENDPROC
3020 FOR HI%=1 TO 5
3025   INPUT# HSF%,HS%(HI%),HN$(HI%)
3030 NEXT HI%
3035 CLOSE# HSF%
3040 ENDPROC
```

`DEF PROCload_scores REM 3000` declares the procedure. The `REM 3000` trailing comment preserves the original line number for reference. `RETURN` is replaced by `ENDPROC` to end the procedure.

Initialises 5 high score slots to 0 / "---", then tries to open the save file. If the file doesn't exist (`OPENIN` returns 0), exits immediately. Otherwise reads 5 score/name pairs and closes the file.

---

## PROCsave_scores (3050)

```basic
3050 DEF PROCsave_scores REM 3050
3055 HSF%=OPENOUT("FROGGER.DAT")
3060 FOR HI%=1 TO 5
3065   PRINT# HSF%,HS%(HI%),HN$(HI%)
3070 NEXT HI%
3075 CLOSE# HSF%
3080 ENDPROC
```

Opens the file for writing and writes all 5 scores + initials.

---

## PROCcheck_high_score (3100)

```basic
3100 DEF PROCcheck_high_score REM 3100
3105 REM Find insertion position
3110 HPOS%=0
3120 FOR HI%=1 TO 5
3130   IF SCORE%>HS%(HI%) AND HPOS%=0 THEN HPOS%=HI%
3140 NEXT HI%
3150 IF HPOS%=0 THEN ENDPROC
3155 REM Shift lower scores down
3160 FOR HI%=5 TO HPOS%+1 STEP -1
3170   HS%(HI%)=HS%(HI%-1)
3180   HN$(HI%)=HN$(HI%-1)
3190 NEXT HI%
3195 REM Get player initials
3200 HS%(HPOS%)=SCORE%
3210 COLOUR 128+0:COLOUR 11
3215 PRINT TAB(7,13);"NEW HIGH SCORE! Rank #";HPOS%
3220 COLOUR 7
3225 PRINT TAB(7,14);"Enter initials (3 letters):"
3230 PROCenter_initials             (was GOSUB 15500)
3235 HN$(HPOS%)=INIT$
3238 PROCsave_scores                (was GOSUB 3050)
3240 ENDPROC
```

Finds insertion position (`HPOS%` = rank, 1-5). If the score qualifies, shifts lower scores down, prompts for initials (calls `PROCenter_initials`), saves, and returns. `ENDPROC` appears in two places: line 3150 (early exit if no high score) and line 3240 (normal exit). In BBC BASIC, `ENDPROC` can be used for early returns from any point in a procedure.

---

## PROCplay_again (3400)

```basic
3400 DEF PROCplay_again REM 3400
3410 COLOUR 128+0:COLOUR 11
3420 PRINT TAB(11,16);"HIGH SCORES"
3430 COLOUR 3
3440 PRINT TAB(8,17);"--------------------"
3450 FOR HI%=1 TO 5
3460   IF HS%(HI%)=0 THEN GOTO 3490
3465   COLOUR 7
3470   IF HI%=HPOS% THEN COLOUR 10
3480   PRINT TAB(8,17+HI%);HI%;".";HN$(HI%);"    ";HS%(HI%);"  "
3490 NEXT HI%
3500 COLOUR 11
3510 PRINT TAB(7,23);"Play again? (Y/N)"
3520 COLOUR 7
3530 REPEAT
3535   AG$=INKEY$(0)
3540 UNTIL AG$="Y" OR AG$="y" OR AG$="N" OR AG$="n"
3550 IF AG$="Y" OR AG$="y" THEN PLAYAGAIN%=1 ELSE PLAYAGAIN%=0
3560 ENDPROC
```

`COLOUR 128+N` sets the background colour to N; `COLOUR N` (without 128) sets the text colour. `TAB(col,row)` positions the cursor. `INKEY$(0)` reads a keypress without waiting. The loop waits until Y or N is pressed.

---

## PROChigh_score_screen (4000)

```basic
4000 DEF PROChigh_score_screen REM 4000
4010 CLS
4020 COLOUR 128+0:COLOUR 11
4030 PRINT TAB(1,3);"*** FROGGER CLONE FOR AGON LIGHT 2 ***"
...
4180 ENDPROC
```

Dedicated high-score display screen shown before gameplay. `ZZ%=GET` waits for any keypress; the REPEAT loop after it drains the keyboard buffer.

---

## PROCdefine_tiles (5000)

```basic
5000 DEF PROCdefine_tiles REM 5000
```

VDU 23 redefines a character's 8x8 bitmap. Format: `VDU 23, char_code, row0..row7`.

| Char | Name | Description |
|------|------|-------------|
| 224 | FROG (up) | Solid green frog facing up |
| 234 | FROG DOWN | Frog facing down |
| 236 | FROG LEFT | Frog facing left |
| 235 | FROG RIGHT | Frog facing right |
| 225 | LOG | Horizontal wood grain |
| 226 | TURTLE | Turtle with protruding head |
| 227 | VW BUG LEFT | Car facing left |
| 228 | VW BUG RIGHT | Car facing right |
| 229 | HOME PAD | Lily pad |
| 230 | BUS FRONT | School bus front section |
| 231 | BUS BACK | School bus rear section |
| 232 | WATER WAVE | Sine wave tile |
| 233 | BUSH/HEDGE | Home row blocker |
| 237 | SOLID BLOCK | Timer bar fill |
| 238 | SNAKE | S-curve snake on log |
| 239 | FLY | Bonus fly on pad |
| 240 | SQUASH | Crushed frog (death sprite) |
| 241 | CROCODILE | Crocodile on home pad |
| 242 | JUMP | Mid-air tucked frog |

---

## PROCintro_animation (5500)

The intro runs independently of the main game's position variables (uses AX%, AY%). Flow:
1. Clear screen, fill with background
2. Frog hops left from col 38 to col 18 (20 steps)
3. Frog hops up from row 12 to row 5 (7 steps)
4. Print "FROGGER" in rainbow colours letter-by-letter (DATA at line 5640)
5. Play fanfare jingle
6. Frog hops off the top of the screen
7. Clear screen, return

---

## PROCtitle_screen (6000)

Shows title banner, instructions, and a difficulty prompt (1=Easy, 2=Normal, 3=Hard). Converts keypress ASCII (49-51) to DIFF% (0-2). Shows top score if one exists. Calls `PROChigh_score_screen` before returning.

---

## PROCinit_level (7000)

Initialises a new level:

- `DONE%=0` — Reset completion flag
- `FX%=19:FY%=SROW%` — Frog starts at centre (col 19), safe row (row 18)
- `TL%` — Time limit starts at 2000, decreases by 10 per level (minimum 80)
- `DIFF%` adjusts `DBIAS%`: Easy +2, Normal 0, Hard -1

### Lane Definitions
Rows 2-8 (river): Logs (225, length 3-4) and turtles (226, length 6) alternating.
Rows 10-17 (road): VW Bugs (227/228, length 1) and Buses (230/231, length 2) alternating.

Higher speed value = slower (more ticks between moves). Each level subtracts 1 from all lane speeds (minimum 2).

### Turtle Dive State Init
Staggers initial dive timers so turtles don't all dive in sync.

### Background & Redraw
Calls `PROCplace_snake`, `PROCplace_ladyfrog`, `PROCdraw_background`, `PROCredraw_pads`, `PROCstatus_bar`, and `PROCdraw_frog` to set up the full visible game state.

---

## PROCredraw_pads (7500)

```basic
7500 DEF PROCredraw_pads REM 7500
7510 FOR RP%=0 TO 4
7520   IF HFILL%(RP%)=0 THEN GOTO 7550
7530   COLOUR 128+0:COLOUR 14
7540   PRINT TAB(PAD0%+RP%*8,HROW%);CHR$(224);
7550 NEXT RP%
7560 ENDPROC
```

Loops through pads 0-4. If `HFILL%(RP%)` is 1, draws the frog-on-pad sprite in yellow (COLOUR 14) at the corresponding column. Uses `PAD0%+RP%*8` instead of the former hardcoded `3+RP%*8`.

---

## PROCplay_level (8000) — Main Game Loop

```basic
8000 DEF PROCplay_level REM 8000
```

This is the core gameplay loop. Key differences from REV1:

### Frame Timing
```basic
8024 REPEAT UNTIL TIME >= LASTTIME% + 3
8025 LASTTIME% = TIME
8026 TIMEACC% = TIMEACC% + 1
8027 LUPDATE% = 0
8028 IF TIMEACC% >= 2 THEN LUPDATE% = 1:TIMEACC% = 0
```
The Agon's `TIME` variable increments ~100 times/second. `LASTTIME%+3` = ~30 FPS cap. Every 2 frames, `LUPDATE%` is set to 1 to trigger sub-ticker updates.

### Erase Optimization
```basic
8030 SAVEFX%=FX%:SAVEFY%=FY%
8040 REM Unconditional erase removed - gated on movement
```
In REV1, line 8040 was `EFLAG%=0:GOSUB 22000` — an unconditional erase every frame. This caused the frog to flash visibly when stationary. In REV2, the erase is removed entirely from this position. It only happens when the frog actually moves.

### Movement-Gated Erase/Draw
```basic
8185 IF SAVEFX%<>FX% OR SAVEFY%<>FY% THEN FX%=SAVEFX%:FY%=SAVEFY%:PROCerase_frog:FX%=NX%:FY%=NY%:PROCdraw_frog
```
When the frog moves (old position ≠ new position):
1. Temporarily swap FX%,FY% back to the saved (old) position
2. Call `PROCerase_frog` to restore the tile at the old position
3. Swap FX%,FY% to the new position (NX%,NY%)
4. Call `PROCdraw_frog`

When the frog doesn't move, both the erase and this conditional draw are skipped. The frog is still drawn unconditionally at line 8460.

### Collision Detection
```basic
8187 IF FY%>=RV1% AND FY%<=RV2% AND DONE%=0 AND INVTICK%=0 THEN PROCriver_check
8188 IF FY%>=RD1% AND FY%<=RD2% AND DONE%=0 AND INVTICK%=0 THEN PROCroad_check
8189 IF FY%=HROW% AND DONE%=0 THEN PROChome_check
```
Three collision checks per frame: river, road, home row. `AND INVTICK%=0` skips river/road deaths during invulnerability frames.

### Lane Redraw
Loops rows 2-18. If `LREDRAW%(R%)` is 1, redraws all objects on that row with appropriate foreground colours via `PROCdraw_obj_tile`.

### Post-Move Collision + Frog Draw
After objects have moved (which can carry the frog into a hazard), collision is checked a second time. The frog is drawn at line 8460 if DONE%=0.

### Loop Exit
```basic
8490 UNTIL DONE%<>0
8495 IF DONE%=9 THEN LIVES%=0:DONE%=2
```
DONE%=9 (Q key) forces game over. All other exits go through death or level-complete routines.

---

## PROCadvance_lane (8500)

Moves all objects in lane R% by 1 position in `LDIR%(R%)` direction, handles wrapping. Sets `LREDRAW%(R%)` = 1 for redraw. If the frog is on this lane, `movedThisFrame%` = 1 (used for synchronous drift in river).

---

## PROCriver_check (8600)

River collision and synchronous drift:
- Fully submerged turtle (`TDIVE%(FY%)=2`) → instant drown
- Checks if frog's column matches any object in its row (`OLG%=1`)
- Snake collision: if frog is on the snake's tile on a log
- Synchronous drift: if frog was on river last frame AND moved this frame, carry by current (`FX%=FX%+LDIR%(FY%)`)
- Drift off left/right edge → death
- Not on any object (`OLG%=0`) → drown

The `PREVRVRFLAG%` system prevents double-drift on the first frame the frog enters the river.

---

## PROCroad_check (8700)

Searches all objects in the frog's row. If any object occupies the frog's column, the frog is squashed (`DTYPE%=0`).

---

## PROChome_check (8800)

Determines which pad the frog is on (columns PAD0%-PAD4% → pads 0-4). If not on a pad, pad already filled, or crocodile present → death. On success: marks pad filled, awards fly/ladyfrog bonuses, increments NHOME%, calls `PROCstamp_pad`. If all 5 home → DONE%=1.

---

## PROClevel_complete (9000)

Rising arpeggio jingle, then:
1. Flash lily pads between cyan and yellow 3 times
2. Restore pads to bright green
3. Flash filled pads (frog sprites) white/invisible 3 times
4. Show "LEVEL X COMPLETE!" and time bonus

---

## PROCdie (10000)

- Early exit if already dying (`DONE%<>0`)
- Flash frog white then off 3 times
- Splash (drowning) or splat (road kill) sound
- Draw crushed frog sprite for road death
- `DONE%=2` signals game loop exit
- Calls `PROCdraw_frog` and `PROCerase_frog` for the death flicker

---

## PROCgame_over (11000)

Clear screen, display "GAME OVER" with score and level, check high score, show table, ask play again.

---

## PROCjump_sound (12000)

```basic
12000 DEF PROCjump_sound REM 12000
12005 SOUND 1,-15,80,1:SOUND 1,-15,120,1:SOUND 1,-15,160,1
12010 FBG%=2
12011 IF FY%>=RV1% AND FY%<=RV2% THEN FBG%=4
12012 IF FY%>=RD1% AND FY%<=RD2% THEN FBG%=0
12013 IF FY%=BROW% OR FY%=HROW% THEN FBG%=0
12014 ZZ%=INKEY(0)
12020 ENDPROC
```

Three rising-pitch SOUND calls create the classic arcade chirp. `FBG%` computes background colour at frog's position (used by the frog draw/erase routines). `INKEY(0)` drains any pending keypress.

Note that `PROCjump_sound` computes FBG% independently from `PROCdraw_frog`/`PROCerase_frog`. This is safe because each routine recomputes FBG% from FY% at the time of call.

---

## PROCsub_ticker (13000)

Called every other frame. The heartbeat of the game:
1. **Lane tickers** — increment each lane's tick counter; if threshold exceeded, call `PROCadvance_lane`
2. **Turtle dive** — update dive state for each turtle row
3. **Invulnerability** — decrement `INVTICK%` if > 0
4. **Time limit** — decrement `TL%` if alive
5. **Snake** — decrement and respawn when expired
6. **Fly** — activate/deactivate based on timers
7. **Lady frog** — deactivate when timer expires
8. **Crocodile** — activate/deactivate on home pads
9. **Wave flip** — every 20 ticks, flip wave colour, mark river rows dirty
10. **Time-up** — if TL% reaches 0, frog dies

---

## PROCturtle_dive (14000)

Four-state turtle dive cycle: 0=visible → 1=warning flash → 2=submerged → 3=resurface flash → back to 0. Uses `TDIVE%(R%)` for state and `TTICK%(R%)` for countdown.

---

## PROCerase_turtles (14100)

Replaces all turtle tiles on row R% with wave tiles (`CHR$(232)`) when turtles submerge (state 2).

---

## PROCouter_loop (15000)

```basic
15000 DEF PROCouter_loop REM 15000
15010 PLAYAGAIN%=1
15020 REPEAT
15030   SCORE%=0:LEVEL%=1:LIVES%=3:BONUSLIFE%=0:RESPAWN%=0
15040   REPEAT
15050     PROCinit_level          (was GOSUB 7000)
15060     PROCplay_level          (was GOSUB 8000)
15070     IF DONE%=1 THEN PROClevel_complete:LEVEL%=LEVEL%+1
15080     IF DONE%=2 THEN LIVES%=LIVES%-1:RESPAWN%=1
15090   UNTIL LIVES%<=0
15100   HPOS%=0
15110   PROCgame_over            (was GOSUB 11000)
15120 UNTIL PLAYAGAIN%=0
15130 MODE 8
15132 PROCthank_you             (was GOSUB 16000)
15140 END
```

Inner loop: plays levels until lives run out. After each level, either advance to next level or decrement lives and respawn. Outer loop: after game over, shows scores, asks to play again. On exit: reset screen mode, show thank-you screen, END.

---

## PROCenter_initials (15500)

Interactive 3-letter initial entry. Handles backspace (ASCII 8), uppercase letters (65-90), and lowercase-to-uppercase conversion (97-122 → 65-90). Shows underscore cursor at current position.

---

## PROCthank_you (16000)

Simple text screen printed after the program ends. Shows "Thank you for playing FROGGER CLONE FOR AGON LIGHT 2" and top score if one exists.

---

## PROCplace_snake / PROCerase_snake (17000–17100)

Snake appears on a random even-numbered river row (2, 4, 6, 8), on a random object at a random offset. `SNTICK%=400` sets duration. Erase restores the log tile at the snake's position.

---

## PROCplace_ladyfrog / PROCerase_ladyfrog (18000–18100)

Similar to snake placement, but checks the lady frog doesn't spawn on the same tile as the snake. `LFACTIVE%=1` makes her visible.

---

## PROCclear_message (18200)

Fills row 22 with spaces to clear temporary messages (fly bonus, extra life, etc.).

---

## Fly System: PROCdraw_fly / PROCdeactivate_fly / PROCactivate_fly (19000–19200)

Bonus fly appears on a random empty home pad for ~2 seconds, then disappears. Worth 200 points if the frog lands on its pad.

---

## Crocodile System: PROCactivate_croc / PROCdeactivate_croc / PROCdraw_croc (19300–19500)

Crocodile appears on a random empty home pad for 200 ticks, then disappears and waits 300-500 ticks before reappearing. If the frog lands on a crocodile's pad, it dies.

---

## PROCdraw_background (20000)

Draws the complete static background:
- Row 0: Cyan header bar with game title
- Row 1: Black background, 5 bright green lily pads (`PAD0%`–`PAD4%`), dark green hedges between pads
- Rows 2-8: Blue background with wave tile pattern (cyan/bright cyan based on `WAVECLR%`)
- Row 9: Yellow `"="` road median (`STRING$(COLS%,"=")`)
- Rows 10-17: Black road, dashed yellow centre lines on even rows
- Row 18: Bright green safe zone with alternate bush/space pattern
- Row 19: Dark status bar
- Rows 20-29: Green grass (formerly 20-24 in REV1)
- Row 25: Difficulty label

---

## PROCwave_flip (20600)

Toggles `WAVECLR%` between 0 and 1 (affects wave tile colour). Marks all river rows for redraw.

---

## PROCstatus_bar (21000)

- Left: Score and level number
- Middle: Graphical timer bar (18 blocks) — green ≥12, yellow 6-11, red <6
- Right: Frog icons for remaining lives
- Bottom: "Remaining Time" label

Timer bar fill: `TLBAR%=TL%*18/TL_MAX%`

---

## PROCdraw_frog (22000)

```basic
22000 DEF PROCdraw_frog REM 22000
22010 FBG%=2
22020 IF FY%>=RV1% AND FY%<=RV2% THEN FBG%=4
22030 IF FY%>=RD1% AND FY%<=RD2% THEN FBG%=0
22040 IF FY%=BROW% OR FY%=HROW% THEN FBG%=0
22050 IF FY%=SROW% THEN FBG%=2
22060 IF FY%=MROW% THEN FBG%=0
22070 IF FY%=0 THEN FBG%=0
22081 COLOUR 128+FBG%
22082 IF INVTICK%>0 AND (INVTICK% MOD 4)<2 THEN COLOUR 15 ELSE COLOUR 10
22083 IF FDIR%=2 THEN PRINT TAB(FX%,FY%);CHR$(235);:GOTO 22090
22084 IF FDIR%=1 THEN PRINT TAB(FX%,FY%);CHR$(234);:GOTO 22090
22085 PRINT TAB(FX%,FY%);CHR$(224);
22086 IF FDIR%=3 THEN PRINT TAB(FX%,FY%);CHR$(236);:GOTO 22090
22090 ENDPROC
```

Computes `FBG%` (background colour behind the frog) based on the frog's current row:
- Green (2) for safe/grass rows
- Blue (4) for river rows
- Black (0) for road, status bar, home, median, header

Sets the background colour (`COLOUR 128+FBG%`) and text colour: white during invulnerability flash, bright green otherwise. Draws the direction-appropriate sprite:
- `FDIR%=2` (left) → `CHR$(235)`
- `FDIR%=1` (down) → `CHR$(234)`
- `FDIR%=3` (right) → `CHR$(236)`
- Default (up, 0) → `CHR$(224)`

In REV1, this was `EFLAG%=1` path inside a single dispatch subroutine. Now it's a standalone PROC called directly.

---

## PROCerase_frog (22200)

```basic
22200 DEF PROCerase_frog REM 22200
22201 FBG%=2:IF FY%>=RV1% AND FY%<=RV2% THEN FBG%=4
22202 IF FY%>=RD1% AND FY%<=RD2% THEN FBG%=0
22203 IF FY%=BROW% OR FY%=HROW% THEN FBG%=0
22204 IF FY%=SROW% THEN FBG%=2
22205 IF FY%=MROW% THEN FBG%=0
22206 IF FY%=0 THEN FBG%=0
22207 IF FY%=HROW% THEN PROCrestore_home_tile:ENDPROC
22208 IF FY%=MROW% THEN COLOUR 128+0:COLOUR 3:PRINT TAB(FX%,FY%);"=";:ENDPROC
22209 IF FY%<>SROW% THEN COLOUR 128+FBG%:COLOUR FBG%:PRINT TAB(FX%,FY%);" ";:ENDPROC
22210 REM COLOUR 128+2
22215 IF (FX% MOD 2)=0 THEN COLOUR 128+2:COLOUR 10:PRINT TAB(FX%,FY%);CHR$(233); ELSE COLOUR 128+2:COLOUR 15:PRINT TAB(FX%,FY%);" ";
22220 ENDPROC
```

**Critical detail: FBG% is recomputed independently at lines 22201-22206.** In REV1, when GOSUB 22000 was called with EFLAG%=0, FBG% was recomputed at the top of line 22000 before the EFLAG% dispatch. After the split, `PROCerase_frog` must recompute FBG% independently because it may be called at a different time than the last `PROCdraw_frog` call — the frog may have moved to a row with a different background colour.

Erase behaviour by row:
| Row | Action |
|-----|--------|
| HROW% (1) | `PROCrestore_home_tile` — draws pad, hedge, or filled frog |
| MROW% (9) | Restores `"="` median in yellow on black (line 22208 — added as a fix for the invisible erase bug) |
| SROW% (18) | Restores safe-zone pattern: hedge on even columns, space on odd |
| Other | Coloured space matching the background (`FBG%`) |

**The median fix (line 22208):** In REV1 and early REV2, erasing the frog on MROW% printed a black space because `FBG%=0`. This destroyed the `"="` character that forms the median road marking. With the erase-gating optimization, this black gap became visible when the frog stopped on the median. The fix explicitly restores `"="` in COLOUR 3 (yellow) on black background.

---

## PROCrestore_home_tile (22250)

```basic
22250 DEF PROCrestore_home_tile REM 22250
22255 REM Find which pad this column belongs to (-1 if hedge)
22260 HP%=-1
22265 IF FX%=PAD0% THEN HP%=0
22266 IF FX%=PAD1% THEN HP%=1
22267 IF FX%=PAD2% THEN HP%=2
22268 IF FX%=PAD3% THEN HP%=3
22269 IF FX%=PAD4% THEN HP%=4
22270 IF HP%=-1 THEN COLOUR 128+0:COLOUR 2:PRINT TAB(FX%,HROW%);CHR$(233);:ENDPROC
22275 IF HFILL%(HP%)=1 THEN COLOUR 128+0:COLOUR 10:PRINT TAB(FX%,HROW%);CHR$(224);:ENDPROC
22280 COLOUR 128+0:COLOUR 10:PRINT TAB(FX%,HROW%);CHR$(229);
22285 ENDPROC
```

Called from `PROCerase_frog` when the frog is on the home row. Uses `PAD0%`–`PAD4%` constants to check which pad column (if any) the frog's X position corresponds to. Three cases:
1. Not a pad column (hedge) → draw bush (`CHR$(233)`) in dark green on black
2. Pad is already filled → draw frog-on-pad (`CHR$(224)`) in bright green on black
3. Pad is empty → draw lily pad (`CHR$(229)`) in bright green on black

In REV1, this was a separate GOSUB target (22250) called from the erase subroutine. In REV2, it's a standalone PROC.

---

## PROCerase_obj_tile (23000)

Erases a game object by replacing it with the appropriate background tile:
- River rows: wave tile (`CHR$(232)`) in current wave colour
- Road rows: space on black background

---

## PROCdraw_obj_tile (24000)

Draws a game object at position CX%,R%. Handles different types:
- River rows use blue background, logs and turtles in appropriate colours
- Road rows use black background, foreground varies by row
- Buses (rows 12, 16) use two-part sprites (230=front, 231=rear)

### Turtle Drawing (24100)
Respects dive states:
- State 2 (submerged): draw wave tile
- States 1/3 (flashing): alternate wave/turtle each tick
- State 0: draw turtle (head in yellow, body in green)

---

## PROCstamp_pad (25000)

```basic
25000 DEF PROCstamp_pad REM 25000
25010 COLOUR 128+0:COLOUR 14
25020 PRINT TAB(FX%,FY%);CHR$(224);
25030 ENDPROC
```

When the frog reaches a home pad, stamps the frog sprite in bright yellow (COLOUR 14) as a permanent marker.

---

## PROCrestore_tile (26000)

```basic
26000 DEF PROCrestore_tile REM 26000
```

Restores the tile at the frog's previous position (`SAVEFX%`, `SAVEFY%`). Skips special rows (0, HROW%, MROW%, SROW%, BROW%) — these are handled by `PROCerase_frog` instead.

For river rows: restores wave tile. For road rows: restores space. Then searches all lane objects on that row and redraws any that occupy the frog's old column (via `PROCredraw_obj_tile` at 26200).

This is a complementary system to `PROCerase_frog`: `PROCerase_frog` handles the single-tile restore when the frog moves (triggered by the movement-gate at line 8185), while `PROCrestore_tile` is called every frame at line 8355 to ensure any lane objects that scrolled under the frog are properly redrawn after the frog moves off them.

---

## PROCredraw_obj_tile (26200)

Parallel to `PROCdraw_obj_tile` (24000), used for redrawing a single tile at a specific position. Respects turtle dive states and lane foreground colours. Called from `PROCrestore_tile` when a lane object needs to be restored at the frog's old column.

---

## Colour Reference

| Code | With 128 (bg) | Colour |
|------|--------------|--------|
| 0 | 128 | Black |
| 1 | 129 | Red |
| 2 | 130 | Green |
| 3 | 131 | Yellow |
| 4 | 132 | Blue |
| 5 | 133 | Magenta |
| 6 | 134 | Cyan |
| 7 | 135 | White |
| 8-15 | 136-143 | Bright variants (+8) |
| 9 | 137 | Bright red |
| 10 | 138 | Bright green |
| 11 | 139 | Bright yellow |
| 12 | 140 | Bright blue |
| 13 | 141 | Bright magenta |
| 14 | 142 | Bright cyan |
| 15 | 143 | Bright white |

---

## Key Agon Light 2 API Reference

- **`COLOUR N`** — Set text colour to N
- **`COLOUR 128+N`** — Set background colour to N
- **`PRINT TAB(col,row);"text"`** — Print at screen position
- **`CHR$(N)`** — Character with code N (used for sprites 224-242)
- **`VDU 23,N,b0..b7`** — Redefine character N's 8x8 bitmap
- **`SOUND channel,amplitude,frequency,duration`** — Play sound. Amplitude -15=max, frequency in Hz, duration in 20ms units
- **`INKEY(N)`** — Wait N centiseconds for key (N>0), or check key state (N<0), or poll buffer (N=0)
- **`INKEY$(0)`** — Read keypress as string without waiting
- **`GET`** — Wait for and return keypress
- **`TIME`** — System timer (increments ~100 times/second)
- **`RND(N)`** — Random 1 to N
- **`OPENIN`/`OPENOUT`** — File open for read/write
- **`MODE N`** — Set screen mode
- **`CLS`** — Clear screen
- **`DIM`** — Allocate array
- **`STRING$(N,char)`** — Repeat a character N times
- **`DATA`/`READ`/`RESTORE`** — Built-in data storage system

---

## REV2 Structural Summary

| Metric | REV1 | REV2 |
|--------|------|------|
| GOSUB calls | 57 | 0 |
| RETURN statements | 47 | 0 |
| DEF PROC declarations | 0 | 47 |
| Unconditional frame erase | Yes | No (gated on movement) |
| EFLAG% dispatch system | Yes | No (draw/erase are separate) |
| ROWS% | 25 (wrong) | 30 (correct) |
| Pad column constants | Hardcoded literals | PAD0%–PAD4% named |
| Median row erase | Black space (invisible `=`) | Explicit `"="` restore |
| FBG% on erase | Computed at top of GOSUB 22000 | Recomputed independently |
