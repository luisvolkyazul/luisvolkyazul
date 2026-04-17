1  CLS
5  PRINT "XML READING PROGRAM IN BBC BASIC V (DEBUG MODE)"

10 REM Main program
20 success% = FALSE
30 text$ = FNreadFileDebug$("message.xml")

40 IF text$ = "" THEN
50   PRINT "Error: File is empty or could not be read"
60 ELSE
70   message$ = FNextractMessage$(text$)
80   IF message$ = "" THEN
90     PRINT "Error: <message> tags not found or invalid"
100   ELSE
110     success% = TRUE
120   ENDIF
130 ENDIF

140 IF success% THEN PROCdisplayMessage(message$)

150 END


1000 REM ============================
1010 REM Function: Read file with byte-by-byte debug
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
1200       PRINT "Debug: Byte "; bytes%; " = "; CHR$(byte%); " (ASCII "; byte%; ")"
1210     ENDIF
1220   ENDIF
1230 UNTIL EOF#file% OR LEN(text$) >= 255

1240 CLOSE #file%

1250 PRINT "Debug: Bytes read = "; bytes%

1260 IF text$ = "" THEN
1270   PRINT "Debug: No content read"
1280   = ""
1290 ENDIF

1300 IF LEN(text$) >= 255 THEN
1310   PRINT "Error: File content too long (>255 chars)"
1320   = ""
1330 ENDIF

1340 PRINT "Debug: File content: "; text$

1350 = text$


2000 REM ============================
2010 REM Function: Extract <message>
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
3010 REM Procedure: Display result
3020 REM ============================
3030 DEF PROCdisplayMessage(msg$)
3040 VDU 23,0,192,0
3050 PRINT "Message from XML: "; msg$
3060 ENDPROC
