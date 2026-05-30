   10 REM MORPH_7_by_claudeai.BAS - Agon Light 2 shape morphing demo
   20 REM Mode 20: 512x384, 64 colours
   30 REM Logical coords: 1280x1024, origin bottom-left
   40 REM Requires Console8 VDP 2.6.0+
   50 :
   60 REM ================================
   70 REM  CONSTANTS
   80 REM  NS = max stars on screen
   90 REM  CX,CY = screen centre
  100 REM ================================
  110 NS%=40
  120 :
  130 REM ================================
  140 REM  STAR ARRAYS
  150 REM  SX,SY = star logical coords
  160 REM  SV    = star colour (0=dark)
  170 REM ================================
  180 DIM SX%(NS%)
  190 DIM SY%(NS%)
  200 DIM SV%(NS%)
  210 :
  220 REM ================================
  230 REM  SETUP
  240 REM ================================
  250 MODE 20
  260 VDU 23,1,0
  270 CX%=640 : CY%=512
  280 WW%=RND(-TIME)
  290 :
  300 REM Pre-scatter star positions
  310 FOR ZI%=1 TO NS%
  320   SX%(ZI%)=RND(1200)+40
  330   SY%(ZI%)=RND(980)+20
  340   SV%(ZI%)=0
  350 NEXT ZI%
  360 :
  370 REM ================================
  380 REM  MAIN LOOP
  390 REM ================================
  400 CL%=RND(63)
  410 CLG
  420 GCOL 0,CL%
  430 PLOT &45,CX%,CY%
  440 WAIT 200
  450 :
  460 GOSUB 1000 : REM line
  470 GOSUB 2000 : REM triangle
  480 GOSUB 3000 : REM square
  490 GOSUB 4000 : REM ellipse or circle
  500 GOSUB 5000 : REM diamond
  510 GOSUB 6000 : REM star shape
  520 GOSUB 7000 : REM cross
  530 GOSUB 8000 : REM hourglass
  540 GOSUB 9000 : REM spiral
  550 :
  560 WAIT 300
  570 VDU 23,1,1
  580 COLOUR 7
  590 PRINT TAB(0,0);"Again? (Y/N)"
  600 A$=GET$
  610 IF A$="Y" OR A$="y" THEN VDU 23,1,0 : GOTO 400
  620 MODE 1
  630 END
  640 :
  650 :
  660 REM ================================
  670 REM  PROCNC: NEW COLOUR (1-63)
  680 REM  Never repeats current colour
  690 REM ================================
  700 DEF PROCNC
  710 NW%=CL%
  720 WHILE NW%=CL%
  730   NW%=RND(63)
  740 ENDWHILE
  750 CL%=NW%
  760 ENDPROC
  770 :
  780 :
  790 REM ================================
  800 REM  PROCST: TWINKLE STARS
  810 REM  Call each frame to animate
  820 REM  Picks a random star, toggles it
  830 REM  ZI = star index
  840 REM  ZC = star colour
  850 REM ================================
  860 DEF PROCST
  870 ZI%=RND(NS%)
  880 IF SV%(ZI%)=0 THEN
  890   ZC%=RND(63)
  900   GCOL 0,ZC%
  910   PLOT &45,SX%(ZI%),SY%(ZI%)
  920   SV%(ZI%)=ZC%
  930 ELSE
  940   GCOL 0,128
  950   PLOT &45,SX%(ZI%),SY%(ZI%)
  960   SV%(ZI%)=0
  970 ENDIF
  980 ENDPROC
  990 :
 1000 :
 1010 REM ================================
 1020 REM  PHASE 1: DOT -> LINE
 1030 REM  HL=half-length  QH=prev HL
 1040 REM ================================
 1050 :
 1100 PROCNC
 1110 QH%=0
 1120 FOR HL%=0 TO 400 STEP 8
 1130   PROCST
 1140   IF QH%>0 THEN
 1150     GCOL 0,128
 1160     PLOT &04,CX%-QH%,CY%
 1170     PLOT &05,CX%+QH%,CY%
 1180     GCOL 0,CL%
 1190   ENDIF
 1200   PLOT &04,CX%-HL%,CY%
 1210   PLOT &05,CX%+HL%,CY%
 1220   QH%=HL%
 1230   VDU 23,0,&C3
 1240 NEXT HL%
 1250 WAIT 150
 1260 CLG
 1270 RETURN
 1280 :
 1290 :
 1300 REM ================================
 1310 REM  PHASE 2: DOT -> TRIANGLE
 1320 REM  XL,XR=base X  YB=base Y
 1330 REM  YA=apex  YQ=prev apex
 1340 REM ================================
 1350 :
 2000 PROCNC
 2010 XL%=CX%-400 : XR%=CX%+400 : YB%=CY%
 2020 YQ%=YB%
 2030 FOR YA%=YB% TO YB%+350 STEP 7
 2040   PROCST
 2050   IF YQ%<>YB% THEN
 2060     GCOL 0,128
 2070     PLOT &04,XL%,YB%
 2080     PLOT &05,XR%,YB%
 2090     PLOT &05,CX%,YQ%
 2100     PLOT &05,XL%,YB%
 2110     GCOL 0,CL%
 2120   ENDIF
 2130   PLOT &04,XL%,YB%
 2140   PLOT &05,XR%,YB%
 2150   PLOT &05,CX%,YA%
 2160   PLOT &05,XL%,YB%
 2170   YQ%=YA%
 2180   VDU 23,0,&C3
 2190 NEXT YA%
 2200 WAIT 150
 2210 CLG
 2220 RETURN
 2230 :
 2240 :
 2250 REM ================================
 2260 REM  PHASE 3: DOT -> SQUARE
 2270 REM  YT=top Y  SW=spread
 2280 REM  QL,QR=prev top corners
 2290 REM ================================
 2300 :
 3000 PROCNC
 3010 XL%=CX%-400 : XR%=CX%+400
 3020 YB%=CY% : YT%=CY%+350
 3030 QL%=CX% : QR%=CX%
 3040 FOR SW%=0 TO 400 STEP 8
 3050   PROCST
 3060   IF SW%>0 THEN
 3070     GCOL 0,128
 3080     PLOT &04,XL%,YB%
 3090     PLOT &05,XR%,YB%
 3100     PLOT &05,QR%,YT%
 3110     PLOT &05,QL%,YT%
 3120     PLOT &05,XL%,YB%
 3130     GCOL 0,CL%
 3140   ENDIF
 3150   QL%=CX%-SW% : QR%=CX%+SW%
 3160   PLOT &04,XL%,YB%
 3170   PLOT &05,XR%,YB%
 3180   PLOT &05,QR%,YT%
 3190   PLOT &05,QL%,YT%
 3200   PLOT &05,XL%,YB%
 3210   VDU 23,0,&C3
 3220 NEXT SW%
 3230 WAIT 150
 3240 CLG
 3250 RETURN
 3260 :
 3270 :
 3280 REM ================================
 3290 REM  PHASE 4: ELLIPSE OR CIRCLE
 3300 REM  Randomly chosen each run
 3310 REM  ZX,ZY=centre  RX=h-radius
 3320 REM  RY=v-radius   QX=prev RX
 3330 REM ================================
 3340 :
 4000 PROCNC
 4010 ZX%=CX% : RY%=175
 4020 REM Randomly pick ellipse or circle
 4030 IF RND(2)=1 THEN ZY%=CY%+175 ELSE ZY%=CY%+200 : RY%=200
 4040 REM ZY adjusted: circle centres differently
 4050 QX%=0
 4060 FOR RX%=4 TO 400 STEP 8
 4070   PROCST
 4080   IF QX%>0 THEN
 4090     GCOL 0,128
 4100     PLOT &04,ZX%,ZY%
 4110     PLOT &04,ZX%+QX%,ZY%
 4120     PLOT &C5,ZX%,ZY%+RY%
 4130     GCOL 0,CL%
 4140   ENDIF
 4150   PLOT &04,ZX%,ZY%
 4160   PLOT &04,ZX%+RX%,ZY%
 4170   PLOT &C5,ZX%,ZY%+RY%
 4180   QX%=RX%
 4190   VDU 23,0,&C3
 4200 NEXT RX%
 4210 GCOL 0,128
 4220 PLOT &04,ZX%,ZY%
 4230 PLOT &04,ZX%+400,ZY%
 4240 PLOT &C5,ZX%,ZY%+RY%
 4250 GCOL 0,CL%
 4260 PLOT &04,ZX%,ZY%
 4270 PLOT &04,ZX%+400,ZY%
 4280 PLOT &CD,ZX%,ZY%+RY%
 4290 WAIT 150
 4300 CLG
 4310 RETURN
 4320 :
 4330 :
 4340 REM ================================
 4350 REM  PHASE 5: DOT -> DIAMOND
 4360 REM  4 vertices grow from centre:
 4370 REM  top, bottom, left, right
 4380 REM  DH=half-width  DV=half-height
 4390 REM  QD=prev half-width
 4400 REM ================================
 4410 :
 5000 PROCNC
 5010 QD%=0
 5020 FOR DH%=0 TO 380 STEP 8
 5030   PROCST
 5040   DV%=DH%*9/10
 5050   IF QD%>0 THEN
 5060     QV%=QD%*9/10
 5070     GCOL 0,128
 5080     PLOT &04,CX%,CY%+QV%
 5090     PLOT &05,CX%+QD%,CY%
 5100     PLOT &05,CX%,CY%-QV%
 5110     PLOT &05,CX%-QD%,CY%
 5120     PLOT &05,CX%,CY%+QV%
 5130     GCOL 0,CL%
 5140   ENDIF
 5150   PLOT &04,CX%,CY%+DV%
 5160   PLOT &05,CX%+DH%,CY%
 5170   PLOT &05,CX%,CY%-DV%
 5180   PLOT &05,CX%-DH%,CY%
 5190   PLOT &05,CX%,CY%+DV%
 5200   QD%=DH%
 5210   VDU 23,0,&C3
 5220 NEXT DH%
 5230 WAIT 150
 5240 CLG
 5250 RETURN
 5260 :
 5270 :
 5280 REM ================================
 5290 REM  PHASE 6: 6-POINTED STAR
 5300 REM  Two equilateral triangles,
 5310 REM  one pointing up, one down,
 5320 REM  grown simultaneously from dot
 5330 REM  SR=current radius  QS=prev
 5340 REM ================================
 5350 :
 6000 PROCNC
 6010 QS%=0
 6020 FOR SR%=4 TO 340 STEP 7
 6030   PROCST
 6040   REM Compute vertices at radius SR%
 6050   REM Up-triangle: top, bot-right, bot-left
 6060   U1X%=CX% : U1Y%=CY%+SR%
 6070   U2X%=CX%+SR%*87/100 : U2Y%=CY%-SR%/2
 6080   U3X%=CX%-SR%*87/100 : U3Y%=CY%-SR%/2
 6090   REM Down-triangle: bot, top-right, top-left
 6100   D1X%=CX% : D1Y%=CY%-SR%
 6110   D2X%=CX%+SR%*87/100 : D2Y%=CY%+SR%/2
 6120   D3X%=CX%-SR%*87/100 : D3Y%=CY%+SR%/2
 6130   IF QS%>0 THEN
 6140     QU1X%=CX% : QU1Y%=CY%+QS%
 6150     QU2X%=CX%+QS%*87/100 : QU2Y%=CY%-QS%/2
 6160     QU3X%=CX%-QS%*87/100 : QU3Y%=CY%-QS%/2
 6170     QD1X%=CX% : QD1Y%=CY%-QS%
 6180     QD2X%=CX%+QS%*87/100 : QD2Y%=CY%+QS%/2
 6190     QD3X%=CX%-QS%*87/100 : QD3Y%=CY%+QS%/2
 6200     GCOL 0,128
 6210     PLOT &04,QU1X%,QU1Y%
 6220     PLOT &05,QU2X%,QU2Y%
 6230     PLOT &05,QU3X%,QU3Y%
 6240     PLOT &05,QU1X%,QU1Y%
 6250     PLOT &04,QD1X%,QD1Y%
 6260     PLOT &05,QD2X%,QD2Y%
 6270     PLOT &05,QD3X%,QD3Y%
 6280     PLOT &05,QD1X%,QD1Y%
 6290     GCOL 0,CL%
 6300   ENDIF
 6310   PLOT &04,U1X%,U1Y%
 6320   PLOT &05,U2X%,U2Y%
 6330   PLOT &05,U3X%,U3Y%
 6340   PLOT &05,U1X%,U1Y%
 6350   PLOT &04,D1X%,D1Y%
 6360   PLOT &05,D2X%,D2Y%
 6370   PLOT &05,D3X%,D3Y%
 6380   PLOT &05,D1X%,D1Y%
 6390   QS%=SR%
 6400   VDU 23,0,&C3
 6410 NEXT SR%
 6420 WAIT 150
 6430 CLG
 6440 RETURN
 6450 :
 6460 :
 6470 REM ================================
 6480 REM  PHASE 7: DOT -> CROSS
 6490 REM  Two bars grow from centre:
 6500 REM  horizontal and vertical
 6510 REM  HA=half arm length
 6520 REM  HT=half arm thickness (fixed)
 6530 REM  QA=prev arm length
 6540 REM ================================
 6550 :
 7000 PROCNC
 7010 HT%=40 : QA%=0
 7020 FOR HA%=0 TO 400 STEP 8
 7030   PROCST
 7040   IF QA%>0 THEN
 7050     GCOL 0,128
 7060     REM Erase horizontal bar
 7070     PLOT &04,CX%-QA%,CY%-HT%
 7080     PLOT &05,CX%+QA%,CY%-HT%
 7090     PLOT &05,CX%+QA%,CY%+HT%
 7100     PLOT &05,CX%-QA%,CY%+HT%
 7110     PLOT &05,CX%-QA%,CY%-HT%
 7120     REM Erase vertical bar
 7130     PLOT &04,CX%-HT%,CY%-QA%
 7140     PLOT &05,CX%+HT%,CY%-QA%
 7150     PLOT &05,CX%+HT%,CY%+QA%
 7160     PLOT &05,CX%-HT%,CY%+QA%
 7170     PLOT &05,CX%-HT%,CY%-QA%
 7180     GCOL 0,CL%
 7190   ENDIF
 7200   REM Draw horizontal bar
 7210   PLOT &04,CX%-HA%,CY%-HT%
 7220   PLOT &05,CX%+HA%,CY%-HT%
 7230   PLOT &05,CX%+HA%,CY%+HT%
 7240   PLOT &05,CX%-HA%,CY%+HT%
 7250   PLOT &05,CX%-HA%,CY%-HT%
 7260   REM Draw vertical bar
 7270   PLOT &04,CX%-HT%,CY%-HA%
 7280   PLOT &05,CX%+HT%,CY%-HA%
 7290   PLOT &05,CX%+HT%,CY%+HA%
 7300   PLOT &05,CX%-HT%,CY%+HA%
 7310   PLOT &05,CX%-HT%,CY%-HA%
 7320   QA%=HA%
 7330   VDU 23,0,&C3
 7340 NEXT HA%
 7350 WAIT 150
 7360 CLG
 7370 RETURN
 7380 :
 7390 :
 7400 REM ================================
 7410 REM  PHASE 8: DOT -> HOURGLASS
 7420 REM  Two triangles apex-to-apex
 7430 REM  at centre, growing outward
 7440 REM  HG=half-height of each tri
 7450 REM  HW=half-width at outer edge
 7460 REM  QG=prev HG
 7470 REM ================================
 7480 :
 8000 PROCNC
 8010 QG%=0
 8020 FOR HG%=4 TO 320 STEP 7
 8030   PROCST
 8040   HW%=HG%*5/4
 8050   IF QG%>0 THEN
 8060     QW%=QG%*5/4
 8070     GCOL 0,128
 8080     REM Erase top triangle
 8090     PLOT &04,CX%,CY%
 8100     PLOT &05,CX%-QW%,CY%+QG%
 8110     PLOT &05,CX%+QW%,CY%+QG%
 8120     PLOT &05,CX%,CY%
 8130     REM Erase bottom triangle
 8140     PLOT &04,CX%,CY%
 8150     PLOT &05,CX%-QW%,CY%-QG%
 8160     PLOT &05,CX%+QW%,CY%-QG%
 8170     PLOT &05,CX%,CY%
 8180     GCOL 0,CL%
 8190   ENDIF
 8200   REM Draw top triangle
 8210   PLOT &04,CX%,CY%
 8220   PLOT &05,CX%-HW%,CY%+HG%
 8230   PLOT &05,CX%+HW%,CY%+HG%
 8240   PLOT &05,CX%,CY%
 8250   REM Draw bottom triangle
 8260   PLOT &04,CX%,CY%
 8270   PLOT &05,CX%-HW%,CY%-HG%
 8280   PLOT &05,CX%+HW%,CY%-HG%
 8290   PLOT &05,CX%,CY%
 8300   QG%=HG%
 8310   VDU 23,0,&C3
 8320 NEXT HG%
 8330 WAIT 150
 8340 CLG
 8350 RETURN
 8360 :
 8370 :
 8380 REM ================================
 8390 REM  PHASE 9: SPIRAL
 8400 REM  Draws outward spiral as series
 8410 REM  of short line segments using
 8420 REM  polar coords with integer sin/cos
 8430 REM  approximated in 24 steps/circle
 8440 REM  AN=angle step  RD=radius
 8450 REM  PX,PY=prev point  FX,FY=first
 8460 REM ================================
 8470 :
 9000 PROCNC
 9010 REM 24-point sin table (*1000)
 9020 REM angles 0,15,30..345 degrees
 9030 DIM SN%(23)
 9040 SN%(0)=0
 9050 SN%(1)=259
 9060 SN%(2)=500
 9070 SN%(3)=707
 9080 SN%(4)=866
 9090 SN%(5)=966
 9100 SN%(6)=1000
 9110 SN%(7)=966
 9120 SN%(8)=866
 9130 SN%(9)=707
 9140 SN%(10)=500
 9150 SN%(11)=259
 9160 SN%(12)=0
 9170 SN%(13)=-259
 9180 SN%(14)=-500
 9190 SN%(15)=-707
 9200 SN%(16)=-866
 9210 SN%(17)=-966
 9220 SN%(18)=-1000
 9230 SN%(19)=-966
 9240 SN%(20)=-866
 9250 SN%(21)=-707
 9260 SN%(22)=-500
 9270 SN%(23)=-259
 9280 :
 9290 GCOL 0,CL%
 9300 REM Start at centre
 9310 FX%=CX% : FY%=CY%
 9320 PLOT &04,FX%,FY%
 9330 :
 9340 REM 3 full rotations, 24 steps each
 9350 REM Radius grows by 5 per step
 9360 FOR AN%=1 TO 72
 9370   PROCST
 9380   ZI%=AN% MOD 24
 9390   RD%=AN%*5
 9400   REM cos = sin offset by 6 steps
 9410   ZJ%=(AN%+6) MOD 24
 9420   NX%=CX%+RD%*SN%(ZJ%)/1000
 9430   NY%=CY%+RD%*SN%(ZI%)/1000
 9440   PLOT &05,NX%,NY%
 9450   VDU 23,0,&C3
 9460 NEXT AN%
 9470 WAIT 300
 9480 CLG
 9490 RETURN
