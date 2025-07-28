10 REM Agon Light 2 BBC BASIC Demo Program
20 REM Demonstrates commonly used BBC BASIC (Z80) keywords
30 REM Tested with Agon Platform firmware MOS 3.0.1, VDP 1.04, BBC BASIC 1.04
40 REM Uses graphics, sound, input, file I/O, and assembler

50 REM Trap Escape key for clean exit
60 ON ERROR IF ERR=17 THEN CLS : PRINT "Program terminated.": END ELSE PRINT "Error: ";REPORT$;" at line ";ERL: END

70 REM Initialize graphics and sound
80 MODE 0 : REM 320x200, 16 colors
90 VDU 23,0,192,0 : REM Disable cursor
100 VDU 23,1,0 : REM Disable text cursor
110 VDU 24,0;0;319;199; : REM Set full-screen graphics window
120 VDU 29,0;0; : REM Set graphics origin to bottom-left
130 VDU 28,0,3,39,0 : REM Set text window to bottom 4 rows
140 VDU 23,0,6,1 : REM Enable sound output
150 VDU 23,0,1,0,8,-15 : REM Set channel 0 volume
160 VDU 23,0,1,1,100 : REM Set channel 0 frequency
170 VDU 12 : REM Clear text window
180 GCOL 0,0 : CLG : REM Clear graphics with black background
190 VDU 23,0,26 : REM Reset graphics viewport
200 REM Test sound sequence at startup
210 FOR i% = 0 TO 2
220   SOUND i%,-15,100,20 : REM Test channels 0-2, pitch 100
230   WAIT 60
240 NEXT i%
250 VDU 31,0,3 : PRINT "Sound test played (channels 0-2, pitch 100). Check audio."

260 REM Define variables and arrays
270 DIM points(10,2) : REM Array to store up to 10 points (x,y)
280 x% = 160 : y% = 100 : REM Starting coordinates (center in MODE 0)
290 old_x% = 160 : old_y% = 100 : REM Track previous position
300 col% = 1 : REM Initial color (1 = red)
310 radius% = 20 : REM Smaller radius
320 sound_on% = 1 : REM Sound toggle
330 point_index% = 0 : REM Initialize point_index%
340 moved% = 0 : REM Flag for movement

350 REM Main program loop
360 VDU 31,0,0 : PRINT "Agon Light 2 BBC BASIC Demo"
370 VDU 31,0,1 : PRINT "Arrows/WASD: move, C: change color, S: toggle sound, F: save, L: load, Q/Esc: quit"
380 REPEAT
390   PROC_getInput
400   IF moved% THEN PROC_drawShapes
410   IF sound_on% AND moved% THEN PROC_playSound
420   PROC_updateStatus
430   WAIT 2 : REM Slightly longer delay to reduce flicker
440 UNTIL FALSE

450 REM Procedure to handle user input
460 DEF PROC_getInput
470   moved% = 0 : REM Reset movement flag
480   key% = INKEY(1) : REM Get keypress with short timeout
490   key$ = CHR$(key% AND 255) : REM Convert to string
500   IF key% <> -1 THEN VDU 31,0,2 : PRINT "Key code: ";key%;" Char: ";key$
510   REM Arrow keys (136-139 or 28-31) and WASD
520   IF key% = 136 OR key% = 28 OR key$ = "D" OR key$ = "d" THEN x% = x% + 10 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
530   IF key% = 137 OR key% = 29 OR key$ = "A" OR key$ = "a" THEN x% = x% - 10 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
540   IF key% = 138 OR key% = 30 OR key$ = "W" OR key$ = "w" THEN y% = y% + 10 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
550   IF key% = 139 OR key% = 31 OR key$ = "S" OR key$ = "s" THEN y% = y% - 10 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
560   IF key$ = "C" OR key$ = "c" THEN col% = (col% + 1) MOD 16
570   IF key$ = "S" OR key$ = "s" THEN sound_on% = NOT sound_on% : VDU 23,0,7 : SOUND 0,-15,100,20 : VDU 31,0,3 : PRINT "Sound ";:IF sound_on% THEN PRINT "ON" ELSE PRINT "OFF"
580   IF key$ = "F" OR key$ = "f" THEN PROC_savePattern
590   IF key$ = "L" OR key$ = "l" THEN PROC_loadPattern
600   IF key$ = "Q" OR key$ = "q" OR key% = 27 THEN CLS : PRINT "Exiting...": END
610   REM Keep coordinates within screen bounds
620   IF x% < 0 THEN x% = 0 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
630   IF x% > 319 THEN x% = 319 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
640   IF y% < 0 THEN y% = 0 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
650   IF y% > 199 THEN y% = 199 : moved% = 1 : VDU 31,0,3 : PRINT "Moved to X:";x%;" Y:";y%
660 ENDPROC

670 REM Procedure to update status display
680 DEF PROC_updateStatus
690   VDU 31,0,0 : PRINT "Agon Light 2 BBC BASIC Demo"
700   VDU 31,0,1 : PRINT "Arrows/WASD: move, C: change color, S: toggle sound, F: save, L: load, Q/Esc: quit"
710   VDU 31,0,2 : PRINT "Key code: ";key%;" Char: ";key$
720   VDU 31,0,3 : PRINT "X:";x%;" Y:";y%;" Col:";col%;" Sound:";sound_on%
730 ENDPROC

740 REM Procedure to draw shapes
750 DEF PROC_drawShapes
760   VDU 23,0,26 : REM Reset graphics viewport
770   GCOL 0,col% : REM Set graphics color
780   PLOT 69,x%,y% : REM Plot a point
790   MOVE x%,y% : REM Move to starting position
800   DRAW x%+radius%,y% : REM Draw line
810   CIRCLE x%,y%,radius% : REM Draw circle
820   REM Store point in array
830   points(point_index%,0) = x%
840   points(point_index%,1) = y%
850   point_index% = (point_index% + 1) MOD 10
860   REM Redraw all stored points
870   FOR i% = 0 TO 9
880     IF points(i%,0) <> 0 OR points(i%,1) <> 0 THEN
890       GCOL 0,col% : CIRCLE points(i%,0),points(i%,1),radius%
900     ENDIF
910   NEXT i%
920 ENDPROC

930 REM Procedure to play a sound
940 DEF PROC_playSound
950   VDU 23,0,1,0,8,-15 : REM Reinitialize channel 0 volume
960   VDU 23,0,1,1,100 : REM Reinitialize channel 0 frequency
970   VDU 23,0,7 : REM Flush sound queue
980   SOUND 0,-15,100,20 : REM Play on channel 0, pitch 100
990   VDU 23,0,7 : REM Flush queue again
1000  VDU 31,0,3 : PRINT "Sound played for movement"
1010  WAIT 60 : REM Longer delay
1020 ENDPROC

1030 REM Function to calculate pitch based on position
1040 DEF FN_calcPitch
1050   LOCAL pitch%
1060   pitch% = (x% + y%) MOD 128
1070   IF pitch% < 10 THEN pitch% = 100
1080   = pitch%

1090 REM Procedure to save pattern to SD card
1100 DEF PROC_savePattern
1110   handle% = OPENOUT("pattern.dat")
1120   FOR i% = 0 TO 9
1130     PRINT#handle%,points(i%,0),points(i%,1)
1140   NEXT i%
1150   CLOSE#handle%
1160   VDU 31,0,3 : PRINT "Pattern saved to pattern.dat"
1170 ENDPROC

1180 REM Procedure to load pattern from SD card
1190 DEF PROC_loadPattern
1200   handle% = OPENIN("pattern.dat")
1210   IF handle% = 0 THEN VDU 31,0,3 : PRINT "File not found!": ENDPROC
1220   REM Reset points array
1230   FOR i% = 0 TO 9
1240     points(i%,0) = 0 : points(i%,1) = 0
1250   NEXT i%
1260   FOR i% = 0 TO 9
1270     INPUT#handle%,points(i%,0),points(i%,1)
1280     REM Validate coordinates for MODE 0
1290     IF points(i%,0) < 0 THEN points(i%,0) = 0
1300     IF points(i%,0) > 319 THEN points(i%,0) = 319
1310     IF points(i%,1) < 0 THEN points(i%,1) = 0
1320     IF points(i%,1) > 199 THEN points(i%,1) = 199
1330   NEXT i%
1340   CLOSE#handle%
1350   REM Update current position with first valid point
1360   x% = points(0,0) : y% = points(0,1)
1370   IF x% = 0 AND y% = 0 THEN x% = 160 : y% = 100
1380   old_x% = x% : old_y% = y%
1390   VDU 31,0,3 : PRINT "Pattern loaded to X:";x%;" Y:";y%
1400   GCOL 0,0 : CLG : PROC_drawShapes
1410 ENDPROC

1420 REM Simple Z80 assembler to flash a pixel
1430 DEF PROC_flashPixel
1440   DIM code 20 : REM Reserve 20 bytes for machine code
1450   P% = code
1460   [
1470   LD A,(IX+0) : REM Load x coordinate
1480   LD B,A
1490   LD A,(IX+2) : REM Load y coordinate
1500   LD C,A
1510   OUT (5),A : REM Output to a port (simplified example)
1520   RET
1530   ]
1540   CALL code : REM Call the assembled code
1550 ENDPROC
