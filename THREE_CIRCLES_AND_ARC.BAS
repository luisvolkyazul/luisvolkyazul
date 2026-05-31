   10 REM THREE_CIRCLES_AND_ARC.BAS
   20 MODE 20
   30 cx% = 640
   40 cy% = 512
   50 r% = 350: REM radius
   60 :
   70 REM OUTER CIRCLE (ABSOLUTE)
   80 GCOL 0, 11: REM BRIGHT YELLOW
   90 MOVE cx%, cy%: REM SET CENTRE
  100 PLOT 149, cx%, 712: REM POINT ON CIRCUMFERENCE
  110 REM RADIUS = 712 - 512 = 200
  120 :
  130 REM INNER CIRCLE
  140 GCOL 0, 12: REM BRIGHT BLUE
  150 MOVE cx%, cy%: REM CENTRE
  160 PLOT 145, 0, 180: REM RADIUS 180 (RELATIVE)
  170 :
  180 REM FILLED CIRCLE
  190 GCOL 0, 10: REM BRIGHT GREEN COLOR
  200 MOVE cx%, cy%: REM CENTRE
  210 PLOT 153, 0, 50: REM RADIUS 50 (RELATIVE)
  220 :
  230 REM ADDING AN ARC
  240 GCOL 0, 9: REM BRIGHT RED COLOR
  250 REM arc from 0 degrees (right) to 90 degrees (top)
  260 MOVE cx%, cy%: REM visit centre
  270 MOVE cx% + r%, cy%: REM visit arc start (3 o'clock)
  280 PLOT 165, cx%, cy% + r%: REM arc stop (12 o'clock)
  290 END
