    5 CLS
   10 REM Military to 12-hour live CLOCK
   20 REPEAT
   30   t$ = MID$(TIME$,17,8)
   40   h% = VAL(LEFT$(t$,2))
   50   IF h% = 0 THEN h12 = 12 : a$ = "AM" ELSE IF h% < 12 THEN h12 = h% : a$ = "AM" ELSE IF h% = 12 THEN h12 = 12 : a$ = "PM" ELSE h12 = h% - 12 : a$ = "PM"
   60   hs$ = FNz(h12)
   70   PRINT CHR$(13);"Time: ";hs$;MID$(t$,3,6);" ";a$;"   ";
   80   WAIT 100
   90 UNTIL FALSE
  100 DEF FNz(n)
  110 IF n < 10 THEN
  120   = "0" + STR$(n)
  130 ELSE
  140   = STR$(n)
  150 ENDIF
  160 ENDFN
