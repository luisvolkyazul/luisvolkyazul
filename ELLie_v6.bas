   10 REM ELLIE'S TREAT HUNT
   20 REM Agon Light 2 / BBC BASIC V
   30 REM Mode 8 - 1280x1024 logical
   40 REM WASD or Arrow keys to move
   45 REM *FX 4,1 enables cursor key codes (136-139) in INKEY$
   50 REM Q = quit, find all 5 bones!
   60 REM ============================
   70 REM --- CONSTANTS ---
   80 TW%=64 : TH%=64
   90 COLS%=18 : ROWS%=13
  100 OX%=32 : OY%=32
  105 SCRH%=1024
  110 REM ============================
  120 REM --- MAP DATA ---
  130 REM 0=floor 1=wall 2=sofa
  140 REM 3=table 4=door 5=rug
  150 REM ============================
  160 DIM MP%(ROWS%-1, COLS%-1)
  170 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  180 DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1
  190 DATA 1,0,2,2,0,0,0,0,4,0,0,0,0,0,3,3,0,1
  200 DATA 1,0,2,2,0,0,0,0,1,0,0,0,0,0,3,3,0,1
  210 DATA 1,0,0,0,5,5,5,0,1,0,0,5,5,0,0,0,0,1
  220 DATA 1,1,1,1,1,4,1,1,1,1,1,1,4,1,1,1,1,1
  230 DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1
  240 DATA 1,0,3,0,0,0,2,2,1,0,0,0,0,0,2,2,0,1
  250 DATA 1,0,3,0,5,5,0,0,1,0,5,5,0,0,0,0,0,1
  260 DATA 1,0,0,0,5,5,0,0,4,0,5,5,0,0,0,0,0,1
  270 DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1
  280 DATA 1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1
  290 DATA 1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
  300 FOR r%=0 TO ROWS%-1
  310   FOR c%=0 TO COLS%-1
  320     READ MP%(r%,c%)
  330   NEXT c%
  340 NEXT r%
  350 REM ============================
  360 REM --- TREAT POSITIONS ---
  370 REM ============================
  380 NUMTR%=5
  390 DIM TRC%(4), TRR%(4), TRF%(4)
  400 TRC%(0)=6  : TRR%(0)=1
  410 TRC%(1)=16 : TRR%(1)=3
  420 TRC%(2)=11 : TRR%(2)=4
  430 TRC%(3)=3  : TRR%(3)=8
  440 TRC%(4)=10 : TRR%(4)=9
  450 FOR t%=0 TO 4 : TRF%(t%)=0 : NEXT t%
  460 FOUND%=0
  470 REM ============================
  480 REM --- DOG START ---
  490 REM ============================
  500 DC%=8 : DR%=7
  510 DDIR%=1
  520 WAGST%=0 : WAGT%=0
  530 REM Arrow keys via VDU 23,0,&86 (vdp_getKeyMap)
  545 REM *FX 4,1
  550 REM --- TITLE SCREEN ---
  560 MODE 8
  570 VDU 23,1,0;0;0;0;
  580 GCOL 0,2 : CLG
  582 REM Load bitmap sprite 0 (numeric VDU args, no strings)
  583 RESTORE 5930
  584 VDU 23,0,&A0,64000;2
  585 FOR p%=1 TO 256
  586   READ r%,g%,b%,a%
  587   VDU 23,0,&A0,64000;0,4; r%,g%,b%,a%
  588 NEXT p%
  589 VDU 23,0,&A0,64000;14
  590 VDU 23,27,0,0
  591 VDU 23,27,&21,16;16;0
  592 COLOUR 11
  600 PRINT TAB(7,3)"========================="
  610 PRINT TAB(8,4)"  ELLIE'S TREAT HUNT"
  620 PRINT TAB(7,5)"========================="
  630 COLOUR 7
  640 PRINT TAB(5,8)"Help Ellie find all 5 bones"
  650 PRINT TAB(5,9)"hidden around her house!"
  660 COLOUR 11
  670 PRINT TAB(5,12)"WASD keys = move"
  680 PRINT TAB(5,13)"Q = quit"
  690 COLOUR 14
  700 PRINT TAB(8,17)"Press any key..."
  710 sx%=640 : sy%=500 : DDIR%=1 : WAGST%=0
  720 GOSUB 5000
  730 q$=GET$
  740 REM ============================
  750 REM --- DRAW INITIAL SCREEN ---
  760 REM ============================
  770 GCOL 0,2 : CLG
  780 GOSUB 2000
  790 GOSUB 4000
  800 sx%=OX%+DC%*TW%+TW%/2
  810 sy%=SCRH%-OY%-DR%*TH%-TH%/2
  820 GOSUB 5000
  830 REM ============================
  840 REM --- MAIN GAME LOOP ---
  850 REM ============================
  860 k$=INKEY$(0)
  870 nc%=DC% : nr%=DR% : mv%=0
  880 REM WASD
  890 IF k$="w" OR k$="W" THEN nr%=DR%-1 : DDIR%=0 : mv%=1
  900 IF k$="s" OR k$="S" THEN nr%=DR%+1 : DDIR%=2 : mv%=1
  910 IF k$="a" OR k$="A" THEN nc%=DC%-1 : DDIR%=3 : mv%=1
  920 IF k$="d" OR k$="D" THEN nc%=DC%+1 : DDIR%=1 : mv%=1
  930 REM Arrow keys via sysvar_vkeycode and sysvar_vkeydown
  931 A%=&A0:L%=&010B:CALL &FFF4:REM read vkeycode
  932 vk%=A%
  933 A%=&A0:L%=&010C:CALL &FFF4:REM read vkeydown
  934 vd%=A%
  935 IF vk%=171 AND vd%=1 THEN nr%=DR%-1:DDIR%=0:mv%=1
  936 IF vk%=173 AND vd%=1 THEN nr%=DR%+1:DDIR%=2:mv%=1
  937 IF vk%=170 AND vd%=1 THEN nc%=DC%-1:DDIR%=3:mv%=1
  938 IF vk%=172 AND vd%=1 THEN nc%=DC%+1:DDIR%=1:mv%=1
  939 REM Fallback: *FX 4,1 cursor key codes
  940 IF k$=CHR$(139) THEN nr%=DR%-1:DDIR%=0:mv%=1
  941 IF k$=CHR$(138) THEN nr%=DR%+1:DDIR%=2:mv%=1
  942 IF k$=CHR$(136) THEN nc%=DC%-1:DDIR%=3:mv%=1
  943 IF k$=CHR$(137) THEN nc%=DC%+1:DDIR%=1:mv%=1
  980 REM --- Collision check ---
  990 IF mv%=0 THEN GOTO 1100
 1000 IF nr%<0 THEN GOTO 1100
 1010 IF nr%>=ROWS% THEN GOTO 1100
 1020 IF nc%<0 THEN GOTO 1100
 1030 IF nc%>=COLS% THEN GOTO 1100
 1040 tl%=MP%(nr%,nc%)
 1050 IF tl%=1 THEN GOTO 1100
 1060 IF tl%=2 THEN GOTO 1100
 1070 IF tl%=3 THEN GOTO 1100
 1080 GOSUB 3100
 1090 DC%=nc% : DR%=nr%
 1100 REM --- Wag timer ---
 1110 WAGT%=WAGT%+1
 1120 IF WAGT%>=6 THEN WAGT%=0 : WAGST%=1-WAGST%
 1130 REM --- Treat check ---
 1140 FOR t%=0 TO 4
 1150   IF TRF%(t%)=0 THEN
 1160     IF DC%=TRC%(t%) AND DR%=TRR%(t%) THEN
 1170       TRF%(t%)=1 : FOUND%=FOUND%+1
 1180       GOSUB 4500 : GOSUB 4000
 1190     ENDIF
 1200   ENDIF
 1210 NEXT t%
 1220 REM --- Draw dog ---
 1230 sx%=OX%+DC%*TW%+TW%/2
 1240 sy%=SCRH%-OY%-DR%*TH%-TH%/2
 1250 GOSUB 5000
 1260 REM --- Win / Quit ---
 1270 IF FOUND%=NUMTR% THEN GOSUB 5500 : END
 1280 IF k$="q" OR k$="Q" THEN GOSUB 5800 : END
 1290 REM --- Loop delay ---
 1300 TIME=0 : REPEAT UNTIL TIME>2
 1310 GOTO 860
 1320 REM ============================
 1330 REM ==== SUBROUTINES ====
 1340 REM ============================
 1350 REM
 1360 REM ============================
 1370 REM 2000: DRAW FULL MAP
 1380 REM ============================
 2000 FOR r%=0 TO ROWS%-1
 2010   FOR c%=0 TO COLS%-1
 2020     tc%=c% : tr%=r% : GOSUB 2500
 2030   NEXT c%
 2040 NEXT r%
 2050 FOR t%=0 TO 4
 2060   IF TRF%(t%)=0 THEN
 2070     tx%=OX%+TRC%(t%)*TW% : ty%=SCRH%-OY%-TRR%(t%)*TH%-TH%
 2080     GOSUB 2900
 2090   ENDIF
 2100 NEXT t%
 2110 RETURN
 2120 REM
 2130 REM ============================
 2140 REM 2500: DRAW ONE TILE
 2150 REM tc%=col, tr%=row
 2160 REM ============================
 2500 px%=OX%+tc%*TW%
 2510 py%=SCRH%-OY%-tr%*TH%-TH%
 2520 tl%=MP%(tr%,tc%)
 2530 REM --- Floor ---
 2540 IF tl%<>0 THEN GOTO 2570
 2550 GCOL 0,29 : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2560 RETURN
 2570 REM --- Wall ---
 2580 IF tl%<>1 THEN GOTO 2620
 2590 GCOL 0,4  : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2600 GCOL 0,12 : PLOT &64,px%,py%+TH%-4 : PLOT &65,px%+TW%,py%+TH%
 2610 RETURN
 2620 REM --- Sofa ---
 2630 IF tl%<>2 THEN GOTO 2670
 2640 GCOL 0,11 : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2650 GCOL 0,5  : PLOT &64,px%+2,py%+2 : PLOT &65,px%+TW%-2,py%+TH%-4
 2660 GCOL 0,13 : PLOT &64,px%+8,py%+10 : PLOT &65,px%+TW%-8,py%+TH%-14
 2665 RETURN
 2670 REM --- Table ---
 2680 IF tl%<>3 THEN GOTO 2730
 2690 GCOL 0,11 : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2700 GCOL 0,9  : PLOT &64,px%+2,py%+TH%-10 : PLOT &65,px%+TW%-2,py%+TH%
 2710 GCOL 0,1  : PLOT &64,px%+4,py% : PLOT &65,px%+10,py%+TH%-10
 2720 GCOL 0,1  : PLOT &64,px%+TW%-10,py% : PLOT &65,px%+TW%-4,py%+TH%-10
 2725 RETURN
 2730 REM --- Door ---
 2740 IF tl%<>4 THEN GOTO 2780
 2750 GCOL 0,11 : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2760 GCOL 0,9  : PLOT &64,px%+4,py%+4 : PLOT &65,px%+TW%-4,py%+TH%-4
 2770 GCOL 0,3  : PLOT &9C,px%+TW%-14,py%+TH%/2 : PLOT &9D,px%+TW%-10,py%+TH%/2
 2775 RETURN
 2780 REM --- Rug ---
 2790 GCOL 0,11 : PLOT &64,px%,py% : PLOT &65,px%+TW%,py%+TH%
 2800 GCOL 0,1  : PLOT &64,px%+2,py%+2 : PLOT &65,px%+TW%-2,py%+TH%-2
 2810 GCOL 0,9  : PLOT &64,px%+6,py%+6 : PLOT &65,px%+TW%-6,py%+TH%-6
 2820 GCOL 0,1  : PLOT &64,px%+10,py%+10 : PLOT &65,px%+TW%-10,py%+TH%-10
 2830 RETURN
 2840 REM
 2850 REM ============================
 2860 REM 2900: DRAW BONE TREAT
 2870 REM tx%,ty% = tile top-left pixel
 2880 REM ============================
 2900 bx%=tx%+TW%/2 : by%=ty%+TH%/2
 2910 GCOL 0,15
 2920 PLOT &64,bx%-16,by%-5 : PLOT &65,bx%+16,by%+5
 2930 PLOT &9C,bx%-14,by% : PLOT &9D,bx%-6,by%
 2940 PLOT &9C,bx%-14,by% : PLOT &9D,bx%-14,by%+8
 2950 PLOT &9C,bx%+14,by% : PLOT &9D,bx%+22,by%
 2960 PLOT &9C,bx%+14,by% : PLOT &9D,bx%+14,by%+8
 2970 GCOL 0,7
 2980 PLOT &04,bx%-14,by%-5 : PLOT &05,bx%+14,by%-5
 2990 PLOT &04,bx%+14,by%+5 : PLOT &05,bx%-14,by%+5
 3000 RETURN
 3010 REM
 3020 REM ============================
 3030 REM 3100: ERASE DOG (redraw tile)
 3040 REM Uses DC%,DR% (current pos)
 3050 REM ============================
 3100 tc%=DC% : tr%=DR% : GOSUB 2500
 3105 REM Redraw tile below to cover 1px bitmap overflow
 3110 tc%=DC% : tr%=DR%+1
 3115 IF tr% < ROWS% THEN GOSUB 2500
 3120 FOR t%=0 TO 4
 3125   IF TRF%(t%)=0 THEN
 3130     IF TRC%(t%)=DC% AND TRR%(t%)=DR% THEN
 3135       tx%=OX%+DC%*TW% : ty%=SCRH%-OY%-DR%*TH%-TH%
 3140       GOSUB 2900
 3145     ENDIF
 3150     IF TRC%(t%)=DC% AND TRR%(t%)=DR%+1 THEN
 3155       tx%=OX%+DC%*TW% : ty%=SCRH%-OY%-(DR%+1)*TH%-TH%
 3160       GOSUB 2900
 3165     ENDIF
 3170   ENDIF
 3175 NEXT t%
 3180 RETURN
 3200 REM
 3210 REM ============================
 3220 REM 4000: HUD BAR
 3230 REM ============================
 4000 GCOL 0,0 : PLOT &64,0,SCRH%-28 : PLOT &65,1280,SCRH%
 4010 GCOL 0,8 : PLOT &64,0,SCRH%-26 : PLOT &65,1278,SCRH%-2
 4020 COLOUR 11
 4030 PRINT TAB(0,0)"ELLIE'S TREAT HUNT  Bones:";FOUND%;"/";NUMTR%;"  WASD=Move  Q=Quit"
 4040 RETURN
 4050 REM
 4060 REM ============================
 4070 REM 4500: BONE FOUND MESSAGE
 4080 REM ============================
 4500 COLOUR 11
 4510 PRINT TAB(2,24)"*** Woof! Bone ";FOUND%;" found! ***"
 4520 SOUND 1,-15,100,5
 4530 SOUND 1,-10,120,8
 4540 TIME=0 : REPEAT UNTIL TIME>120
 4550 REM Clear message by redrawing tiles
 4560 FOR tc%=0 TO COLS%-1:tr%=7:GOSUB 2500:NEXT tc%
 4565 FOR t%=0 TO 4
 4566   IF TRF%(t%)=0 AND TRR%(t%)=7 THEN tx%=OX%+TRC%(t%)*TW%:ty%=SCRH%-OY%-7*TH%-TH%:GOSUB 2900
 4567 NEXT t%
 4570 RETURN
 4580 REM
 4590 REM ============================
 4600 REM 5000: DRAW DOG (Ellie v3 - bitmap sprite)
 4610 REM Uses VDP Bitmap 0 (16x16)
 4620 REM sx%,sy% = tile centre (PLC logical 1280x1024)
 4630 REM VDU23,27,3 uses physical pixel coords (320x240 in MODE8)
 4640 REM pixel_x = sx%/4 - 8, pixel_y = (1024-sy%)*240/1024 - 8
 4650 REM ============================
 5000 VDU 23,27,0,0 : REM select bitmap 0
 5010 VDU 23,27,3,sx% DIV 4 - 8;(SCRH%-sy%)*240 DIV 1024 - 8;
 5020 RETURN
 5030 REM
 5040 REM ============================
 5050 REM 5500: WIN SCREEN
 5060 REM ============================
 5500 GCOL 0,2 : CLG
 5510 COLOUR 11
 5520 PRINT TAB(7,3) "=========================="
 5530 PRINT TAB(8,4) "  *** ELLIE WINS! ***"
 5540 PRINT TAB(7,5) "=========================="
 5550 COLOUR 7
 5560 PRINT TAB(6,8) "All 5 bones found!"
 5570 PRINT TAB(6,9) "What a good girl!"
 5580 COLOUR 14
 5590 PRINT TAB(6,13)"Press any key to exit."
 5600 FOR i%=1 TO 3
 5610   SOUND 1,-12,80+i%*20,8
 5620   TIME=0 : REPEAT UNTIL TIME>10
 5630 NEXT i%
 5640 sx%=640 : sy%=500 : DDIR%=1 : WAGST%=1
 5650 GOSUB 5000
 5660 q$=GET$
 5670 RETURN
 5680 REM
 5690 REM ============================
 5700 REM 5800: QUIT SCREEN
 5710 REM ============================
 5800 GCOL 0,2 : CLG
 5810 COLOUR 7
 5820 PRINT TAB(6,5)"Thanks for playing!"
 5830 PRINT TAB(4,7)"Ellie will find them..."
 5840 PRINT TAB(6,8)"...next time! :)"
 5850 TIME=0 : REPEAT UNTIL TIME>150
 5860 RETURN
 5870 REM === End of ELLIE.BAS ===
 5880 REM
 5890 REM ============================
 5900 REM Sprite bitmap DATA (RGBA8888)
 5910 REM 16x16 pixels, row-major
 5920 REM ============================
 5930 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 5940 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0
 5950 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0
 5960 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0
 5970 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
 5980 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,140,0,255,255,255,255,255,0,0,0,0
 5990 DATA 0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,30,30,30,255
 6000 DATA 0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,180,130,80,255,180,130,80,255,180,130,80,255,180,130,80,255,255,255,255,255,255,255,255,255,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255,255
 6010 DATA 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,180,130,80,255,180,130,80,255,180,130,80,255,180,130,80,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0
 6020 DATA 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,255,255,255,255,180,130,80,255,180,130,80,255,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0
 6030 DATA 0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 6040 DATA 0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 6050 DATA 0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,255,255,255,255,255,255,255,255,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 6060 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 6070 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
 6080 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
