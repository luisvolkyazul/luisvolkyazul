   10 REM BRISCA - Spanish Card Game
   20 REM Agon Light 2 / BBC BASIC V
   30 REM 2 Players: You vs Computer
   40 REM Enhanced Graphics Edition
   50 REM Card art inspired by:
   60 REM github.com/gjenkins20/spanish-playing-cards-svg
   70 REM CC BY-SA 3.0 - Basquetteur (Wikimedia Commons)
   80 REM ============================
  100 DIM sN$(4)
  110 sN$(1)="Oros" : sN$(2)="Copas"
  120 sN$(3)="Espadas" : sN$(4)="Bastos"
  140 DIM rS$(10)
  150 rS$(1)="A" : rS$(2)="2" : rS$(3)="3"
  160 rS$(4)="4" : rS$(5)="5" : rS$(6)="6"
  170 rS$(7)="7" : rS$(8)="J" : rS$(9)="Q"
  180 rS$(10)="K"
  200 DIM pts%(10)
  210 pts%(1)=11 : pts%(2)=0 : pts%(3)=10
  220 pts%(4)=0 : pts%(5)=0 : pts%(6)=0
  230 pts%(7)=0 : pts%(8)=2 : pts%(9)=3
  240 pts%(10)=4
  260 DIM str%(10)
  270 str%(1)=7 : str%(2)=-2 : str%(3)=6
  280 str%(4)=-1 : str%(5)=0 : str%(6)=1
  290 str%(7)=2 : str%(8)=3 : str%(9)=4
  300 str%(10)=5
  320 DIM dF%(40), dS%(40)
  330 DIM pH%(3), cH%(3)
  340 DIM tF%(2), tSu%(2)
  360 REM ============================
  370 REM CARD LAYOUT CONSTANTS
  380 REM MODE 8: logical 1280x1024
  390 REM Card size: 130 wide, 190 tall
  400 REM ============================
  410 CW%=130 : CH%=190
  420 pY%=30  : REM player hand Y
  430 cY%=734 : REM CPU hand Y
  440 c1X%=60 : REM first card X
  450 cGap%=170 : REM gap between cards
  460 trX%=1010 : trY%=420 : REM trump card pos
  480 REM ============================
  490 REM TITLE SCREEN
  500 REM ============================
  510 MODE 8
  520 GCOL 0,2 : CLG
  530 COLOUR 7
  540 PRINT TAB(7,2)"=========================="
  550 PRINT TAB(8,3)"B R I S C A S  for Agon"
  560 PRINT TAB(7,4)"=========================="
  570 COLOUR 3
  580 PRINT TAB(4,7)"Ranks: A > 3 > K > Q > J"
  590 PRINT TAB(4,8)"       > 7 > 6 > 5 > 4 > 2"
  600 PRINT TAB(4,10)"Points: A=11  3=10  K=4  Q=3  J=2"
  610 COLOUR 7
  620 PRINT TAB(4,12)"Trump beats all other suits."
  630 PRINT TAB(4,13)"Highest of led suit wins."
  640 COLOUR 6
  650 PRINT TAB(4,16)"Spanish suits:"
  660 su%=1 : sx%=200 : sy%=400 : sr%=30 : GOSUB 11020
  670 su%=2 : sx%=450 : sy%=400 : sr%=30 : GOSUB 11020
  680 su%=3 : sx%=700 : sy%=400 : sr%=30 : GOSUB 11020
  690 su%=4 : sx%=950 : sy%=400 : sr%=30 : GOSUB 11020
  700 COLOUR 7
  710 PRINT TAB(4,20)"Oros"
  712 PRINT TAB(12,20)"Copas"
  714 PRINT TAB(19,20)"Espadas"
  716 PRINT TAB(27,20)"Bastos"
  720 COLOUR 14 : PRINT TAB(8,23)"Press any key..."
  730 q$=GET$
  810 REM ============================
  820 REM NEW HAND - BUILD DECK
  830 REM ============================
  840 pSc%=0 : cSc%=0
  850 idx%=0
  860 FOR su%=1 TO 4
  870   FOR fv%=1 TO 10
  880     idx%=idx%+1
  890     dF%(idx%)=fv%
  900     dS%(idx%)=su%
  910   NEXT fv%
  920 NEXT su%
  940 REM Shuffle (Fisher-Yates)
  950 FOR i%=40 TO 2 STEP -1
  960   j%=INT(RND(1)*i%)+1
  970   tf%=dF%(i%) : ts%=dS%(i%)
  980   dF%(i%)=dF%(j%) : dS%(i%)=dS%(j%)
  990   dF%(j%)=tf% : dS%(j%)=ts%
 1000 NEXT i%
 1020 REM Deal: player 1-3, CPU 4-6
 1030 pH%(1)=1 : pH%(2)=2 : pH%(3)=3
 1040 cH%(1)=4 : cH%(2)=5 : cH%(3)=6
 1050 REM Card 7 is trump; drawable starts at 8
 1060 trF%=dF%(7) : trS%=dS%(7)
 1070 top%=8
 1080 ldr%=1 : trk%=0
 1100 REM ============================
 1110 REM TRICK LOOP
 1120 REM ============================
 1130 trk%=trk%+1
 1150 REM --- DRAW THE GAME SCREEN ---
 1160 GCOL 0,2 : CLG
 1180 REM Draw trump card (if still available)
 1190 IF trF%>0 THEN GOSUB 11820
 1210 REM Draw CPU card backs (3 face-down)
 1220 GOSUB 11900
 1240 REM Draw player hand (3 face-up)
 1250 GOSUB 12000
 1270 REM Draw score panel at top
 1280 GOSUB 12200
 1300 REM --- DISPATCH BASED ON LEADER ---
 1310 IF ldr%=1 THEN GOSUB 2000
 1320 IF ldr%=2 THEN GOSUB 3000
 1340 REM --- SCORE THE TRICK ---
 1350 tp%=pts%(tF%(1))+pts%(tF%(2))
 1360 GOSUB 4000
 1380 pw%=0
 1390 IF ldr%=1 AND winner%=1 THEN pw%=1
 1400 IF ldr%=2 AND winner%=2 THEN pw%=1
 1420 IF pw%=1 THEN pSc%=pSc%+tp% : ldr%=1
 1430 IF pw%=0 THEN cSc%=cSc%+tp% : ldr%=2
 1450 REM Show trick result
 1460 GOSUB 12300
 1470 q$=GET$
 1490 REM --- DRAW CARDS ---
 1500 IF top%<=40 THEN GOSUB 5000
 1520 REM --- CHECK HANDS EMPTY ---
 1530 pc%=0 : cc%=0
 1540 IF pH%(1)>0 THEN pc%=pc%+1
 1550 IF pH%(2)>0 THEN pc%=pc%+1
 1560 IF pH%(3)>0 THEN pc%=pc%+1
 1570 IF cH%(1)>0 THEN cc%=cc%+1
 1580 IF cH%(2)>0 THEN cc%=cc%+1
 1590 IF cH%(3)>0 THEN cc%=cc%+1
 1605 REM If deck empty and one player out, give them trump card
 1610 IF top%>40 AND trF%>0 THEN
 1615   IF pc%=0 AND cc%>0 THEN pH%(1)=7 : trF%=0 : pc%=1
 1620   IF cc%=0 AND pc%>0 THEN cH%(1)=7 : trF%=0 : cc%=1
 1625 ENDIF
 1630 IF pc%>0 AND cc%>0 THEN GOTO 1130
 1640 REM ============================
 1650 REM HAND OVER
 1660 REM ============================
 1670 GCOL 0,0 : CLG
 1680 COLOUR 0 : CLS
 1690 COLOUR 7
 1700 PRINT TAB(4,2)"====== HAND OVER ======"
 1710 COLOUR 3 : PRINT TAB(4,4)"Your score:     ";pSc%
 1720 COLOUR 5 : PRINT TAB(4,5)"Computer score: ";cSc%
 1730 COLOUR 7 : PRINT TAB(4,7)"========================"
 1740 IF pSc%>cSc% THEN COLOUR 10 : PRINT TAB(4,9)"*** YOU WIN! ***"
 1750 IF cSc%>pSc% THEN COLOUR 9  : PRINT TAB(4,9)"Computer wins."
 1760 IF pSc%=cSc% THEN COLOUR 14 : PRINT TAB(4,9)"Tie! (60-60)"
 1770 COLOUR 7 : PRINT TAB(4,12)"Play again? (Y/N)"
 1780 q$=GET$
 1790 IF q$="Y" OR q$="y" THEN GOTO 840
 1800 COLOUR 3 : PRINT TAB(4,14)"Thanks for playing Briscas!"
 1810 END
 1820 REM ============================
 1830 REM SUB 2000: PLAYER LEADS
 1840 REM ============================
 2000 COLOUR 11
 2010 PRINT TAB(19,22)"You lead!"
 2020 GOSUB 6000
 2030 pp%=pH%(pSlot%) : pH%(pSlot%)=0
 2040 tF%(1)=dF%(pp%) : tSu%(1)=dS%(pp%)
 2050 led%=tSu%(1)
 2060 GOSUB 7000
 2070 cp%=cH%(cSlot%) : cH%(cSlot%)=0
 2080 tF%(2)=dF%(cp%) : tSu%(2)=dS%(cp%)
 2090 GOSUB 12400
 2100 RETURN
 2120 REM ============================
 2130 REM SUB 3000: CPU LEADS
 2140 REM ============================
 3000 GOSUB 8000
 3010 cp%=cH%(cSlot%) : cH%(cSlot%)=0
 3020 tF%(1)=dF%(cp%) : tSu%(1)=dS%(cp%)
 3030 led%=tSu%(1)
 3040 COLOUR 5
 3050 PRINT TAB(19,22)"CPU leads: ";rS$(tF%(1));" ";sN$(tSu%(1))
 3060 COLOUR 11
 3070 PRINT TAB(19,23)"Your turn."
 3080 GOSUB 6000
 3090 pp%=pH%(pSlot%) : pH%(pSlot%)=0
 3100 tF%(2)=dF%(pp%) : tSu%(2)=dS%(pp%)
 3110 GOSUB 12400
 3120 RETURN
 3140 REM ============================
 3150 REM SUB 4000: EVALUATE TRICK
 3160 REM ============================
 4000 f1%=tF%(1) : s1%=tSu%(1)
 4010 f2%=tF%(2) : s2%=tSu%(2)
 4020 winner%=1
 4030 IF s1%=trS% AND s2%=trS% THEN IF str%(f2%)>str%(f1%) THEN winner%=2
 4040 IF s1%=trS% AND s2%=trS% THEN RETURN
 4050 IF s1%=trS% THEN winner%=1 : RETURN
 4060 IF s2%=trS% THEN winner%=2 : RETURN
 4070 IF s2%=s1% THEN IF str%(f2%)>str%(f1%) THEN winner%=2
 4080 RETURN
 4100 REM ============================
 4110 REM SUB 5000: DRAW CARDS
 4120 REM ============================
 5000 IF pw%=1 THEN GOSUB 5200 : GOSUB 5300
 5010 IF pw%=0 THEN GOSUB 5300 : GOSUB 5200
 5020 RETURN
 5040 REM SUB 5200: Player draws one card
 5200 IF top%>40 THEN RETURN
 5210 IF pH%(1)=0 THEN pH%(1)=top% : top%=top%+1 : RETURN
 5220 IF pH%(2)=0 THEN pH%(2)=top% : top%=top%+1 : RETURN
 5230 IF pH%(3)=0 THEN pH%(3)=top% : top%=top%+1 : RETURN
 5240 RETURN
 5260 REM SUB 5300: CPU draws one card
 5300 IF top%>40 THEN RETURN
 5310 IF cH%(1)=0 THEN cH%(1)=top% : top%=top%+1 : RETURN
 5320 IF cH%(2)=0 THEN cH%(2)=top% : top%=top%+1 : RETURN
 5330 IF cH%(3)=0 THEN cH%(3)=top% : top%=top%+1 : RETURN
 5340 RETURN
 5360 REM ============================
 5370 REM SUB 6000: PLAYER PICKS CARD
 5380 REM ============================
 6000 pSlot%=0
 6010 INPUT TAB(19,23)"Pick slot (1-3): " ch$
 6020 pSlot%=VAL(ch$)
 6030 IF pSlot%<1 THEN GOTO 6010
 6040 IF pSlot%>3 THEN GOTO 6010
 6050 IF pH%(pSlot%)=0 THEN GOTO 6010
 6060 RETURN
 6080 REM ============================
 6090 REM SUB 7000: CPU RESPONDS
 6100 REM ============================
 7000 cSlot%=0 : bestS%=-999
 7010 IF cH%(1)>0 THEN IF dS%(cH%(1))=led% THEN IF str%(dF%(cH%(1)))>bestS% THEN bestS%=str%(dF%(cH%(1))) : cSlot%=1
 7020 IF cH%(2)>0 THEN IF dS%(cH%(2))=led% THEN IF str%(dF%(cH%(2)))>bestS% THEN bestS%=str%(dF%(cH%(2))) : cSlot%=2
 7030 IF cH%(3)>0 THEN IF dS%(cH%(3))=led% THEN IF str%(dF%(cH%(3)))>bestS% THEN bestS%=str%(dF%(cH%(3))) : cSlot%=3
 7040 IF cSlot%>0 THEN RETURN
 7050 lowS%=999
 7060 IF cH%(1)>0 THEN IF dS%(cH%(1))=trS% THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
 7070 IF cH%(2)>0 THEN IF dS%(cH%(2))=trS% THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
 7080 IF cH%(3)>0 THEN IF dS%(cH%(3))=trS% THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
 7090 IF cSlot%>0 THEN RETURN
 7100 lowS%=999
 7110 IF cH%(1)>0 THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
 7120 IF cH%(2)>0 THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
 7130 IF cH%(3)>0 THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
 7140 RETURN
 7160 REM ============================
 7170 REM SUB 8000: CPU LEADS (select)
 7180 REM ============================
 8000 cSlot%=0 : highS%=-999
 8010 IF cH%(1)>0 THEN IF dS%(cH%(1))<>trS% THEN IF str%(dF%(cH%(1)))>highS% THEN highS%=str%(dF%(cH%(1))) : cSlot%=1
 8020 IF cH%(2)>0 THEN IF dS%(cH%(2))<>trS% THEN IF str%(dF%(cH%(2)))>highS% THEN highS%=str%(dF%(cH%(2))) : cSlot%=2
 8030 IF cH%(3)>0 THEN IF dS%(cH%(3))<>trS% THEN IF str%(dF%(cH%(3)))>highS% THEN highS%=str%(dF%(cH%(3))) : cSlot%=3
 8040 IF cSlot%>0 THEN RETURN
 8050 lowS%=999
 8060 IF cH%(1)>0 THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
 8070 IF cH%(2)>0 THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
 8080 IF cH%(3)>0 THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
 8090 RETURN
 8110 REM ==========================================
 8120 REM ENHANCED GRAPHICS SUBROUTINES
 8130 REM Line numbers: 10500-12500
 8140 REM All line numbers unique, ascending
 8150 REM ==========================================
 8170 REM ============================
 8180 REM SUB 10500: DRAW CARD BODY
 8190 REM (cx%,cy%) = bottom-left
 8200 REM ============================
10500 GCOL 0,7
10510 PLOT &64, cx%, cy%
10520 PLOT &65, cx%+CW%, cy%+CH%
10530 PLOT &64, cx%-2, cy%+4
10540 PLOT &65, cx%+4, cy%+CH%-4
10550 PLOT &64, cx%+CW%-4, cy%+4
10560 PLOT &65, cx%+CW%+2, cy%+CH%-4
10570 GCOL 0,0
10580 PLOT &04, cx%, cy%
10590 PLOT &05, cx%+CW%, cy%
10600 PLOT &04, cx%+CW%, cy%
10610 PLOT &05, cx%+CW%, cy%+CH%
10620 PLOT &04, cx%+CW%, cy%+CH%
10630 PLOT &05, cx%, cy%+CH%
10640 PLOT &04, cx%, cy%+CH%
10650 PLOT &05, cx%, cy%
10660 RETURN
10680 REM ============================
10690 REM SUB 10700: DRAW CARD BACK
10700 REM (cx%,cy%) = bottom-left
10710 REM ============================
10720 GCOL 0,4
10730 PLOT &64, cx%, cy%
10740 PLOT &65, cx%+CW%, cy%+CH%
10750 GCOL 0,6
10760 PLOT &54, cx%+CW%/2, cy%+CH%/4
10770 PLOT &55, cx%+CW%*3/4, cy%+CH%/2
10780 PLOT &55, cx%+CW%/2, cy%+CH%*3/4
10790 PLOT &54, cx%+CW%/2, cy%+CH%/4
10800 PLOT &55, cx%+CW%/4, cy%+CH%/2
10810 PLOT &55, cx%+CW%/2, cy%+CH%*3/4
10820 GCOL 0,0
10830 PLOT &04, cx%, cy%
10840 PLOT &05, cx%+CW%, cy%
10850 PLOT &04, cx%+CW%, cy%
10860 PLOT &05, cx%+CW%, cy%+CH%
10870 PLOT &04, cx%+CW%, cy%+CH%
10880 PLOT &05, cx%, cy%+CH%
10890 PLOT &04, cx%, cy%+CH%
10900 PLOT &05, cx%, cy%
10910 RETURN
10930 REM ============================
10940 REM SUB 11000: ENHANCED SUIT DISPATCH
10950 REM su%=suit, (sx%,sy%)=centre, sr%=size
10960 REM ============================
11020 IF su%=1 THEN GOSUB 11100
11030 IF su%=2 THEN GOSUB 11200
11040 IF su%=3 THEN GOSUB 11400
11050 IF su%=4 THEN GOSUB 11700
11060 RETURN
11080 REM OROS (Coins): Gold circle with cross
11100 GCOL 0,3 : PLOT &9C,sx%,sy% : PLOT &9D,sx%,sy%+sr%
11110 GCOL 0,11 : PLOT &9C,sx%,sy% : PLOT &9D,sx%,sy%+sr%*3/4
11120 GCOL 0,9 : PLOT &64,sx%-sr%/6,sy%-sr%/6 : PLOT &65,sx%+sr%/6,sy%+sr%/6
11130 RETURN
11150 REM COPAS (Cups): Red chalice
11200 GCOL 0,1
11210 PLOT &64,sx%-sr%/2,sy%+sr%/3
11220 PLOT &65,sx%+sr%/2,sy%+sr%*2/3
11230 PLOT &54,sx%-sr%/2,sy%+sr%/3
11240 PLOT &55,sx%+sr%/2,sy%+sr%/3
11250 PLOT &55,sx%,sy%-sr%/3
11260 PLOT &64,sx%-sr%/8,sy%-sr%/3
11270 PLOT &65,sx%+sr%/8,sy%-sr%*2/3
11280 PLOT &64,sx%-sr%/3,sy%-sr%*2/3
11290 PLOT &65,sx%+sr%/3,sy%-sr%
11300 RETURN
11320 REM ESPADAS (Swords): Blue rapier
11400 GCOL 0,4
11402 PLOT &64,sx%,sy%
11410 PLOT &54,sx%-sr%/3,sy%
11420 PLOT &55,sx%+sr%/3,sy%
11430 PLOT &55,sx%,sy%+sr%*3/2
11440 PLOT &54,sx%-sr%/3,sy%
11450 PLOT &55,sx%+sr%/3,sy%
11460 PLOT &55,sx%,sy%-sr%/2
11470 GCOL 0,7
11480 PLOT &64,sx%-sr%/2,sy%-sr%/4
11490 PLOT &65,sx%+sr%/2,sy%-sr%/8
11500 GCOL 0,6
11510 PLOT &64,sx%-sr%/8,sy%-sr%/4
11520 PLOT &65,sx%+sr%/8,sy%-sr%*2/3
11530 GCOL 0,7
11540 PLOT &9C,sx%,sy%-sr%*2/3
11550 PLOT &9D,sx%,sy%-sr%*5/6
11560 RETURN
11580 REM BASTOS (Clubs): Green tapered club with vine
11700 GCOL 0,2
11702 PLOT &64,sx%-sr%/6,sy%-sr%
11704 PLOT &54,sx%+sr%/6,sy%-sr%
11706 PLOT &55,sx%+sr%/2,sy%+sr%/3
11708 PLOT &54,sx%-sr%/2,sy%+sr%/3
11710 PLOT &55,sx%-sr%/6,sy%-sr%
11720 PLOT &9C,sx%,sy%+sr%/2
11730 PLOT &9D,sx%+sr%/2,sy%+sr%/2
11740 GCOL 0,9
11750 PLOT &04,sx%-sr%/5,sy%-sr%*3/4
11760 PLOT &05,sx%+sr%/4,sy%-sr%/2
11770 PLOT &04,sx%-sr%/3,sy%-sr%/4
11780 PLOT &05,sx%+sr%/3,sy%+sr%/12
11790 PLOT &04,sx%-sr%/2,sy%+sr%/6
11800 PLOT &05,sx%+sr%/2,sy%+sr%/3
11810 RETURN
11814 REM ============================
11816 REM SUB 11820: DRAW TRUMP CARD
11818 REM Face-up in top-right corner
11820 cx%=trX% : cy%=trY% : GOSUB 10500
11822 GCOL 0,1
11824 PLOT &64,trX%+5,trY%+CH%-10 : PLOT &65,trX%+CW%-5,trY%+CH%
11826 GCOL 0,7
11828 tcol%=(trX%+8)/32 : trow%=29-((trY%+CH%-16)/34)
11830 PRINT TAB(tcol%,trow%-2);"TRUMP": REM MOVED UP BY 2
11832 tcol%=(trX%+8)/32 : trow%=29-((trY%+CH%-40)/34)
11834 COLOUR 1 : PRINT TAB(tcol%,trow%-2);rS$(trF%): REM MOVED UP BY 2
11836 PRINT TAB(tcol%,trow%-1);sN$(trS%): REM MOVED UP BY 1
11838 su%=trS% : sx%=trX%+CW%/2 : sy%=trY%+CH%/2 : sr%=28 : GOSUB 11020
11840 RETURN
11844 REM ============================
11846 REM SUB 11900: DRAW CPU CARD BACKS
11848 REM 3 face-down cards at top
11850 REM ============================
11900 FOR sl%=1 TO 3
11910   cx%=c1X%+(sl%-1)*cGap%
11920   IF cH%(sl%)=0 THEN GOTO 11960
11925   cy%=cY%
11930   GOSUB 10700
11940   tcol%=(cx%+8)/32 : trow%=29-((cY%+10)/34)
11950   COLOUR 7 : PRINT TAB(tcol%,trow%+2);"[";sl%;"]": REM MOVED DOWN BY 2
11960 NEXT sl%
11970 RETURN
11974 REM ============================
11976 REM SUB 12000: DRAW PLAYER HAND
11978 REM 3 face-up cards at bottom
11980 REM ============================
12000 FOR sl%=1 TO 3
12010   cx%=c1X%+(sl%-1)*cGap%
12015   cy%=pY%
12020   GOSUB 10500
12030   tcol%=(cx%+6)/32
12040   trow%=29-((pY%+CH%-10)/34)
12050   IF pH%(sl%)>0 THEN GOSUB 12100
12060   COLOUR 7
12070   PRINT TAB(tcol%,trow%-2);"[";sl%;"]": REM MOVED UP BY 2
12080 NEXT sl%
12090 RETURN
12100 COLOUR 1
12110 PRINT TAB(tcol%,trow%-1);rS$(dF%(pH%(sl%))): REM MOVED UP BY 1
12120 PRINT TAB(tcol%,trow%);LEFT$(sN$(dS%(pH%(sl%))),4)
12130 su%=dS%(pH%(sl%))
12140 sx%=cx%+CW%/2 : sy%=pY%+CH%/2 : sr%=24 : GOSUB 11020
12150 RETURN
12162 REM ============================
12164 REM SUB 12200: DRAW SCORE PANEL
12166 REM Dark bar at top with scores
12168 REM ============================
12200 GCOL 0,0
12210 PLOT &64,0,1024-100 : PLOT &65,1280,1024
12220 GCOL 0,6
12230 PLOT &64,2,1024-98 : PLOT &65,1278,1024-2
12240 COLOUR 7
12250 PRINT TAB(9,0)"Trick:";trk%;"  You:";pSc%;"  CPU:";cSc%
12270 COLOUR 7
12280 RETURN
12297 REM ============================
12298 REM SUB 12300: SHOW TRICK RESULT
12299 REM ============================
12300 COLOUR 10
12310 IF pw%=1 THEN PRINT TAB(19,24)"PLAYER wins +";tp%;"pts"
12320 IF pw%=0 THEN PRINT TAB(19,24)"CPU wins +";tp%;"pts"
12330 COLOUR 7
12340 PRINT TAB(19,25)"You:";pSc%;" CPU:";cSc%
12350 PRINT TAB(19,26)"Press any key..."
12360 RETURN
12372 REM ============================
12374 REM SUB 12400: SHOW PLAYED CARDS
12376 REM Draw both played cards in centre
12378 REM ============================
12400 FOR pl%=1 TO 2
12410   cx%=200+(pl%-1)*400 : cy%=380
12420   GOSUB 10500
12430   su%=tSu%(pl%) : sx%=cx%+CW%/2 : sy%=cy%+CH%/2 : sr%=22 : GOSUB 11020
12440   tcol%=(cx%+6)/32 : trow%=29-((cy%+CH%-10)/34)
12450   COLOUR 1 : PRINT TAB(tcol%,trow%);rS$(tF%(pl%))
12460   PRINT TAB(tcol%,trow%+1);sN$(tSu%(pl%))
12470 NEXT pl%
12480 COLOUR 7
12490 PRINT TAB(0,10)"                                      "
12500 RETURN
