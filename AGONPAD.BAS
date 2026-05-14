   10 last = TIME
   20 col = 1
   30 row = 2
   35 maxrow = 31
   40 CLS
   50 VDU 31, 2, 0
   60 COLOUR 6: PRINT RIGHT$(TIME$, 8);:VDU 31, 36, 0:COLOUR 3: PRINT "AGONPAD";
   62 COLOUR 15
   65 :
 1000 REM Handle keypress
 1010 k$ = INKEY$(0)
 1020 IF TIME - last >= 100 THEN GOSUB 2000: last = TIME
 1030 IF k$ = "" THEN GOTO 1000
 1040 IF ASC(k$) = 13 THEN GOSUB 3000: GOTO 1000
 1045 IF ASC(k$) = 8 THEN GOSUB 4000: GOTO 1000
 1050 VDU 31, col, row
 1060 PRINT k$;
 1070 col = col + 1
 1080 GOTO 1000
 1085 :
 2000 REM Update clock
 2010 COLOUR 6: VDU 31, 2, 0
 2020 PRINT RIGHT$(TIME$, 8);:VDU 31, 36, 0: COLOUR 3: PRINT "AGONPAD";
 2030 COLOUR 15: VDU 31, col, row
 2040 RETURN
 2045 :
 3000 REM Handle return key
 3010 IF row = maxrow THEN GOSUB 5000
 3020 IF row < maxrow THEN row = row + 1
 3030 col = 1
 3040 VDU 31, col, row
 3050 RETURN
 3085 :
 4000 REM Handle backspace
 4010 IF col <= 1 THEN RETURN
 4020 col = col - 1
 4030 VDU 31, col, row
 4040 PRINT " ";
 4050 VDU 31, col, row
 4060 RETURN
 4065 :
 5000 REM Clear text area
 5010 FOR r = 2 TO maxrow
 5020   VDU 31, 1, r
 5030   PRINT SPC(77);
 5040 NEXT r
 5050 row = 2
 5060 RETURN
