10 REM ============================================================
20 REM AGON LIGHT 2 GRAPHICS DEMO
30 REM A showcase of VDP graphics capabilities
40 REM ============================================================
50 :
60 MODE 0
70 PRINT "AGON LIGHT 2 GRAPHICS DEMO"
80 PRINT "==========================="
90 PRINT ""
100 PRINT "Press 1-5 for demos:"
110 PRINT "  1 - Shapes & Colors"
120 PRINT "  2 - Animated Ball"
130 PRINT "  3 - Color Cycling"
140 PRINT "  4 - Line Art"
150 PRINT "  5 - Interactive Drawing"
160 PRINT ""
170 PRINT "Press SPACE to exit"
180 PRINT ""
190 PRINT "Choice? ";
200 REPEAT
210   K% = INKEY(0)
220 UNTIL K%>=49 AND K%<=53 OR K%=32
230 IF K%=32 THEN END
240 CLS
250 IF K%=49 THEN GOSUB 1000
260 IF K%=50 THEN GOSUB 2000
270 IF K%=51 THEN GOSUB 3000
280 IF K%=52 THEN GOSUB 4000
290 IF K%=53 THEN GOSUB 5000
300 GOTO 60
310 :
320 REM ============================================================
330 REM DEMO 1: SHAPES AND COLORS
340 REM ============================================================
1000 PRINT "DEMO 1: SHAPES & COLORS"
1010 PRINT "======================="
1020 PRINT ""
1025 MODE 0
1030 PRINT "Drawing shapes..."
1040 :
1050 REM Draw filled rectangles - colors 0-7
1060 FOR I%=0 TO 7
1070   GCOL 0,I%
1080   MOVE I%*160+20, 50
1090   PLOT 101, I%*160+150, 150
1100 NEXT
1110 :
1120 REM Draw circles - colors 0-7
1130 FOR I%=0 TO 7
1140   GCOL 0,I%+1
1150   MOVE 640, 350
1160   PLOT 149, 640, 350+40+I%*10
1170 NEXT
1180 :
1190 REM Draw triangles - colors 0-7
1200 FOR I%=0 TO 5
1210   GCOL 0,I%+2
1220   MOVE 200+I%*160, 500
1230   MOVE 260+I%*160, 650
1240   PLOT 85, 320+I%*160, 500
1250 NEXT
1260 :
1270 PRINT ""
1280 PRINT "Demo 1 complete!"
1290 PRINT "Press SPACE to continue..."
1300 REPEAT UNTIL INKEY(0)=32
1310 RETURN
1320 :
1330 REM ============================================================
1340 REM DEMO 2: ANIMATED BALL
1350 REM ============================================================
2000 PRINT "DEMO 2: ANIMATED BALL"
2010 PRINT "====================="
2020 PRINT ""
2025 MODE 0
2030 PRINT "Watch the bouncing ball..."
2035 *FX19:*FX19:*FX19:*FX19
2040 :
2045 X% = 100
2050 Y% = 100
2055 DX% = 3
2060 DY% = 2
2065 R% = 15
2070 :
2075 EXIT% = 0
2080 REPEAT
2085   REM Erase old position
2090   GCOL 0,0
2095   MOVE X%, Y%
2100   PLOT 149, X%+R%, Y%+R%
2105   :
2110   REM Update position
2115   X% = X% + DX%
2120   Y% = Y% + DY%
2125   :
2130   REM Bounce off edges (MODE 0 = 640x400)
2135   IF X%<=0 THEN DX% = -DX%: X% = 0
2140   IF X%>=640-R%*2 THEN DX% = -DX%: X% = 640-R%*2
2145   IF Y%<=0 THEN DY% = -DY%: Y% = 0
2150   IF Y%>=400-R%*2 THEN DY% = -DY%: Y% = 400-R%*2
2155   :
2160   REM Draw new ball
2165   GCOL 0,1
2170   MOVE X%, Y%
2175   PLOT 149, X%+R%, Y%+R%
2180   :
2185   *FX19
2190   :
2195   IF INKEY(1)<>-1 THEN EXIT% = 1
2200 UNTIL EXIT% = 1
2205 :
2210 PRINT ""
2215 PRINT "Press any key..."
2220 REPEAT UNTIL INKEY(0)<>-1
2225 RETURN
2330 :
2340 REM ============================================================
2350 REM DEMO 3: COLOR CYCLING
2360 REM ============================================================
3000 PRINT "DEMO 3: COLOR CYCLING"
3010 PRINT "====================="
3020 PRINT ""
3030 MODE 0
3040 PRINT "Stacking boxes from bottom to top..."
3050 :
3055 REM Stack 8 columns of boxes, each column 7 boxes high
3060 REM Boxes get smaller as they go UP (Y=0 is top)
3065 FOR ROW%=0 TO 6
3070   FOR COL%=0 TO 7
3075     GCOL 0,(COL%+ROW%) MOD 8
3080     X% = COL%*80 + 10
3085     Y% = 350 - ROW%*40
3090     W% = 70 - (6-ROW%)*5
3095     H% = 30 - (6-ROW%)*2
3100     MOVE X%, Y%
3105     PLOT 101, X%+W%, Y%-H%
3110     *FX19:*FX19
3115   NEXT COL%
3120 NEXT ROW%
3125 :
3130 PRINT ""
3135 PRINT "Demo 3 complete!"
3140 PRINT "Press SPACE to continue..."
3145 REPEAT UNTIL INKEY(0)=32
3150 RETURN
3330 :
3340 REM ============================================================
3350 REM DEMO 4: LINE ART
3360 REM ============================================================
4000 PRINT "DEMO 4: LINE ART"
4010 PRINT "================"
4020 PRINT ""
4030 MODE 0
4040 PRINT "Drawing geometric patterns..."
4050 :
4060 CX% = 640
4070 CY% = 400
4080 :
4090 REM Spirograph pattern
4100 FOR I%=0 TO 360 STEP 2
4110   ANGLE = I% * PI / 180
4120   R1 = 200
4130   R2 = 80
4140   X1 = CX% + R1 * COS(ANGLE)
4150   Y1 = CY% + R1 * SIN(ANGLE)
4160   X2 = X1 + R2 * COS(ANGLE * 6)
4170   Y2 = Y1 + R2 * SIN(ANGLE * 6)
4180   GCOL 0,(I%/60) MOD 8
4190   PLOT 0, X2, Y2
4200 NEXT
4210 :
4220 REM Concentric circles
4230 FOR R%=20 TO 200 STEP 25
4240   GCOL 0,((R%/25)+1) MOD 8
4250   MOVE CX%, CY%
4260   PLOT 145, CX%, CY%+R%
4270 NEXT
4280 :
4290 REM Star pattern
4300 FOR ARM%=0 TO 5
4310   ANGLE = ARM% * 60 * PI / 180
4320   X2 = CX% + 250 * COS(ANGLE)
4330   Y2 = CY% + 250 * SIN(ANGLE)
4340   GCOL 0,ARM%+1
4350   MOVE CX%, CY%
4360   PLOT 5, X2, Y2
4370 NEXT
4380 :
4390 PRINT ""
4400 PRINT "Demo 4 complete!"
4410 PRINT "Press SPACE to continue..."
4420 REPEAT UNTIL INKEY(0)=32
4430 RETURN
4500 :
4510 REM ============================================================
4520 REM DEMO 5: INTERACTIVE DRAWING
4530 REM ============================================================
5000 MODE 0
5005 PRINT "DEMO 5: INTERACTIVE DRAWING"
5010 PRINT "============================"
5015 PRINT ""
5020 PRINT "Controls:"
5021 PRINT "  I/J/K/M = move"
5022 PRINT "  SPACE = draw"
5023 PRINT "  1-7 = change color"
5024 PRINT "  C = clear"
5025 PRINT "  Q = quit"
5026 PRINT ""
5027 PRINT "Colors: 1=Black 2=Red 3=Green 4=Yellow"
5028 PRINT "        5=Blue 6=Magenta 7=Cyan 8=White"
5028 :
5030 X% = 320
5040 Y% = 200
5050 COL% = 1
5060 QUIT% = 0
5070 :
5080 REPEAT
5090   K% = GET
5100   IF K% = 81 THEN QUIT% = 1
5110   IF K% = 67 OR K% = 99 THEN CLS
5120   IF K% = 74 THEN X% = X% - 10
5130   IF K% = 75 THEN X% = X% + 10
5140   IF K% = 73 THEN Y% = Y% - 10
5150   IF K% = 77 THEN Y% = Y% + 10
5160   IF X% < 0 THEN X% = 0
5170   IF X% > 639 THEN X% = 639
5180   IF Y% < 0 THEN Y% = 0
5190   IF Y% > 399 THEN Y% = 399
5200   IF K% = 32 THEN GCOL 0,COL%: MOVE X%,Y%: PLOT 5,X%+5,Y%+5
5210   IF K% = 49 THEN COL% = 0
5220   IF K% = 50 THEN COL% = 1
5230   IF K% = 51 THEN COL% = 2
5240   IF K% = 52 THEN COL% = 3
5250   IF K% = 53 THEN COL% = 4
5260   IF K% = 54 THEN COL% = 5
5270   IF K% = 55 THEN COL% = 6
5280   IF K% = 56 THEN COL% = 7
5290 UNTIL QUIT% = 1
5300 :
5310 CLS
5320 PRINT "": PRINT "Returning to menu...": RETURN
