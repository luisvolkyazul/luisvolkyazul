   10 MODE 8
   20 REM ACCENT_MAP.BAS
   21 REM Dumps CHR$() codes 128-255 in pages of 15 so we can visually
   22 REM identify which byte values render as which Spanish accented
   23 REM character in the Agon Light 2's active font.
   24 REM
   25 REM Already known from ACCENT_TEST.BAS (Test 2, Latin-1 CHR$ codes):
   26 REM   CHR$(243) = correct o-acute (o)
   27 REM   CHR$(241) = correct n-tilde (n)
   28 REM   CHR$(233) = WRONG - does not render as e-acute
   29 REM This dump finds working codes for: a-acute e-acute i-acute u-acute
   30 REM Aacute Eacute Iacute Oacute Uacute Ntilde inv-question inv-exclaim
   40 start=128
   50 REPEAT
   60   CLS
   70   last=start+14
   80   IF last>255 THEN last=255
   90   PRINT "CODES "; start; " TO "; last
  100   PRINT "===================="
  110   FOR c=start TO last
  120     PRINT c; " = "; CHR$(c)
  130   NEXT c
  140   PRINT
  150   PRINT "Press a key for next page..."
  160   k=GET
  170   start=start+15
  180 UNTIL start>255
  190 PRINT "Done. Report the code number(s) that show:"
  200 PRINT "a-acute, e-acute, i-acute, u-acute (lowercase),"
  210 PRINT "A E I O U-acute (uppercase), N-tilde (uppercase),"
  220 PRINT "inverted question mark, inverted exclamation mark."
  230 END
