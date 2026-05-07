10 REM TVM Calculator for Agon Light 2 (BBC BASIC V)
20 REM Using REPEAT UNTIL, Procedures, Functions, File Output
30 MODE 0: REM Uncomment for 80x25 text mode (Agon Light 2 default)
35 REPEAT
37 CLS
40 PRINT "=== TIME VALUE OF MONEY CALCULATOR ==="
45 PRINT "(For entertainment purposes only)"
50 REM REPEAT
60   REPEAT
70     PROCmenu
80     INPUT "Enter choice (1-6): "; C
90     IF C<1 OR C>6 THEN PRINT "Invalid choice. Please enter 1-6."
100  UNTIL C>=1 AND C<=6
110  REM Set filename based on user choice
120  IF C=1 THEN filename$="fv_lumpsum.txt"
130  IF C=2 THEN filename$="pv_lumpsum.txt"
140  IF C=3 THEN filename$="fv_annuity.txt"
150  IF C=4 THEN filename$="pv_annuity.txt"
160  IF C=5 THEN filename$="pmt_annuity.txt"
170  IF C=6 THEN filename$="periods_lumpsum.txt"
180  F%=OPENOUT(filename$)
190  IF C=1 THEN PROCfvlump
200  IF C=2 THEN PROCpvlump
210  IF C=3 THEN PROCfvannuity
220  IF C=4 THEN PROCpvannuity
230  IF C=5 THEN PROCpmt
240  IF C=6 THEN PROCperiods
250  CLOSE #F%
260  PRINT "Results saved to "; filename$
270  REPEAT
280    INPUT "Another calculation? (Y/N): "; A$
290  UNTIL A$="Y" OR A$="y" OR A$="N" OR A$="n"
300 UNTIL A$="N" OR A$="n"
310 PRINT "Goodbye!"
320 END

3000 DEF PROCmenu
3010 PRINT ""
3020 PRINT "Select calculation:"
3030 PRINT "1. Future Value (Lump Sum)"
3040 PRINT "2. Present Value (Lump Sum)"
3050 PRINT "3. Future Value (Ordinary Annuity)"
3060 PRINT "4. Present Value (Ordinary Annuity)"
3070 PRINT "5. Payment (PMT) for Annuity"
3080 PRINT "6. Number of Periods (Lump Sum)"
3090 ENDPROC

4000 DEF PROCfvlump
4010 LOCAL PV, R, N, FV, line$
4020 PRINT "--- Future Value (Lump Sum) ---"
4030 INPUT "Present Value (PV): "; PV
4040 INPUT "Period Rate (r, e.g. 0.05 for 5%): "; R
4050 INPUT "Number of Periods (n): "; N
4060 FV = FNFVLump(PV, R, N)
4070 PRINT "Future Value: "; FNround(FV)
4080 REM Write formatted results to file
4090 PRINT #F%, "=== TVM CALCULATION REPORT ==="
4100 PRINT #F%, "(For entertainment purposes only)"
4110 PRINT #F%, "Calculation Type: Future Value (Lump Sum)"
4110 PRINT #F%, ""
4120 PRINT #F%, "Inputs:"
4130 line$ = "  Present Value (PV): " + FNround(PV)
4140 PRINT #F%, line$
4150 line$ = "  Period Rate (r): " + STR$(R)
4160 PRINT #F%, line$
4170 line$ = "  Number of Periods (n): " + STR$(N)
4180 PRINT #F%, line$
4190 PRINT #F%, ""
4200 PRINT #F%, "Output:"
4210 line$ = "  Future Value: " + FNround(FV)
4220 PRINT #F%, line$
4230 PRINT #F%, ""
4240 PRINT #F%, "=== END OF REPORT ==="
4250 ENDPROC

5000 DEF PROCpvlump
5010 LOCAL FV, R, N, PV, line$
5020 PRINT "--- Present Value (Lump Sum) ---"
5030 INPUT "Future Value (FV): "; FV
5040 INPUT "Period Rate (r): "; R
5050 INPUT "Number of Periods (n): "; N
5060 PV = FNPVLump(FV, R, N)
5070 PRINT "Present Value: "; FNround(PV)
5080 REM Write formatted results to file
5090 PRINT #F%, "=== TVM CALCULATION REPORT ==="
5100 PRINT #F%, "(For entertainment purposes only)"
5110 PRINT #F%, "Calculation Type: Present Value (Lump Sum)"
5110 PRINT #F%, ""
5120 PRINT #F%, "Inputs:"
5130 line$ = "  Future Value (FV): " + FNround(FV)
5140 PRINT #F%, line$
5150 line$ = "  Period Rate (r): " + STR$(R)
5160 PRINT #F%, line$
5170 line$ = "  Number of Periods (n): " + STR$(N)
5180 PRINT #F%, line$
5190 PRINT #F%, ""
5200 PRINT #F%, "Output:"
5210 line$ = "  Present Value: " + FNround(PV)
5220 PRINT #F%, line$
5230 PRINT #F%, ""
5240 PRINT #F%, "=== END OF REPORT ==="
5250 ENDPROC

6000 DEF PROCfvannuity
6010 LOCAL PMT, R, N, FV, line$
6020 PRINT "--- Future Value (Ordinary Annuity) ---"
6030 INPUT "Payment per Period (PMT): "; PMT
6040 INPUT "Period Rate (r): "; R
6050 INPUT "Number of Periods (n): "; N
6060 FV = FNFVAnnuity(PMT, R, N)
6070 PRINT "Annuity Future Value: "; FNround(FV)
6080 REM Write formatted results to file
6090 PRINT #F%, "=== TVM CALCULATION REPORT ==="
6100 PRINT #F%, "(For entertainment purposes only)"
6110 PRINT #F%, "Calculation Type: Future Value (Ordinary Annuity)"
6110 PRINT #F%, ""
6120 PRINT #F%, "Inputs:"
6130 line$ = "  Payment per Period (PMT): " + FNround(PMT)
6140 PRINT #F%, line$
6150 line$ = "  Period Rate (r): " + STR$(R)
6160 PRINT #F%, line$
6170 line$ = "  Number of Periods (n): " + STR$(N)
6180 PRINT #F%, line$
6190 PRINT #F%, ""
6200 PRINT #F%, "Output:"
6210 line$ = "  Annuity Future Value: " + FNround(FV)
6220 PRINT #F%, line$
6230 PRINT #F%, ""
6240 PRINT #F%, "=== END OF REPORT ==="
6250 ENDPROC

7000 DEF PROCpvannuity
7010 LOCAL PMT, R, N, PV, line$
7020 PRINT "--- Present Value (Ordinary Annuity) ---"
7030 INPUT "Payment per Period (PMT): "; PMT
7040 INPUT "Period Rate (r): "; R
7050 INPUT "Number of Periods (n): "; N
7060 PV = FNPVAnnuity(PMT, R, N)
7070 PRINT "Annuity Present Value: "; FNround(PV)
7080 REM Write formatted results to file
7090 PRINT #F%, "=== TVM CALCULATION REPORT ==="
7100 PRINT #F%, "(For entertainment purposes only)"
7110 PRINT #F%, "Calculation Type: Present Value (Ordinary Annuity)"
7110 PRINT #F%, ""
7120 PRINT #F%, "Inputs:"
7130 line$ = "  Payment per Period (PMT): " + FNround(PMT)
7140 PRINT #F%, line$
7150 line$ = "  Period Rate (r): " + STR$(R)
7160 PRINT #F%, line$
7170 line$ = "  Number of Periods (n): " + STR$(N)
7180 PRINT #F%, line$
7190 PRINT #F%, ""
7200 PRINT #F%, "Output:"
7210 line$ = "  Annuity Present Value: " + FNround(PV)
7220 PRINT #F%, line$
7230 PRINT #F%, ""
7240 PRINT #F%, "=== END OF REPORT ==="
7250 ENDPROC

8000 DEF PROCpmt
8010 LOCAL PV, R, N, PMT, line$
8020 PRINT "--- Payment (PMT) for Annuity ---"
8030 INPUT "Present Value (PV): "; PV
8040 INPUT "Period Rate (r): "; R
8050 INPUT "Number of Periods (n): "; N
8060 PMT = FNPMT(PV, R, N)
8070 PRINT "Payment per Period: "; FNround(PMT)
8080 REM Write formatted results to file
8090 PRINT #F%, "=== TVM CALCULATION REPORT ==="
8100 PRINT #F%, "(For entertainment purposes only)"
8110 PRINT #F%, "Calculation Type: Payment (PMT) for Annuity"
8110 PRINT #F%, ""
8120 PRINT #F%, "Inputs:"
8130 line$ = "  Present Value (PV): " + FNround(PV)
8140 PRINT #F%, line$
8150 line$ = "  Period Rate (r): " + STR$(R)
8160 PRINT #F%, line$
8170 line$ = "  Number of Periods (n): " + STR$(N)
8180 PRINT #F%, line$
8190 PRINT #F%, ""
8200 PRINT #F%, "Output:"
8210 line$ = "  Payment per Period: " + FNround(PMT)
8220 PRINT #F%, line$
8230 PRINT #F%, ""
8240 PRINT #F%, "=== END OF REPORT ==="
8250 ENDPROC

9000 DEF PROCperiods
9010 LOCAL PV, FV, R, N, line$
9020 PRINT "--- Number of Periods (Lump Sum) ---"
9030 INPUT "Present Value (PV): "; PV
9040 INPUT "Future Value (FV): "; FV
9050 INPUT "Period Rate (r): "; R
9060 PRINT #F%, "=== TVM CALCULATION REPORT ==="
9070 PRINT #F%, "(For entertainment purposes only)"
9080 PRINT #F%, "Calculation Type: Number of Periods (Lump Sum)"
9080 PRINT #F%, ""
9090 PRINT #F%, "Inputs:"
9100 line$ = "  Present Value (PV): " + FNround(PV)
9110 PRINT #F%, line$
9120 line$ = "  Future Value (FV): " + FNround(FV)
9130 PRINT #F%, line$
9140 line$ = "  Period Rate (r): " + STR$(R)
9150 PRINT #F%, line$
9160 IF R=0 THEN
9170   PRINT "Error: Rate (r) cannot be 0 for period calculation."
9180   PRINT #F%, ""
9190   PRINT #F%, "Error: Rate (r) cannot be 0 for period calculation."
9200 ELSE
9210   N = FNPeriods(PV, FV, R)
9220   PRINT "Number of Periods: "; N
9230   PRINT #F%, ""
9240   PRINT #F%, "Output:"
9250   line$ = "  Number of Periods: " + FNround(N)
9260   PRINT #F%, line$
9270 ENDIF
9280 PRINT #F%, ""
9290 PRINT #F%, "=== END OF REPORT ==="
9300 ENDPROC

10000 DEF FNFVLump(PV, R, N) = PV * (1 + R) ^ N

11000 DEF FNPVLump(FV, R, N) = FV / (1 + R) ^ N

12000 DEF FNFVAnnuity(PMT, R, N)
12010 LOCAL FV
12020 IF R=0 THEN FV = PMT * N ELSE FV = PMT * ((1 + R) ^ N - 1) / R
12030 = FV

13000 DEF FNPVAnnuity(PMT, R, N)
13010 LOCAL PV
13020 IF R=0 THEN PV = PMT * N ELSE PV = PMT * (1 - (1 + R) ^ (-N)) / R
13030 = PV

14000 DEF FNPMT(PV, R, N)
14010 LOCAL PMT
14020 IF R=0 THEN PMT = PV / N ELSE PMT = PV * R / (1 - (1 + R) ^ (-N))
14030 = PMT

15000 DEF FNPeriods(PV, FV, R)
15010 = LOG(FV / PV) / LOG(1 + R)

16000 DEF FNround(x)
16010 LOCAL s$, i%
16020 s$ = STR$(x)
16030 i% = INSTR(s$, ".")
16040 IF i% = 0 THEN = s$ + ".00"
16050 IF LEN(s$) - i% < 2 THEN = s$ + "0"
16060 IF LEN(s$) - i% > 2 THEN = LEFT$(s$, i% + 2)
16070 = s$
