    1 MODE 27
    2 REM STUDY OF GRAPHIC COORDINATES TO DRAW A LEAF
    5 CLS: REM LEAF.BAS
    7 GCOL 0,25
   10 cx=650:cy=900:s=1
   15 REM Top of leaf then drawing to the right
   20 MOVE cx,       cy+20: PRINTTAB(36,2)"(";cx;",";cy+20;")"
   30 DRAW cx+40*s,  cy-40*s
   50 DRAW cx+120*s, cy-30*s: PRINTTAB(49,4)"(";cx+120;",";cy-30;")"
   60 DRAW cx+100*s, cy-90*s
   70 DRAW cx+170*s, cy-80*s: PRINTTAB(52,6)"(";cx+170;",";cy-80;")"
   80 DRAW cx+130*s, cy-150*s
   90 DRAW cx+190*s, cy-170*s: PRINTTAB(53,9)"(";cx+190;",";cy-170;")"
  100 DRAW cx+140*s, cy-220*s
  110 DRAW cx+80*s, cy-260*s: PRINTTAB(47,12)"(";cx+80;",";cy-260;")"
  115 PRINTTAB(36,12)"(";cx;",";cy-240;")"
  120 DRAW cx,      cy-240*s: REM CENTER BOTTOM
  130 DRAW cx+190*s, cy-170*s
  140 MOVE cx,      cy-240*s
  150 DRAW cx+170*s, cy-80*s
  160 MOVE cx,      cy-240*s
  170 DRAW cx+120*s, cy-30*s
  180 MOVE cx,      cy-240*s
  190 DRAW cx,       cy+20
  200 MOVE cx,      cy-240*s
  210 DRAW cx-80*s, cy-260*s: PRINTTAB(25,12)"(";cx-80;",";cy-260;")"
  220 DRAW cx-140*s, cy-220*s
  230 DRAW cx-190*s, cy-170*s: PRINTTAB(19,9)"(";cx-190;",";cy-170;")"
  240 DRAW cx-130*s, cy-150*s
  250 DRAW cx-170*s, cy-80*s: PRINTTAB(20,6)"(";cx-170;",";cy-80;")"
  260 DRAW cx-100*s, cy-90*s
  270 DRAW cx-120*s, cy-30*s: PRINTTAB(23,4)"(";cx-120;",";cy-30;")"
  280 DRAW cx-40*s,  cy-40*s
  290 DRAW cx,       cy+20
  300 MOVE cx,      cy-240*s
  310 DRAW cx-190*s, cy-170*s
  320 MOVE cx,      cy-240*s
  330 DRAW cx-170*s, cy-80*s
  340 MOVE cx,      cy-240*s
  350 DRAW cx-120*s, cy-30*s
