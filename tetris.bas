REM ************************************************
REM * TETRIS CLONE FOR AGON LIGHT 2 MICROCOMPUTER *
REM * Written in BBC BASIC V for Z80              *
REM * Compatible with latest Agon firmware        *
REM * Author: AI Assistant                        *
REM * Version: 1.0                                *
REM ************************************************

REM Initialize game variables
DIM board%(20, 10)     : REM Game board 20 rows x 10 columns
DIM piece%(4, 4)       : REM Current piece 4x4 matrix
DIM nextpiece%(4, 4)   : REM Next piece 4x4 matrix
DIM tetrominoes%(7, 4, 4, 4) : REM All tetromino shapes and rotations

REM Game state variables
currentpiece% = 0      : REM Current piece type (0-6)
nextpiecetype% = 0     : REM Next piece type
piecex% = 4           : REM Current piece X position
piecey% = 0           : REM Current piece Y position
rotation% = 0         : REM Current rotation (0-3)
score% = 0            : REM Player score
lines% = 0            : REM Lines cleared
level% = 1            : REM Current level
droptime% = 60        : REM Frames between automatic drops
dropcount% = 0        : REM Frame counter for auto-drop
gameover% = FALSE     : REM Game over flag
paused% = FALSE       : REM Pause flag

REM Screen offsets for drawing
boardx% = 10          : REM Board X offset
boardy% = 2           : REM Board Y offset
blocksize% = 20       : REM Size of each block in pixels

REM Initialize the game
PROC_InitializeGame

REM Main game loop
REPEAT
  IF NOT paused% AND NOT gameover% THEN
    PROC_HandleInput
    PROC_UpdateGame
    PROC_DrawScreen
  ELSE
    PROC_HandleMenuInput
  ENDIF
  
  REM Wait for next frame (approximately 60 FPS)
  TIME = 0
  REPEAT UNTIL TIME >= 2
UNTIL FALSE

END

REM ************************************************
REM * INITIALIZATION PROCEDURES                   *
REM ************************************************

DEF PROC_InitializeGame
  REM Set graphics mode - MODE 8 (320x256, 64 colors)
  MODE 8
  VDU 23,1,0;0;0;0;  : REM Disable cursor
  CLG               : REM Clear graphics
  CLS               : REM Clear text
  
  REM Initialize board (0 = empty, 1-7 = piece colors)
  FOR row% = 0 TO 19
    FOR col% = 0 TO 9
      board%(row%, col%) = 0
    NEXT col%
  NEXT row%
  
  REM Define tetromino pieces
  PROC_DefineTetrominos
  
  REM Generate first pieces
  currentpiece% = RND(7) - 1
  nextpiecetype% = RND(7) - 1
  PROC_SpawnNewPiece
  
  REM Set initial game state
  score% = 0
  lines% = 0
  level% = 1
  droptime% = 60 - (level% * 5)
  IF droptime% < 10 THEN droptime% = 10
  
  REM Draw initial screen
  PROC_DrawGameBorder
  PROC_DrawUI
ENDPROC

DEF PROC_DefineTetrominos
  REM Define all 7 tetromino pieces with 4 rotations each
  REM I-piece (cyan)
  DATA 0,0,0,0, 1,1,1,1, 0,0,0,0, 0,0,0,0
  DATA 0,0,1,0, 0,0,1,0, 0,0,1,0, 0,0,1,0
  DATA 0,0,0,0, 0,0,0,0, 1,1,1,1, 0,0,0,0
  DATA 0,1,0,0, 0,1,0,0, 0,1,0,0, 0,1,0,0
  
  REM O-piece (yellow)
  DATA 0,1,1,0, 0,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,1,0, 0,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,1,0, 0,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,1,0, 0,1,1,0, 0,0,0,0, 0,0,0,0
  
  REM T-piece (purple)
  DATA 0,1,0,0, 1,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,0,0, 0,1,1,0, 0,1,0,0, 0,0,0,0
  DATA 0,0,0,0, 1,1,1,0, 0,1,0,0, 0,0,0,0
  DATA 0,1,0,0, 1,1,0,0, 0,1,0,0, 0,0,0,0
  
  REM S-piece (green)
  DATA 0,1,1,0, 1,1,0,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,0,0, 0,1,1,0, 0,0,1,0, 0,0,0,0
  DATA 0,0,0,0, 0,1,1,0, 1,1,0,0, 0,0,0,0
  DATA 1,0,0,0, 1,1,0,0, 0,1,0,0, 0,0,0,0
  
  REM Z-piece (red)
  DATA 1,1,0,0, 0,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,0,1,0, 0,1,1,0, 0,1,0,0, 0,0,0,0
  DATA 0,0,0,0, 1,1,0,0, 0,1,1,0, 0,0,0,0
  DATA 0,1,0,0, 1,1,0,0, 1,0,0,0, 0,0,0,0
  
  REM J-piece (blue)
  DATA 1,0,0,0, 1,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,1,0, 0,1,0,0, 0,1,0,0, 0,0,0,0
  DATA 0,0,0,0, 1,1,1,0, 0,0,1,0, 0,0,0,0
  DATA 0,1,0,0, 0,1,0,0, 1,1,0,0, 0,0,0,0
  
  REM L-piece (orange)
  DATA 0,0,1,0, 1,1,1,0, 0,0,0,0, 0,0,0,0
  DATA 0,1,0,0, 0,1,0,0, 0,1,1,0, 0,0,0,0
  DATA 0,0,0,0, 1,1,1,0, 1,0,0,0, 0,0,0,0
  DATA 1,1,0,0, 0,1,0,0, 0,1,0,0, 0,0,0,0
  
  REM Read data into tetromino array
  FOR piece% = 0 TO 6
    FOR rot% = 0 TO 3
      FOR row% = 0 TO 3
        FOR col% = 0 TO 3
          READ tetrominoes%(piece%, rot%, row%, col%)
        NEXT col%
      NEXT row%
    NEXT rot%
  NEXT piece%
ENDPROC

REM ************************************************
REM * GAME LOGIC PROCEDURES                       *
REM ************************************************

DEF PROC_HandleInput
  LOCAL key%
  key% = INKEY(0)
  
  IF key% <> -1 THEN
    CASE key% OF
      WHEN 8, 136: REM Left arrow / A
        IF FUNC_ValidMove(piecex% - 1, piecey%, rotation%) THEN
          piecex% = piecex% - 1
        ENDIF
      
      WHEN 21, 137: REM Right arrow / D
        IF FUNC_ValidMove(piecex% + 1, piecey%, rotation%) THEN
          piecex% = piecex% + 1
        ENDIF
      
      WHEN 10, 138: REM Down arrow / S
        IF FUNC_ValidMove(piecex%, piecey% + 1, rotation%) THEN
          piecey% = piecey% + 1
          score% = score% + 1  : REM Bonus points for soft drop
        ENDIF
      
      WHEN 11, 139: REM Up arrow / W (rotate)
        LOCAL newrot%
        newrot% = (rotation% + 1) MOD 4
        IF FUNC_ValidMove(piecex%, piecey%, newrot%) THEN
          rotation% = newrot%
        ENDIF
      
      WHEN 32: REM Space (hard drop)
        REPEAT
          IF FUNC_ValidMove(piecex%, piecey% + 1, rotation%) THEN
            piecey% = piecey% + 1
            score% = score% + 2  : REM More bonus points for hard drop
          ENDIF
        UNTIL NOT FUNC_ValidMove(piecex%, piecey% + 1, rotation%)
        PROC_LockPiece
      
      WHEN 112, 80: REM P (pause)
        paused% = NOT paused%
        IF paused% THEN
          PROC_ShowPauseMessage
        ELSE
          PROC_DrawScreen
        ENDIF
      
      WHEN 27: REM Escape (quit)
        gameover% = TRUE
    ENDCASE
  ENDIF
ENDPROC

DEF PROC_HandleMenuInput
  LOCAL key%
  key% = INKEY(0)
  
  IF key% <> -1 THEN
    CASE key% OF
      WHEN 112, 80: REM P (unpause)
        IF paused% THEN
          paused% = FALSE
          PROC_DrawScreen
        ENDIF
      
      WHEN 13: REM Enter (restart after game over)
        IF gameover% THEN
          PROC_InitializeGame
          gameover% = FALSE
        ENDIF
      
      WHEN 27: REM Escape (quit)
        END
    ENDCASE
  ENDIF
ENDPROC

DEF PROC_UpdateGame
  REM Auto-drop timing
  dropcount% = dropcount% + 1
  IF dropcount% >= droptime% THEN
    dropcount% = 0
    IF FUNC_ValidMove(piecex%, piecey% + 1, rotation%) THEN
      piecey% = piecey% + 1
    ELSE
      PROC_LockPiece
    ENDIF
  ENDIF
ENDPROC

DEF FUNC_ValidMove(x%, y%, rot%)
  LOCAL row%, col%, boardrow%, boardcol%
  
  FOR row% = 0 TO 3
    FOR col% = 0 TO 3
      IF tetrominoes%(currentpiece%, rot%, row%, col%) = 1 THEN
        boardrow% = y% + row%
        boardcol% = x% + col%
        
        REM Check boundaries
        IF boardcol% < 0 OR boardcol% >= 10 OR boardrow% >= 20 THEN
          = FALSE
        ENDIF
        
        REM Check collision with existing pieces
        IF boardrow% >= 0 AND board%(boardrow%, boardcol%) <> 0 THEN
          = FALSE
        ENDIF
      ENDIF
    NEXT col%
  NEXT row%
  
  = TRUE

DEF PROC_LockPiece
  LOCAL row%, col%, boardrow%, boardcol%
  
  REM Place piece on board
  FOR row% = 0 TO 3
    FOR col% = 0 TO 3
      IF tetrominoes%(currentpiece%, rotation%, row%, col%) = 1 THEN
        boardrow% = piecey% + row%
        boardcol% = piecex% + col%
        IF boardrow% >= 0 AND boardrow% < 20 AND boardcol% >= 0 AND boardcol% < 10 THEN
          board%(boardrow%, boardcol%) = currentpiece% + 1
        ENDIF
      ENDIF
    NEXT col%
  NEXT row%
  
  REM Check for completed lines
  PROC_CheckLines
  
  REM Spawn next piece
  currentpiece% = nextpiecetype%
  nextpiecetype% = RND(7) - 1
  PROC_SpawnNewPiece
  
  REM Check for game over
  IF NOT FUNC_ValidMove(piecex%, piecey%, rotation%) THEN
    gameover% = TRUE
    PROC_ShowGameOver
  ENDIF
ENDPROC

DEF PROC_SpawnNewPiece
  piecex% = 4
  piecey% = 0
  rotation% = 0
ENDPROC

DEF PROC_CheckLines
  LOCAL row%, col%, complete%, linescleared%
  linescleared% = 0
  
  FOR row% = 19 TO 0 STEP -1
    complete% = TRUE
    FOR col% = 0 TO 9
      IF board%(row%, col%) = 0 THEN
        complete% = FALSE
      ENDIF
    NEXT col%
    
    IF complete% THEN
      PROC_ClearLine(row%)
      linescleared% = linescleared% + 1
      row% = row% + 1  : REM Check same row again after clearing
    ENDIF
  NEXT row%
  
  REM Update score and level
  IF linescleared% > 0 THEN
    lines% = lines% + linescleared%
    
    REM Scoring system (standard Tetris scoring)
    CASE linescleared% OF
      WHEN 1: score% = score% + 40 * (level% + 1)
      WHEN 2: score% = score% + 100 * (level% + 1)
      WHEN 3: score% = score% + 300 * (level% + 1)
      WHEN 4: score% = score% + 1200 * (level% + 1)  : REM Tetris!
    ENDCASE
    
    REM Level up every 10 lines
    level% = (lines% DIV 10) + 1
    droptime% = 60 - (level% * 5)
    IF droptime% < 5 THEN droptime% = 5
    
    REM Play sound effect
    PROC_PlayLineClearSound(linescleared%)
  ENDIF
ENDPROC

DEF PROC_ClearLine(linenum%)
  LOCAL row%, col%
  
  REM Flash the line before clearing
  FOR flash% = 1 TO 3
    FOR col% = 0 TO 9
      PROC_DrawBlock(boardx% + col% * blocksize%, boardy% + linenum% * blocksize%, 15)
    NEXT col%
    TIME = 0: REPEAT UNTIL TIME >= 5
    
    FOR col% = 0 TO 9
      PROC_DrawBlock(boardx% + col% * blocksize%, boardy% + linenum% * blocksize%, board%(linenum%, col%))
    NEXT col%
    TIME = 0: REPEAT UNTIL TIME >= 5
  NEXT flash%
  
  REM Move all lines above down by one
  FOR row% = linenum% TO 1 STEP -1
    FOR col% = 0 TO 9
      board%(row%, col%) = board%(row% - 1, col%)
    NEXT col%
  NEXT row%
  
  REM Clear top line
  FOR col% = 0 TO 9
    board%(0, col%) = 0
  NEXT col%
ENDPROC

REM ************************************************
REM * GRAPHICS AND DISPLAY PROCEDURES             *
REM ************************************************

DEF PROC_DrawScreen
  REM Clear play area
  GCOL 0, 0
  RECTANGLE FILL boardx%, boardy%, 200, 400
  
  REM Draw board
  FOR row% = 0 TO 19
    FOR col% = 0 TO 9
      IF board%(row%, col%) <> 0 THEN
        PROC_DrawBlock(boardx% + col% * blocksize%, boardy% + row% * blocksize%, board%(row%, col%))
      ENDIF
    NEXT col%
  NEXT row%
  
  REM Draw current piece
  PROC_DrawCurrentPiece
  
  REM Draw next piece
  PROC_DrawNextPiece
  
  REM Update UI
  PROC_DrawUI
ENDPROC

DEF PROC_DrawCurrentPiece
  LOCAL row%, col%, x%, y%
  
  FOR row% = 0 TO 3
    FOR col% = 0 TO 3
      IF tetrominoes%(currentpiece%, rotation%, row%, col%) = 1 THEN
        x% = boardx% + (piecex% + col%) * blocksize%
        y% = boardy% + (piecey% + row%) * blocksize%
        PROC_DrawBlock(x%, y%, currentpiece% + 1)
      ENDIF
    NEXT col%
  NEXT row%
ENDPROC

DEF PROC_DrawBlock(x%, y%, colorcode%)
  LOCAL color%
  
  REM Map piece types to colors
  CASE colorcode% OF
    WHEN 0: color% = 0   : REM Empty - black
    WHEN 1: color% = 11  : REM I-piece - cyan
    WHEN 2: color% = 14  : REM O-piece - yellow
    WHEN 3: color% = 13  : REM T-piece - magenta
    WHEN 4: color% = 10  : REM S-piece - green
    WHEN 5: color% = 9   : REM Z-piece - red
    WHEN 6: color% = 12  : REM J-piece - blue
    WHEN 7: color% = 6   : REM L-piece - orange
    OTHERWISE: color% = 15  : REM White for special effects
  ENDCASE
  
  REM Draw filled block with border
  GCOL 0, color%
  RECTANGLE FILL x%, y%, blocksize% - 2, blocksize% - 2
  
  REM Draw border for visibility
  IF colorcode% <> 0 THEN
    GCOL 0, 15  : REM White border
    RECTANGLE x%, y%, blocksize% - 2, blocksize% - 2
  ENDIF
ENDPROC

DEF PROC_DrawGameBorder
  REM Draw game board border
  GCOL 0, 15
  RECTANGLE boardx% - 2, boardy% - 2, 204, 404
  
  REM Draw next piece area border
  RECTANGLE 230, 50, 84, 84
  
  REM Draw labels
  MOVE 230, 40
  PRINT "NEXT:"
  
  MOVE 230, 150
  PRINT "SCORE:"
  
  MOVE 230, 200
  PRINT "LINES:"
  
  MOVE 230, 250
  PRINT "LEVEL:"
ENDPROC

DEF PROC_DrawNextPiece
  LOCAL row%, col%, x%, y%
  
  REM Clear next piece area
  GCOL 0, 0
  RECTANGLE FILL 232, 52, 80, 80
  
  REM Draw next piece
  FOR row% = 0 TO 3
    FOR col% = 0 TO 3
      IF tetrominoes%(nextpiecetype%, 0, row%, col%) = 1 THEN
        x% = 232 + col% * 18
        y% = 52 + row% * 18
        GCOL 0, nextpiecetype% + 1
        RECTANGLE FILL x%, y%, 16, 16
        GCOL 0, 15
        RECTANGLE x%, y%, 16, 16
      ENDIF
    NEXT col%
  NEXT row%
ENDPROC

DEF PROC_DrawUI
  REM Clear UI area
  GCOL 0, 0
  RECTANGLE FILL 280, 150, 100, 150
  
  REM Display score, lines, level
  MOVE 280, 170
  PRINT score%
  
  MOVE 280, 220
  PRINT lines%
  
  MOVE 280, 270
  PRINT level%
ENDPROC

DEF PROC_ShowPauseMessage
  GCOL 0, 0
  RECTANGLE FILL 60, 150, 200, 60
  GCOL 0, 15
  RECTANGLE 60, 150, 200, 60
  MOVE 110, 180
  PRINT "PAUSED"
  MOVE 80, 190
  PRINT "Press P to continue"
ENDPROC

DEF PROC_ShowGameOver
  GCOL 0, 0
  RECTANGLE FILL 60, 150, 200, 80
  GCOL 0, 15
  RECTANGLE 60, 150, 200, 80
  MOVE 110, 180
  PRINT "GAME OVER"
  MOVE 85, 200
  PRINT "Press ENTER to restart"
  MOVE 95, 210
  PRINT "Press ESC to quit"
ENDPROC

REM ************************************************
REM * SOUND PROCEDURES                            *
REM ************************************************

DEF PROC_PlayLineClearSound(numlines%)
  LOCAL i%, freq%, duration%
  
  CASE numlines% OF
    WHEN 1:
      SOUND 1, -15, 200, 10
    WHEN 2:
      FOR i% = 1 TO 2
        SOUND 1, -15, 200 + i% * 50, 8
      NEXT i%
    WHEN 3:
      FOR i% = 1 TO 3
        SOUND 1, -15, 200 + i% * 50, 6
      NEXT i%
    WHEN 4: REM Tetris!
      FOR i% = 1 TO 4
        SOUND 1, -15, 300 + i% * 100, 15
      NEXT i%
  ENDCASE
ENDPROC

REM ************************************************
REM * PROGRAM DATA                                *
REM ************************************************

REM Controls information
REM Arrow Keys / WASD: Move and rotate pieces
REM Space: Hard drop
REM P: Pause/Unpause
REM ESC: Quit game
REM Enter: Restart after game over