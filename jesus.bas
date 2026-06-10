   10 REM === Load Image ===
   20 MODE 20 : CLS
   30 bufferId% = 300
   40 w% = 512 : h% = 384
   50 REM 1. Clear/reset buffer
   60 VDU 23, 0, &A0, bufferId%; 2
   70 REM 2. Open file and load in chunks
   80 infile% = OPENIN "jesus.raw"
   90 IF infile% = 0 THEN PRINT "ERROR: raw image file not found!": END
  100 PRINT "Loading... ";
  110 blockSize% = 1024
  120 remaining% = w% * h%        : REM 196608 bytes total
  130 WHILE remaining% > 0
  140   IF remaining% < blockSize% THEN blockSize% = remaining%
  150   VDU 23, 0, &A0, bufferId%; 0, blockSize%;
  160   FOR i% = 1 TO blockSize%
  170     VDU BGET#infile%
  180   NEXT
  190   remaining% = remaining% - blockSize%
  200 ENDWHILE
  210 CLOSE#infile%
  220 PRINT "Done!"
  230 REM 3. Consolidate buffer blocks into one
  240 VDU 23, 0, &A0, bufferId%; 14
  250 REM 4. Select bitmap using 16-bit buffer ID
  260 VDU 23, 27, &20, bufferId%;
  270 REM 5. Create bitmap: format 1 = RGBA2222 (1 byte/pixel)
  280 VDU 23, 27, &21, w%; h%; 1
  290 REM 6. Select bitmap again (required before drawing)
  300 VDU 23, 27, &20, bufferId%;
  310 REM 7. Draw at pixel position (0,0) = top-left
  320 REM    VDU 23,27,3 uses pixel coords with top-left origin
  330 VDU 23, 27, 3, 0; 0;
  340 REM Press any key to end
  350 z% = GET
  360 END
