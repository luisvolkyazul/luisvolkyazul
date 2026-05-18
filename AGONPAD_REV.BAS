   10 REM AGONPAD - Simple text editor for Agon Light 2 Microcomputer
   15 REM BY: LUIS A. RAMIREZ 
   20 REM DATE: 2026-05-14
   22 :
   25 MODE 27
   26 COLOUR 132:COLOUR 15
   28 buf$ = ""
   30 DIM lines$(100)
   40 linecount = 0
   50 last = TIME
   60 col = 1
   70 row = 2
   80 maxrow = 31
   90 maxcol = 79 : REM Adjust if your screen is different
   95 :
  100 CLS
  110 REM COLOUR 6 : VDU 31, 70, 0 : PRINT RIGHT$(TIME$, 9);
  120 COLOUR 3 : VDU 31, 36, 0 : PRINT "AGONPAD";
  130 COLOUR 15
  135 :
 1000 REM ================ MAIN LOOP ================
 1010 k$ = INKEY$(0)
 1020 IF TIME - last >= 100 THEN GOSUB 2000 : last = TIME
 1030 IF k$ = "" THEN GOTO 1000
 1040 IF ASC(k$) = 13 THEN GOSUB 3000 : GOTO 1000 : REM 'Enter' Key
 1050 IF ASC(k$) = 19 THEN GOSUB 6000 : GOTO 1000 : REM 'Ctrl + S'
 1060 IF ASC(k$) = 8 OR ASC(k$) = 127 THEN GOSUB 4000 ELSE GOTO 1065
 1061 GOTO 1000
 1065 IF ASC(k$) = 17 THEN GOSUB 7000 ELSE GOTO 1070
 1066 GOTO 1000
 1070 REM Normal character
 1080 IF col >= maxcol THEN GOTO 1000 : REM Prevent overflow
 1090 VDU 31, col, row
 1100 PRINT k$;
 1110 buf$ = buf$ + k$
 1120 col = col + 1
 1130 GOTO 1000
 1135 :
 2000 REM Update clock + title
 2010 REM COLOUR 6 : VDU 31, 70, 0 : PRINT RIGHT$(TIME$, 9);
 2012 PROC_Clock
 2020 COLOUR 3 : VDU 31, 36, 0 : PRINT "AGONPAD";
 2030 COLOUR 15 : REM text colour is white
 2040 VDU 31, col, row
 2050 RETURN
 2055 :
 3000 REM Handle 'Enter' key
 3010 linecount = linecount + 1
 3020 IF linecount <= 100 THEN lines$(linecount) = buf$
 3030 buf$ = ""
 3040 IF row = maxrow THEN GOSUB 5000
 3050 IF row < maxrow THEN row = row + 1
 3060 col = 1
 3070 VDU 31, col, row
 3080 RETURN
 3085 :
 4000 REM Handle 'Backspace' key
 4010 IF col <= 1 OR buf$ = "" THEN RETURN
 4020 col = col - 1
 4030 buf$ = LEFT$(buf$, LEN(buf$) - 1)
 4040 VDU 127
 4070 RETURN
 4075 :
 5000 REM Scroll / Clear text area
 5010 FOR r = 2 TO maxrow
 5020   VDU 31, 1, r
 5030   PRINT SPC(79);
 5040 NEXT r
 5050 row = 2
 5060 RETURN
 6000 REM Save to file
 6010 f% = OPENOUT("AGONPAD.TXT")
 6020 FOR i = 1 TO linecount
 6030   PRINT# f%, lines$(i)
 6040 NEXT i
 6050 CLOSE# f%
 6060 VDU 31, 0, 0
 6070 COLOUR 2 : PRINT " SAVED! "; : COLOUR 15
 6080 VDU 31, col, row
 6090 RETURN
 6095 :
 7000 REM Quit program
 7010 CLS
 7020 VDU 31, 1, 1
 7030 COLOUR 15 : PRINT "Thanks for using Agonpad, Goodbye!"';
 7040 END
 7050 RETURN
 7060 :
 7065 REM CLS
 7067 DEF PROC_Clock
 7070 REM Military to 12-hour live CLOCK
 7080 REM REPEAT
 7090 t$ = MID$(TIME$,17,8)
 7100 h% = VAL(LEFT$(t$,2))
 7110 IF h% = 0 THEN h12 = 12 : a$ = "AM" ELSE IF h% < 12 THEN h12 = h% : a$ = "AM" ELSE IF h% = 12 THEN h12 = 12 : a$ = "PM" ELSE h12 = h% - 12 : a$ = "PM"
 7120 hs$ = FNz(h12)
 7130 COLOUR 6: VDU 31, 60, 0: PRINT "Time: ";hs$;MID$(t$,3,6);" ";a$
 7140 REM WAIT 100
 7150 REM UNTIL FALSE
 7155 ENDPROC
 7160 DEF FNz(n)
 7170 IF n < 10 THEN
 7180   = "0" + STR$(n)
 7190 ELSE
 7200   = STR$(n)
 7210 ENDIF
 7220 ENDFN
