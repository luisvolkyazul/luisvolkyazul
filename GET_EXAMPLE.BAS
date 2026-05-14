   10 REM > GET_EXAMPLE.BAS
   20 REM Demonstrates GET$(x,y) to read characters from screen
   30 REM GET$(x,y) returns the character at text column x, row y (0-indexed)
   40 :
   50 MODE 0
   60 CLS
   70 :
   80 REM Write test data to screen: line 1 = A-Z repeating
   90 FOR I% = 1 TO 52
  100   VDU 65 + ((I%-1) MOD 26)
  110 NEXT
  120 PRINT
  130 :
  140 REM Line 2 = a-z repeating
  150 FOR I% = 1 TO 52
  160   VDU 97 + ((I%-1) MOD 26)
  170 NEXT
  180 PRINT
  190 :
  191 REM Line 3 = 1-0 repeating
  192 FOR I% = 1 TO 52 
  193   VDU 48 + ((I%-1) MOD 10)
  194 NEXT
  195 PRINT'
  196 :
  200 REM Read back first 52 chars from row 0 (top row) using GET$(x,y)
  210 line1$ = ""
  220 FOR X% = 0 TO 51
  230   line1$ = line1$ + GET$(X%, 0)
  240 NEXT
  250 :
  260 REM Read back first 52 chars from row 1 (second row)
  270 line2$ = ""
  280 FOR X% = 0 TO 51
  290   line2$ = line2$ + GET$(X%, 1)
  300 NEXT
  310 :
  311 REM Read back first 52 chars from row 3 (third row)
  312 line3$ = ""
  314 FOR X% = 0 TO 51
  315   line3$ = line3$ + GET$(X%, 2)
  316 NEXT
  317 :
  320 PRINT "Row 0: "; line1$;" --> Line 1"
  330 PRINT "Row 1: "; line2$;" --> Line 2"
  335 PRINT "Row 2: "; line3$;" --> Line 3 (Index)"
  340 END
