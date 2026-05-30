   10 REM EPIC MORPHING SHAPES - Final Enhanced Version
   20 REM Fixed Triangle + Full Sequence + Vibrant Colors
   30 MODE 20
   40 VDU 23,1,0
   50 CX%=640 : CY%=512
   60 DIM KC%(63)
   70 FOR I%=1 TO 63 : KC%(I%-1)=I% : NEXT
   80 :
   90 REPEAT
  100   CLG
  110   GCOL 0,63 : PLOT &45,CX%,CY%        : REM Starting dot
  120   WAIT 160
  130   PROCsequence
  140   WAIT 280
  150   COLOUR 7
  160   PRINT TAB(0,0);"Press Y for another cycle, any other key to quit"
  170   A$=GET$
  180 UNTIL A$<>"Y" AND A$<>"y"
  190 VDU 23,1,1 : MODE 1 : END
  200 :
  210 DEF PROCnewcolour
  220   CL%=KC%(RND(63)-1)
  230   GCOL 0,CL%
  240 ENDPROC
  250 :
  260 REM ====================== SEQUENCE ======================
  270 DEF PROCsequence
  280   PROCdot
  290   PROCline
  300   PROCtriangle
  310   PROCsquare
  320   PROCellipse
  330   PROCpentagon
  340   PROChexagon
  350   PROCstar
  360   PROCdiamond
  370   PROCoctagon
  380 ENDPROC
  390 :
  400 REM 1. DOT
  410 DEF PROCdot
  420   PROCnewcolour
  430   PLOT &45,CX%,CY%
  440   WAIT 140
  450   CLG
  460 ENDPROC
  470 :
  480 REM 2. LINE
  490 DEF PROCline
  500   PROCnewcolour
  510   FOR I%=0 TO 65
  520     L%=30 + I%*8
  530     GCOL 0,128 : PLOT &04,CX%-L%-25,CY% : PLOT &05,CX%+L%+25,CY%
  540     GCOL 0,CL%
  550     PLOT &04,CX%-L%,CY% : PLOT &05,CX%+L%,CY%
  560     VDU 23,0,&C3 : WAIT 5
  570   NEXT
  580   WAIT 80 : CLG
  590 ENDPROC
  600 :
  610 REM 3. TRIANGLE - FIXED
  620 DEF PROCtriangle
  630   PROCnewcolour
  640   FOR I%=0 TO 58
  650     SZ%=105 + I%*6
  660     GCOL 0,128 
  670     PLOT &04,CX%-230,CY%-180 : PLOT &05,CX%+230,CY%-180 
  680     PLOT &05,CX%,CY%+190
  690     GCOL 0,CL%
  700     MOVE CX%,CY%-SZ%           : REM Top
  710     DRAW CX%-SZ%,CY%+SZ%*0.6   : REM Bottom Left
  720     DRAW CX%+SZ%,CY%+SZ%*0.6   : REM Bottom Right
  730     DRAW CX%,CY%-SZ%           : REM Back to Top (closes shape)
  740     VDU 23,0,&C3 : WAIT 6
  750   NEXT
  760   WAIT 85 : CLG
  770 ENDPROC
  780 :
  790 REM 4. SQUARE
  800 DEF PROCsquare
  810   PROCnewcolour
  820   FOR I%=0 TO 58
  830     SZ%=115 + I%*5
  840     GCOL 0,128
  850     PLOT &04,CX%-SZ%,CY%-SZ% : PLOT &05,CX%+SZ%,CY%-SZ%
  860     PLOT &05,CX%+SZ%,CY%+SZ% : PLOT &05,CX%-SZ%,CY%+SZ%
  870     GCOL 0,CL%
  880     MOVE CX%-SZ%,CY%-SZ%
  890     DRAW CX%+SZ%,CY%-SZ%
  900     DRAW CX%+SZ%,CY%+SZ%
  910     DRAW CX%-SZ%,CY%+SZ%
  920     DRAW CX%-SZ%,CY%-SZ%
  930     VDU 23,0,&C3 : WAIT 6
  940   NEXT
  950   WAIT 85 : CLG
  960 ENDPROC
  970 :
  980 REM 5. ELLIPSE
  990 DEF PROCellipse
 1000   PROCnewcolour
 1010   FOR I%=0 TO 60
 1020     HR%=78 + I%*6.5
 1030     VR%=50 + I%*4.8
 1040     GCOL 0,128
 1050     PLOT &04,CX%,CY% : PLOT &04,CX%+235,CY% : PLOT &C5,CX%,CY%+175
 1060     GCOL 0,CL%
 1070     MOVE CX%,CY%
 1080     MOVE CX%+HR%,CY%
 1090     PLOT &CD,CX%,CY%+VR%
 1100     VDU 23,0,&C3 : WAIT 6
 1110   NEXT
 1120   WAIT 110 : CLG
 1130 ENDPROC
 1140 :
 1150 REM 6. PENTAGON
 1160 DEF PROCpentagon
 1170   PROCnewcolour
 1180   FOR I%=0 TO 55
 1190     SZ%=110 + I%*5
 1200     GCOL 0,CL%
 1210     MOVE CX%,CY%-SZ%
 1220     FOR A=0 TO 4
 1230       X=CX% + SZ%*SIN(RAD(A*72 + I%*3))
 1240       Y=CY% + SZ%*COS(RAD(A*72 + I%*3))*0.85
 1250       DRAW X,Y
 1260     NEXT
 1270     DRAW CX%,CY%-SZ%
 1280     VDU 23,0,&C3 : WAIT 6
 1290   NEXT
 1300   WAIT 80 : CLG
 1310 ENDPROC
 1320 :
 1330 REM 7. HEXAGON
 1340 DEF PROChexagon
 1350   PROCnewcolour
 1360   FOR I%=0 TO 55
 1370     SZ%=115 + I%*5
 1380     GCOL 0,CL%
 1390     MOVE CX%+SZ%,CY%
 1400     FOR A=0 TO 5
 1410       X=CX% + SZ%*COS(RAD(A*60 + I%*3))
 1420       Y=CY% + SZ%*SIN(RAD(A*60 + I%*3))
 1430       DRAW X,Y
 1440     NEXT
 1450     VDU 23,0,&C3 : WAIT 6
 1460   NEXT
 1470   WAIT 80 : CLG
 1480 ENDPROC
 1490 :
 1500 REM 8. ROTATING STAR
 1510 DEF PROCstar
 1520   PROCnewcolour
 1530   FOR I%=0 TO 58
 1540     SZ%=95 + I%*5
 1550     GCOL 0,CL%
 1560     MOVE CX%,CY%-SZ%
 1570     FOR A=0 TO 9
 1580       R = SZ% * (0.4 + 0.6*(A MOD 2))
 1590       X=CX% + R*COS(RAD(A*36 + I%*4))
 1600       Y=CY% + R*SIN(RAD(A*36 + I%*4))
 1610       DRAW X,Y
 1620     NEXT
 1630     VDU 23,0,&C3 : WAIT 6
 1640   NEXT
 1650   WAIT 90 : CLG
 1660 ENDPROC
 1670 :
 1680 REM 9. DIAMOND
 1690 DEF PROCdiamond
 1700   PROCnewcolour
 1710   FOR I%=0 TO 55
 1720     SZ%=130 + I%*5
 1730     GCOL 0,CL%
 1740     MOVE CX%,CY%-SZ%
 1750     DRAW CX%+SZ%,CY%
 1760     DRAW CX%,CY%+SZ%
 1770     DRAW CX%-SZ%,CY%
 1780     DRAW CX%,CY%-SZ%
 1790     VDU 23,0,&C3 : WAIT 6
 1800   NEXT
 1810   WAIT 80 : CLG
 1820 ENDPROC
 1830 :
 1840 REM 10. OCTAGON
 1850 DEF PROCoctagon
 1860   PROCnewcolour
 1870   FOR I%=0 TO 52
 1880     SZ%=110 + I%*5
 1890     GCOL 0,CL%
 1900     MOVE CX%+SZ%*0.75,CY%
 1910     FOR A=0 TO 7
 1920       X=CX% + SZ%*COS(RAD(A*45 + I%*3))
 1930       Y=CY% + SZ%*SIN(RAD(A*45 + I%*3))
 1940       DRAW X,Y
 1950     NEXT
 1960     VDU 23,0,&C3 : WAIT 6
 1970   NEXT
 1980   WAIT 120 : CLG
 1990 ENDPROC
