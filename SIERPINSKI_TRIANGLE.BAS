   10 REM Sierpinski Triangle
   20 M% = 27
   30 PROC_INITIALIZE
   35 COLOUR 1: PRINT TAB(1,1) "Sierpinski Triangle - Agon Light 2"
   40 REM Screen dimensions
   50 W = W% * 16
   60 H = H% * 32
   70 REM Triangle vertices
   80 x1 = W / 2 : y1 = H - 20
   90 x2 = 20    : y2 = 20
  100 x3 = W - 20: y3 = 20
  110 REM Start point
  120 x = W / 2
  130 y = H / 2
  140 GCOL 0, RND(C%)
  150 FOR i = 1 TO 80000
  160   r = RND(3)
  170   IF r = 1 THEN
  180     x = (x + x1) / 2
  190     y = (y + y1) / 2
  200   ELSE IF r = 2 THEN
  210       x = (x + x2) / 2
  220       y = (y + y2) / 2
  230     ELSE
  240       x = (x + x3) / 2
  250       y = (y + y3) / 2
  260     ENDIF
  265   ENDIF
  267   GCOL 0, RND(C%)
  270   PLOT 69, x, y
  280 NEXT i
  290 END
  295 :
  300 REM GET SYSTEM VARIABLES
  310 DEF FN_GETBYTE_VDP(V%)
  320 A% = &A0
  330 L% = V%
  340 = USR(&FFF4)
  350 :
  360 REM INITIALIZE
  370 DEF PROC_INITIALIZE
  380 BG% = 132
  390 FG% = 15
  395 *FX 19
  400 MODE M%
  410 COLOUR BG% : COLOUR FG% : CLS
  420 W% = FN_GETBYTE_VDP(&13) : REM GET SCREEN WIDTH
  430 H% = FN_GETBYTE_VDP(&14) : REM GET SCREEN HEIGHT
  440 C% = FN_GETBYTE_VDP(&15) : REM GET NUMBER OF AVAILABLE COLORS
  450 ENDPROC: REM END PROC_INITIALIZE
  460 :
