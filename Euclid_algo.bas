   10 PROC_INIT_SCREEN
   20 PRINT "First use of BARGO to build the..."
   30 PRINT '"euclid_algo.bas program."
   40 :
   45 REPEAT
   50   PROC_REQ_VALUES
   55   greatest_common_divisor = FN_EUCLID(m,n)
   60   PROC_DISPLAY_RESULTS
   65 UNTIL FALSE
   70 END
   80 :
   90 REM =====================================================
  100 REM IMPORT FILE_OUTPUT.BAS
  110 REM =====================================================
  120 :
  130 DEF PROC_DISPLAY_RESULTS
  140 PRINT'"The greatest common divisor of "'';original_m;" and ";original_n;" is: ";greatest_common_divisor
  150 PRINT
  160 PRINT"Number of Interchanges: ";count%-1;'
  170 :
  180 IF original_m = original_m/greatest_common_divisor * n + R% AND original_n = original_n/greatest_common_divisor * n + R% THEN PRINT'"Algorithm PROVEN with m=qn+r.";'
  190 ENDPROC
  200 :
  210 REM =====================================================
  220 REM IMPORT FILE_INPUT.BAS
  230 REM =====================================================
  240 :
  250 DEF PROC_INIT_SCREEN
  260 MODE 20
  270 COLOUR 132: COLOUR 15
  280 CLS
  290 ENDPROC
  310 DEF PROC_REQ_VALUES
  320 INPUT'"Enter a value for m";m
  330 original_m = m
  340 INPUT'"Enter a value for n";n
  350 original_n = n
  355 ENDPROC
  380 :
  390 REM =====================================================
  400 REM IMPORT FILE_PROCESSING.BAS
  410 REM =====================================================
  420 :
  430 DEF FN_EUCLID(m,n):
  440 REM Define euclid algorithm here...
  460 count% = 1
  470 :
  480 D% = m DIV n
  490 R% = m - (D%) * n
  500 count% = count% + 1
  510 :
  515 PRINT'"m is: ";m
  517 PRINT"n is: ";n
  518 PRINT"R is: ";R%
  519 PRINT"----------------"
  520 IF R% <> 0 THEN m=n
  530 IF R% <> 0 THEN n=R%
  540 IF R% <> 0 THEN GOTO 480
  570 =n
