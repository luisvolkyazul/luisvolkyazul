10 REM Animated Shapes with PLOT 5 and VDU
20 MODE 8
30 CLG
40 PRINT "Animating shapes..."
50 REM Initialize positions and velocities
60 x1 = 50 : y1 = 50 : dx1 = 2 : dy1 = 2 : REM Square
70 x2 = 100 : y2 = 100 : dx2 = 3 : dy2 = 1 : REM Triangle
80 x3 = 150 : y3 = 50 : dx3 = 1 : dy3 = 2 : REM Circle
90 x4 = 50 : y4 = 100 : dx4 = 2 : dy4 = 3 : REM Filled Rectangle
100 GCOL 0, RND(15)
110 REPEAT
120   CLG
130   REM Draw Square
140   MOVE x1, y1
150   PLOT 5, x1+40, y1
160   PLOT 5, x1+40, y1+40
170   PLOT 5, x1, y1+40
180   PLOT 5, x1, y1
190   REM Draw Triangle
200   MOVE x2, y2
210   PLOT 5, x2+40, y2
220   PLOT 5, x2+20, y2+40
230   PLOT 5, x2, y2
240   REM Draw Circle (point-by-point)
250   FOR angle = 0 TO 360 STEP 5
260     rad = angle * PI / 180
270     cx = x3 + 20 * COS(rad)
280     cy = y3 + 20 * SIN(rad)
290     PLOT 69, cx, cy
300   NEXT angle
310   REM Draw Filled Rectangle
320   REM VDU 25, 0, x4; y4;
330   REM VDU 25, 101, x4+50; y4+30;
340   REM Update positions
350   x1 = x1 + dx1 : y1 = y1 + dy1
360   x2 = x2 + dx2 : y2 = y2 + dy2
370   x3 = x3 + dx3 : y3 = y3 + dy3
380   REM x4 = x4 + dx4 : y4 = y4 + dy4
390   REM Bounce off edges
400   IF x1 <= 0 OR x1+40 >= 1280 THEN dx1 = -dx1
410   IF y1 <= 0 OR y1+40 >= 1024 THEN dy1 = -dy1
420   IF x2 <= 0 OR x2+40 >= 1280 THEN dx2 = -dx2
430   IF y2 <= 0 OR y2+40 >= 1024 THEN dy2 = -dy2
440   IF x3 <= 0 OR x3+40 >= 1280 THEN dx3 = -dx3
450   IF y3 <= 0 OR y3+40 >= 1024 THEN dy3 = -dy3
460   REM IF x4 <= 0 OR x4+50 >= 1280 THEN dx4 = -dx4
470   REM IF y4 <= 0 OR y4+30 >= 1024 THEN dy4 = -dy4
480   FOR delay = 1 TO 5
490     REM Delay loop
500   NEXT delay
510 UNTIL INKEY(1) <> -1
520 CLS
530 PRINT "Animation stopped."
540 END
