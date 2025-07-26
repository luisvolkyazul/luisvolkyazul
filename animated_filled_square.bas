10 REM Animated Filled Square
20 MODE 8
30 CLG
40 PRINT "Animating a filled square..."
50 GCOL 0, 6
60 x = 50 : y = 50
70 dx = 2 : dy = 2
80 REPEAT
90   CLG
100  VDU 25, 0, x; y;
110  VDU 25, 101, x+50; y+50;
120  x = x + dx
130  y = y + dy
140  IF x <= 0 OR x+50 >= 1280 THEN dx = -dx
150  IF y <= 0 OR y+50 >= 1024 THEN dy = -dy
160  FOR delay = 1 TO 100
170    REM Delay loop
180  NEXT delay
190 UNTIL INKEY(1) <> -1
200 CLS
210 PRINT "Animation stopped."
220 END
