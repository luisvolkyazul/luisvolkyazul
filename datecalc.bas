10 REM DATE CALCULATOR FOR AGON LIGHT
20 REM Inspired by HP-12C date functions
30 REM Gregorian calendar, validates 1900-2099
40 DIM C(12)
50 C(0)=0:C(1)=31:C(2)=59:C(3)=90:C(4)=120:C(5)=151
60 C(6)=181:C(7)=212:C(8)=243:C(9)=273:C(10)=304:C(11)=334:C(12)=365
70 DIM DN$(6)
80 DN$(0)="Sunday":DN$(1)="Monday":DN$(2)="Tuesday":DN$(3)="Wednesday"
90 DN$(4)="Thursday":DN$(5)="Friday":DN$(6)="Saturday"
100 REM Main program
110 MODE 1
120 PRINT TAB(10,0);"DATE CALCULATOR"
130 PRINT TAB(10,1);"==============="
140 PRINT
150 REPEAT
160 PRINT "1. Days between dates"
170 PRINT "2. Add days to date"
180 PRINT "3. Day info (weekday, year day)"
190 PRINT "4. Quit"
200 INPUT "Choice (1-4): "; c$
210 c=VAL(c$)
220 CLS
230 IF c=1 THEN PROCdaysbetween
240 IF c=2 THEN PROCadddays
250 IF c=3 THEN PROCdayinfo
260 UNTIL c=4
270 END
280 DEF FNleap(y) = (y MOD 4 = 0 AND y MOD 100 <> 0) OR y MOD 400 = 0
290 DEF FNleapcount(y) = (y-1) DIV 4 - (y-1) DIV 100 + (y-1) DIV 400 - 460
300 DEF FNmonthdays(m,y) = C(m) - C(m-1) + (m=2)*FNleap(y)
310 DEF FNdays(y,m,d) = (y-1900)*365 + FNleapcount(y) + C(m-1) + d - 1 - (FNleap(y) AND m>2)
320 DEF FNdow(y,m,d) = (FNdays(y,m,d)+1) MOD 7
330 DEF FNdowname$(dow) = DN$(dow)
340 DEF FNpad2$(n) = RIGHT$(STR$(n+100),2)
350 DEF FNfmtdate$(y,m,d) = RIGHT$(STR$(y),4)+"-"+FNpad2$(m)+"-"+FNpad2$(d)
360 DEF PROCenterdate
370 REPEAT
380 INPUT "Year (YYYY): "; y$
390 Y=VAL(y$)
400 IF Y<1900 OR Y>2099 THEN PRINT "Year must be 1900-2099"
410 UNTIL Y>=1900 AND Y<=2099
420 REPEAT
430 INPUT "Month (1-12): "; m$
440 M=VAL(m$)
450 IF M<1 OR M>12 THEN PRINT "Month must be 1-12"
460 UNTIL M>=1 AND M<=12
470 REPEAT
480 INPUT "Day (1-31): "; d$
490 D=VAL(d$)
500 IF D<1 OR D>FNmonthdays(M,Y) THEN PRINT "Day out of range"
510 UNTIL D>=1 AND D<=FNmonthdays(M,Y)
520 ENDPROC
530 DEF PROCfromdays
540 yy=1900+DY DIV 365
550 t=FNdays(yy,1,1)
560 IF t<=DY THEN GOTO 600
570 yy=yy-1
580 t=FNdays(yy,1,1)
590 GOTO 560
600 d2=DY-t+1
610 mm=1
620 IF d2<=FNmonthdays(mm,yy) THEN GOTO 660
630 d2=d2-FNmonthdays(mm,yy)
640 mm=mm+1
650 GOTO 620
660 Y=yy:M=mm:D=d2
670 ENDPROC
680 DEF PROCdaysactual
690 n1=FNdays(Y1,M1,D1)
700 n2=FNdays(Y2,M2,D2)
710 rs$=STR$(ABS(n2-n1))
715 PRINT "Days (actual): ";rs$
720 ENDPROC
730 DEF PROCdays360
740 a1=D1:a2=D2
750 IF a1=31 THEN a1=30
760 IF (a2=31) AND (a1=30) THEN a2=30
770 rs$=STR$(ABS((Y2-Y1)*360+(M2-M1)*30+(a2-a1)))
775 PRINT "Days (30/360): ";rs$
780 ENDPROC
790 DEF PROCdaysbetween
800 PRINT "Days Between Dates"
810 PRINT "=================="
820 PRINT
830 PROCenterdate
840 Y1=Y:M1=M:D1=D
850 PROCenterdate
860 Y2=Y:M2=M:D2=D
870 INPUT "Actual (A) or 30/360 (B): "; b$
880 IF b$="A" OR b$="a" THEN PROCdaysactual
890 IF b$="B" OR b$="b" THEN PROCdays360
895 lg$="=== Days Between Dates ===":PROClog
896 lg$="Date 1: "+FNfmtdate$(Y1,M1,D1):PROClog
897 lg$="Date 2: "+FNfmtdate$(Y2,M2,D2):PROClog
898 IF b$="A" OR b$="a" THEN lg$="Basis: Actual":PROClog
899 IF b$="B" OR b$="b" THEN lg$="Basis: 30/360":PROClog
900 lg$="Result: "+rs$+" days":PROClog
901 lg$="---":PROClog
910 PRINT
915 PRINT "Press any key..."
920 a$=GET$
930 CLS
940 ENDPROC
950 DEF PROCadddays
960 PRINT "Add Days to Date"
970 PRINT "================"
980 PRINT
990 PROCenterdate
995 sy=Y:sm=M:sd=D
1000 INPUT "Days to add: "; od$
1010 od=VAL(od$)
1020 DY=FNdays(Y,M,D)+od
1030 PROCfromdays
1040 PRINT "Date: ";FNfmtdate$(Y,M,D)
1050 PRINT "Weekday: ";FNdowname$(FNdow(Y,M,D))
1055 lg$="=== Add Days to Date ===":PROClog
1056 lg$="Input date: "+FNfmtdate$(sy,sm,sd):PROClog
1057 lg$="Days to add: "+STR$(od):PROClog
1058 lg$="Result date: "+FNfmtdate$(Y,M,D):PROClog
1059 lg$="Weekday: "+FNdowname$(FNdow(Y,M,D)):PROClog
1060 lg$="---":PROClog
1065 PRINT
1070 PRINT "Press any key..."
1080 a$=GET$
1090 CLS
1100 ENDPROC
1110 DEF PROCdayinfo
1120 PRINT "Day Info"
1130 PRINT "========"
1140 PRINT
1150 PROCenterdate
1160 PRINT "Date: ";FNfmtdate$(Y,M,D)
1170 PRINT "Weekday: ";FNdowname$(FNdow(Y,M,D))
1180 doy=FNdays(Y,M,D)-FNdays(Y,1,1)+1
1190 PRINT "Day of year: ";doy
1195 lg$="=== Day Info ===":PROClog
1196 lg$="Date: "+FNfmtdate$(Y,M,D):PROClog
1197 lg$="Weekday: "+FNdowname$(FNdow(Y,M,D)):PROClog
1198 lg$="Day of year: "+STR$(doy):PROClog
1199 lg$="---":PROClog
1200 PRINT
1210 PRINT "Press any key..."
1220 a$=GET$
1230 CLS
1240 ENDPROC

1250 DEF PROClog
1251 ch=OPENUP("datecalc.log")
1252 IF ch=0 THEN ch=OPENOUT("datecalc.log")
1253 PTR#ch=EXT#ch
1254 PRINT#ch,lg$
1255 CLOSE#ch
1256 ENDPROC
