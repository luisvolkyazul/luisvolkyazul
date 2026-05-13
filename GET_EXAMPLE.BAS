   10 REM > GET_EXAMPLE.BAS
   20 REM Demonstrates GET$(x,y) to read characters from screen
   30 REM GET$(x,y) returns the character at text column x, row y (0-indexed)
   40 :
   50 MODE 0
   60 CLS
   70 :
   80 REM Write test data to screen: line 1 = A-Z repeating
   90 FOR I% = 1 TO 50
  100   VDU 65 + ((I%-1) MOD 26)
  110 NEXT
  120 PRINT
  130 :
  140 REM Line 2 = a-z repeating
  150 FOR I% = 1 TO 50
  160   VDU 97 + ((I%-1) MOD 26)
  170 NEXT
  180 PRINT
  190 :
  200 REM Read back first 50 chars from row 0 (top row) using GET$(x,y)
  210 line1$ = ""
  220   FOR X% = 0 TO 49
  230   line1$ = line1$ + GET$(X%, 0)
  240 NEXT
  250 :
  260 REM Read back first 50 chars from row 1 (second row)
  270 line2$ = ""
  280   FOR X% = 0 TO 49
  290   line2$ = line2$ + GET$(X%, 1)
  300 NEXT
  310 :
  320 PRINT "Row 0: "; line1$
  330 PRINT "Row 1: "; line2$
  340 END
