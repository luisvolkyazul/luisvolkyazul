10 REM Cursor movement for Agon Light 2





20 REM Arrow keys move @ cursor, ESC exits





30 *FX 4,1





40 MODE 24





50 CLS





60 x = 40





70 y = 16





80 PRINT TAB(x,y) "@";





90 K = INKEY(10)





100 IF K = 27 THEN END





110 IF K = -1 THEN 90





120 IF K < 136 OR K > 139 THEN 90





130 old_x = x





140 old_y = y





150 IF K = 136 THEN x = x - 1





160 IF K = 137 THEN x = x + 1





170 IF K = 138 THEN y = y + 1





180 IF K = 139 THEN y = y - 1





190 IF x < 0 THEN x = 0





200 IF x > 79 THEN x = 79





210 IF y < 0 THEN y = 0





220 IF y > 31 THEN y = 31





230 IF old_x <> x OR old_y <> y THEN PRINT TAB(old_x, old_y) " "; : PRINT TAB(x, y) "@";





240 GOTO 90





