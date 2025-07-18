    5 PRINT"XML READING PROGRAM IN BBC BASIC V"
   10 REM Hello World Program Reading from XML for Agon Platform
   20 REM Compatible with Agon Light, Light 2, and Console8 (MOS 3.0.1)
   30 REM Syntax per https://oldpatientsea.github.io/agon-bbc-basic-manual/0.1/bbc1.html
   40 :
   50 REM Initialize variables
   60 message$ = ""
   70 success% = 0
   80 start% = 0
   90 end% = 0
  100 text$ = ""
  110 bytes% = 0
  120 :
  130 REM Open the XML file for reading
  140 file% = OPENIN("message.xml")
  150 IF file% = 0 THEN PRINT "Error: Could not open message.xml": PRINT "Check file with CAT /mos": GOTO 360
  160 PRINT "Debug: File opened, handle = "; file%
  170 :
  180 REM Read file byte by byte and debug ASCII codes
  190 REPEAT
  200   byte% = BGET#file%
  210   IF NOT EOF#file% THEN IF LEN(text$) < 255 THEN text$ = text$ + CHR$(byte%): bytes% = bytes% + 1: PRINT "Debug: Byte "; bytes%; " = "; CHR$(byte%); " (ASCII "; byte%; ")"
  220 UNTIL EOF#file% OR LEN(text$) >= 255
  230 CLOSE #file%
  240 PRINT "Debug: Bytes read = "; bytes%
  250 :
  260 REM Check if file content was read
  270 IF text$ = "" THEN PRINT "Error: File is empty or could not be read": PRINT "Debug: No content read": GOTO 360
  280 IF LEN(text$) >= 255 THEN PRINT "Error: File content too long (>255 chars)": GOTO 360
  290 PRINT "Debug: File content: "; text$
  300 :
  310 REM Extract content between <message> and </message>
  320 start% = INSTR(text$, "<message>")
  330 IF start% = 0 THEN PRINT "Error: <message> tag not found": PRINT "Ensure tags are exactly <message> and </message>": GOTO 360
  340 start% = start% + LEN("<message>")
  350 end% = INSTR(text$, "</message>")
  360 IF end% = 0 THEN PRINT "Error: </message> tag not found": PRINT "Ensure tags are exactly <message> and </message>": GOTO 390
  370 message$ = MID$(text$, start%, end% - start%)
  380 success% = 1
  390 :
  400 REM Display the message on VGA output if successful
  410 IF success% THEN VDU 23,0,192,0 : REM Clear screen
  420 IF success% THEN PRINT "Message from XML: "; message$
  430 :
  440 END
