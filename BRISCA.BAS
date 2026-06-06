10 REM BRISCA - Spanish Card Game
20 REM Agon Light 2 / BBC BASIC V
30 REM 2 Players: You vs Computer
40 REM ============================
50
100 DIM sN$(4)
110 sN$(1)="Coins" : sN$(2)="Cups"
120 sN$(3)="Swords" : sN$(4)="Batons"
130
140 DIM rS$(10)
150 rS$(1)="A" : rS$(2)="2" : rS$(3)="3"
160 rS$(4)="4" : rS$(5)="5" : rS$(6)="6"
170 rS$(7)="7" : rS$(8)="J" : rS$(9)="Q"
180 rS$(10)="K"
190
200 DIM pts%(10)
210 pts%(1)=11 : pts%(2)=0 : pts%(3)=10
220 pts%(4)=0 : pts%(5)=0 : pts%(6)=0
230 pts%(7)=0 : pts%(8)=2 : pts%(9)=3
240 pts%(10)=4
250
260 DIM str%(10)
270 str%(1)=7 : str%(2)=-2 : str%(3)=6
280 str%(4)=-1 : str%(5)=0 : str%(6)=1
290 str%(7)=2 : str%(8)=3 : str%(9)=4
300 str%(10)=5
310
320 DIM dF%(40), dS%(40)
330 DIM pH%(3), cH%(3)
340 DIM tF%(2), tSu%(2)
350
360 REM ============================
370 REM TITLE SCREEN
380 REM ============================
390 MODE 0 : COLOUR 3 : CLS
400 PRINT "================================"
410 PRINT "  B R I S C A   for Agon"
420 PRINT "================================"
430 PRINT
440 PRINT "Ranks (high to low):"
450 PRINT "  A  3  K  Q  J  7  6  5  4  2"
460 PRINT
470 PRINT "Points: A=11  3=10  K=4  Q=3  J=2"
480 PRINT
490 PRINT "Trump beats any other suit."
500 PRINT "Highest of led suit wins otherwise."
510 PRINT
520 COLOUR 14 : PRINT "Press any key..."
530 q$=GET$ : CLS
540
550 REM ============================
560 REM NEW HAND - BUILD DECK
570 REM ============================
580 pSc%=0 : cSc%=0
590 idx%=0
600 FOR su%=1 TO 4
610   FOR fv%=1 TO 10
620     idx%=idx%+1
630     dF%(idx%)=fv%
640     dS%(idx%)=su%
650   NEXT fv%
660 NEXT su%
670
680 REM Shuffle (Fisher-Yates)
690 FOR i%=40 TO 2 STEP -1
700   j%=INT(RND(1)*i%)+1
710   tf%=dF%(i%) : ts%=dS%(i%)
720   dF%(i%)=dF%(j%) : dS%(i%)=dS%(j%)
730   dF%(j%)=tf% : dS%(j%)=ts%
740 NEXT i%
750
760 REM Deal: player gets cards 1-3, CPU gets 4-6
770 pH%(1)=1 : pH%(2)=2 : pH%(3)=3
780 cH%(1)=4 : cH%(2)=5 : cH%(3)=6
790
800 REM Card 7 is trump, deck draws start at 8
810 trF%=dF%(7) : trS%=dS%(7)
820 top%=8
830
840 ldr%=1 : trk%=0
850
860 REM ============================
870 REM TRICK LOOP
880 REM ============================
890 trk%=trk%+1
900
910 REM --- SHOW TRICK SCREEN ---
920 CLS
930 COLOUR 7 : PRINT "=== Trick ";trk%;" ==="
940 COLOUR 14 : PRINT "Trump: ";rS$(trF%);" of ";sN$(trS%)
950 PRINT
960 COLOUR 11 : PRINT "Your hand:"
970 COLOUR 3
980 IF pH%(1)>0 THEN PRINT "  1) ";rS$(dF%(pH%(1)));" of ";sN$(dS%(pH%(1)))
990 IF pH%(2)>0 THEN PRINT "  2) ";rS$(dF%(pH%(2)));" of ";sN$(dS%(pH%(2)))
1000 IF pH%(3)>0 THEN PRINT "  3) ";rS$(dF%(pH%(3)));" of ";sN$(dS%(pH%(3)))
1010 PRINT
1020
1030 REM --- DISPATCH BASED ON LEADER ---
1040 IF ldr%=1 THEN GOSUB 2000
1050 IF ldr%=2 THEN GOSUB 3000
1060
1070 REM --- SCORE THE TRICK ---
1080 tp%=pts%(tF%(1))+pts%(tF%(2))
1090 GOSUB 4000
1100
1110 REM Map winner to player/cpu
1120 pw%=0
1130 IF ldr%=1 AND winner%=1 THEN pw%=1
1140 IF ldr%=2 AND winner%=2 THEN pw%=1
1150
1160 IF pw%=1 THEN pSc%=pSc%+tp% : ldr%=1
1170 IF pw%=0 THEN cSc%=cSc%+tp% : ldr%=2
1180
1190 IF pw%=1 THEN COLOUR 10 : PRINT "YOU win the trick! (+";tp%;" pts)"
1200 IF pw%=0 THEN COLOUR 9 : PRINT "CPU wins the trick. (+";tp%;" pts)"
1210
1220 COLOUR 7 : PRINT "Score -> You:";pSc%;"  CPU:";cSc%
1230 COLOUR 14 : PRINT "Press any key..."
1240 q$=GET$
1250
1260 REM --- DRAW CARDS ---
1270 IF top%<=40 THEN GOSUB 5000
1280
1290 REM --- CHECK IF HANDS EMPTY ---
1300 pc%=0 : cc%=0
1310 IF pH%(1)>0 THEN pc%=pc%+1
1320 IF pH%(2)>0 THEN pc%=pc%+1
1330 IF pH%(3)>0 THEN pc%=pc%+1
1340 IF cH%(1)>0 THEN cc%=cc%+1
1350 IF cH%(2)>0 THEN cc%=cc%+1
1360 IF cH%(3)>0 THEN cc%=cc%+1
1370
1380 IF pc%>0 THEN GOTO 890
1390 IF cc%>0 THEN GOTO 890
1400
1410 REM ============================
1420 REM HAND OVER
1430 REM ============================
1440 CLS
1450 COLOUR 7 : PRINT "====== HAND OVER ======"
1460 COLOUR 3 : PRINT "Your score:     ";pSc%
1470 COLOUR 5 : PRINT "Computer score: ";cSc%
1480 COLOUR 7 : PRINT "========================"
1490 IF pSc%>cSc% THEN COLOUR 10 : PRINT "*** YOU WIN! ***"
1500 IF cSc%>pSc% THEN COLOUR 9 : PRINT "Computer wins."
1510 IF pSc%=cSc% THEN COLOUR 14 : PRINT "Tie! (60-60)"
1520 PRINT
1530 COLOUR 7 : PRINT "Play again? (Y/N)"
1540 q$=GET$
1550 IF q$="Y" OR q$="y" THEN GOTO 580
1560 COLOUR 3 : PRINT "Thanks for playing Brisca!"
1570 END
1580
1590 REM ============================
1600 REM SUB 2000: PLAYER LEADS
1610 REM ============================
2000 COLOUR 11 : PRINT "You lead. Choose slot (1-3):"
2010 GOSUB 6000
2020 pp%=pH%(pSlot%) : pH%(pSlot%)=0
2030 tF%(1)=dF%(pp%) : tSu%(1)=dS%(pp%)
2040 COLOUR 3 : PRINT "You played: ";rS$(tF%(1));" of ";sN$(tSu%(1))
2050 PRINT
2060 led%=tSu%(1)
2070 GOSUB 7000
2080 cp%=cH%(cSlot%) : cH%(cSlot%)=0
2090 tF%(2)=dF%(cp%) : tSu%(2)=dS%(cp%)
2100 COLOUR 5 : PRINT "CPU played: ";rS$(tF%(2));" of ";sN$(tSu%(2))
2110 PRINT
2120 RETURN
2130
2140 REM ============================
2150 REM SUB 3000: CPU LEADS
2160 REM ============================
3000 GOSUB 8000
3010 cp%=cH%(cSlot%) : cH%(cSlot%)=0
3020 tF%(1)=dF%(cp%) : tSu%(1)=dS%(cp%)
3030 led%=tSu%(1)
3040 COLOUR 5 : PRINT "CPU leads: ";rS$(tF%(1));" of ";sN$(tSu%(1))
3050 PRINT
3060 COLOUR 11 : PRINT "Your turn. Choose slot (1-3):"
3070 GOSUB 6000
3080 pp%=pH%(pSlot%) : pH%(pSlot%)=0
3090 tF%(2)=dF%(pp%) : tSu%(2)=dS%(pp%)
3100 COLOUR 3 : PRINT "You played: ";rS$(tF%(2));" of ";sN$(tSu%(2))
3110 PRINT
3120 RETURN
3130
3140 REM ============================
3150 REM SUB 4000: EVALUATE TRICK
3160 REM Returns winner%: 1=first card wins
3170 REM ============================
4000 f1%=tF%(1) : s1%=tSu%(1)
4010 f2%=tF%(2) : s2%=tSu%(2)
4020 winner%=1
4030 REM Both trump - compare strength
4040 IF s1%=trS% AND s2%=trS% THEN IF str%(f2%)>str%(f1%) THEN winner%=2
4050 IF s1%=trS% AND s2%=trS% THEN RETURN
4060 REM First is trump, second is not
4070 IF s1%=trS% THEN winner%=1 : RETURN
4080 REM Second is trump, first is not
4090 IF s2%=trS% THEN winner%=2 : RETURN
4100 REM No trump: same suit as led?
4110 IF s2%=s1% THEN IF str%(f2%)>str%(f1%) THEN winner%=2
4120 REM Different suit and no trump: first card (led) always wins
4130 RETURN
4140
4150 REM ============================
4160 REM SUB 5000: DRAW CARDS
4170 REM Winner draws first
4180 REM ============================
5000 IF pw%=1 THEN GOSUB 5200 : GOSUB 5300
5010 IF pw%=0 THEN GOSUB 5300 : GOSUB 5200
5020 RETURN
5030
5040 REM SUB 5200: Player draws one card
5200 IF top%>40 THEN RETURN
5210 IF pH%(1)=0 THEN pH%(1)=top% : top%=top%+1 : RETURN
5220 IF pH%(2)=0 THEN pH%(2)=top% : top%=top%+1 : RETURN
5230 IF pH%(3)=0 THEN pH%(3)=top% : top%=top%+1 : RETURN
5240 RETURN
5250
5260 REM SUB 5300: CPU draws one card
5300 IF top%>40 THEN RETURN
5310 IF cH%(1)=0 THEN cH%(1)=top% : top%=top%+1 : RETURN
5320 IF cH%(2)=0 THEN cH%(2)=top% : top%=top%+1 : RETURN
5330 IF cH%(3)=0 THEN cH%(3)=top% : top%=top%+1 : RETURN
5340 RETURN
5350
5360 REM ============================
5370 REM SUB 6000: PLAYER PICKS CARD
5380 REM Returns pSlot% (1-3, occupied)
5390 REM ============================
6000 pSlot%=0
6010 INPUT "  Slot (1-3): " ch$
6020 pSlot%=VAL(ch$)
6030 IF pSlot%<1 THEN GOTO 6010
6040 IF pSlot%>3 THEN GOTO 6010
6050 IF pH%(pSlot%)=0 THEN GOTO 6010
6060 RETURN
6070
6080 REM ============================
6090 REM SUB 7000: CPU RESPONDS
6100 REM Follow led suit if possible,
6110 REM else play lowest trump,
6120 REM else throw lowest card.
6130 REM ============================
7000 cSlot%=0
7010 REM Try to match led suit (play strongest)
7020 bestS%=-999
7030 IF cH%(1)>0 THEN IF dS%(cH%(1))=led% THEN IF str%(dF%(cH%(1)))>bestS% THEN bestS%=str%(dF%(cH%(1))) : cSlot%=1
7040 IF cH%(2)>0 THEN IF dS%(cH%(2))=led% THEN IF str%(dF%(cH%(2)))>bestS% THEN bestS%=str%(dF%(cH%(2))) : cSlot%=2
7050 IF cH%(3)>0 THEN IF dS%(cH%(3))=led% THEN IF str%(dF%(cH%(3)))>bestS% THEN bestS%=str%(dF%(cH%(3))) : cSlot%=3
7060 IF cSlot%>0 THEN RETURN
7070 REM No led suit - try lowest trump
7080 lowS%=999
7090 IF cH%(1)>0 THEN IF dS%(cH%(1))=trS% THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
7100 IF cH%(2)>0 THEN IF dS%(cH%(2))=trS% THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
7110 IF cH%(3)>0 THEN IF dS%(cH%(3))=trS% THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
7120 IF cSlot%>0 THEN RETURN
7130 REM No trump either - throw lowest card
7140 lowS%=999
7150 IF cH%(1)>0 THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
7160 IF cH%(2)>0 THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
7170 IF cH%(3)>0 THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
7180 RETURN
7190
7200 REM ============================
7210 REM SUB 8000: CPU LEADS
7220 REM Play highest non-trump card.
7230 REM If all trumps, play lowest.
7240 REM ============================
8000 cSlot%=0
8010 highS%=-999
8020 IF cH%(1)>0 THEN IF dS%(cH%(1))<>trS% THEN IF str%(dF%(cH%(1)))>highS% THEN highS%=str%(dF%(cH%(1))) : cSlot%=1
8030 IF cH%(2)>0 THEN IF dS%(cH%(2))<>trS% THEN IF str%(dF%(cH%(2)))>highS% THEN highS%=str%(dF%(cH%(2))) : cSlot%=2
8040 IF cH%(3)>0 THEN IF dS%(cH%(3))<>trS% THEN IF str%(dF%(cH%(3)))>highS% THEN highS%=str%(dF%(cH%(3))) : cSlot%=3
8050 IF cSlot%>0 THEN RETURN
8060 REM All trumps - play lowest
8070 lowS%=999
8080 IF cH%(1)>0 THEN IF str%(dF%(cH%(1)))<lowS% THEN lowS%=str%(dF%(cH%(1))) : cSlot%=1
8090 IF cH%(2)>0 THEN IF str%(dF%(cH%(2)))<lowS% THEN lowS%=str%(dF%(cH%(2))) : cSlot%=2
8100 IF cH%(3)>0 THEN IF str%(dF%(cH%(3)))<lowS% THEN lowS%=str%(dF%(cH%(3))) : cSlot%=3
8110 RETURN
