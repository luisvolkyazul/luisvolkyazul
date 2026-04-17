1  CLS
5  PRINT "XML READING PROGRAM IN BBC BASIC V (DEBUG MODE)"

10 REM ============================
20 REM MAIN PROGRAM
30 REM ============================
40 success% = FALSE
50 text$ = FNreadFileDebug$("message.xml")

60 IF text$ = "" THEN
70   PRINT "Error: File is empty or could not be read"
80 ELSE
90   message$ = FNextractMessage$(text$)
100  IF message$ = "" THEN
110    PRINT "Error: <message> tags not found or invalid"
120  ELSE
130    success% = TRUE
140  ENDIF
150 ENDIF

160 IF success% THEN PROCdisplayMessage(message$)

170 END


1000 REM ============================
1010 REM READ FILE BYTE-BY-BYTE (DEBUG)
1020 REM ============================
1030 DEF FNreadFileDebug$(filename$)
1040 LOCAL file%, byte%, text$, bytes%

1050 file% = OPENIN(filename$)
1060 IF file% = 0 THEN
1070   PRINT "Error: Could not open "; filename$
1080   PRINT "Check file with CAT /mos"
1090   = ""
1100 ENDIF

1110 PRINT "Debug: File opened, handle = "; file%

1120 text$ = ""
1130 bytes% = 0

1140 REPEAT
1150   byte% = BGET#file%

1160   IF NOT EOF#file% THEN
1170     IF LEN(text$) < 255 THEN

1180       text$ += CHR$(byte%)
1190       bytes% += 1

1200       REM --- DEBUG OUTPUT (REAL LINE NUMBER DISPLAY) ---
1210       PRINT "Line "; 1200 + bytes%; ": Byte "; bytes%; " = ";

1220       IF byte% = 13 THEN
1230         PRINT "CR (ASCII 13)"
1240       ELSE
1250         IF byte% = 10 THEN
1260           PRINT "LF (ASCII 10)"
1270         ELSE
1280           PRINT CHR$(byte%); " (ASCII "; byte%; ")"
1290         ENDIF
1300       ENDIF

1310     ENDIF
1320   ENDIF

1330 UNTIL EOF#file% OR LEN(text$) >= 255

1340 CLOSE #file%

1350 PRINT "Debug: Total bytes read = "; bytes%

1360 IF text$ = "" THEN
1370   PRINT "Error: No content read"
1380   = ""
1390 ENDIF

1400 IF LEN(text$) >= 255 THEN
1410   PRINT "Error: File content too long (>255 chars)"
1420   = ""
1430 ENDIF

1440 PRINT "Debug: File content loaded"
1450 = text$


2000 REM ============================
2010 REM EXTRACT <message>
2020 REM ============================
2030 DEF FNextractMessage$(text$)
2040 LOCAL start%, end%, msg$

2050 start% = INSTR(text$, "<message>")
2060 IF start% = 0 THEN = ""

2070 start% += LEN("<message>")

2080 end% = INSTR(text$, "</message>")
2090 IF end% = 0 THEN = ""

2100 msg$ = MID$(text$, start%, end% - start%)

2110 = msg$


3000 REM ============================
3010 REM DISPLAY OUTPUT
3020 REM ============================
3030 DEF PROCdisplayMessage(msg$)
3040 VDU 23,0,192,0
3050 PRINT "Message from XML: "; msg$
3060 ENDPROC
