    1 n=0
    2 VDU 23, 0, &C0, n: REM Use n=1 for logical screen scaling on, other wise change last value to 0 to turn it off.
    5 CLS
   10 REM Sierpinski Triangle
   15 INPUT"SELECT MODE NUMBER: "M%
   20 REM M% = 27
   30 PROC_INITIALIZE
   35 COLOUR RND(C%): PRINT TAB((cols%-34)/2,(rows%/2)-1) "Sierpinski Triangle - Agon Light 2"'
   40 REM Screen dimensions
   50 W = W%
   60 H = H%
   70 REM Triangle vertices
   80 x1 = W / 2 : y1 = H - 20
   90 x2 = 20    : y2 = 20
  100 x3 = W - 20: y3 = 20
  110 REM Start point
  120 x = W / 2
  130 y = H / 2
  140 COLOUR FG%
  150 FOR i = 1 TO 10000
  151   PRINT TAB(1,0)"screen scaling: ";:IF n=0 THEN PRINT"OFF" ELSE PRINT"ON"
  155   PRINT TAB(1,1)"x: ";x:PRINT TAB(1,2)"y: ";y:REM inspect values for x,y
  156   PRINT TAB(1,3)"W%: ";W%:PRINT TAB(1,4)"H%: ";H%:REM inspect values for W%,H%
  158   PRINT TAB(1,5)"cols%: ";cols%:PRINT TAB(1,6)"rows%: ";rows%:REM inspect values for cols%, rows%
  159   PRINT TAB(1,7)"MODE: ";M%;
  160   r = RND(3)
  165   PRINT TAB(1,8)"r: ";r
  166   PRINT TAB(1,9)"i:";i
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
  266   dot_color = RND(C%)
  267   GCOL 0, dot_color :PRINT TAB(1,10)"Number of colors: ";C% : PRINT TAB(1,11)"dot_color: ";dot_color'
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
  395 REM *FX 19
  400 MODE M%
  410 COLOUR BG% : COLOUR FG% : CLS
  420 cols% = FN_GETBYTE_VDP(&13) : REM GET number of columns
  421 W% = FN_w(&F) : REM attempting to get screen x value
  430 rows% = FN_GETBYTE_VDP(&14) : REM GET number of rows
  431 H% = FN_w(&11): REM attempting to get screen y value
  440 C% = FN_GETBYTE_VDP(&15) : REM GET NUMBER OF AVAILABLE COLORS
  450 ENDPROC: REM END PROC_INITIALIZE
  460 :
  500 REM Obtain values for screen size
  505 DEF FN_s(o%): L%=o%: A%=&A0: =USR(&FFF4) AND &FF
  510 DEF FN_w(o%): =FN_s(o%) + FN_s(o% + 1) * 256
