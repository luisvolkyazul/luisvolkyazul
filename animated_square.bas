10 REM Animated Square with PLOT 5
20 MODE 8
30 CLG
40 PRINT "Animating a square..."
50 GCOL 0, 2 : REM green color for square
60 x = 50 : y = 50
70 dx = 2 : dy = 2
80 REPEAT
90   CLG
100  MOVE x, y
110  PLOT 5, x+50, y
120  PLOT 5, x+50, y+50
130  PLOT 5, x, y+50
140  PLOT 5, x, y
150  x = x + dx
160  y = y + dy
170  IF x <= 0 OR x+50 >= 1280 THEN dx = -dx
180  IF y <= 0 OR y+50 >= 1024 THEN dy = -dy
190  FOR delay = 1 TO 100
200    REM Delay loop
210  NEXT delay
220 UNTIL INKEY(1) <> -1
230 CLS
240 PRINT "Animation stopped."
250 END
