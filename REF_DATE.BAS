    1 CLS: REM REFORMAT DATE FROM DD-MM-YYYY TO YYYY-MM-DD
    5 time$ = TIME$
   10 PRINT MID$(time$,12,4)+"-"+MID$(time$,9,2)+"-"+MID$(time$,6,2)
