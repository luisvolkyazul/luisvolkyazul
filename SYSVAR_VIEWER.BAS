   10 REM MOS SysVars (System State Variables) Viewer for Agon Light 2
   15 REM https://agonplatform.github.io/agon-docs/BBC-BASIC-for-Agon/?h=oscli#accessing-the-mos-sysvars
   17 REM https://agonplatform.github.io/agon-docs/mos/API/#sysvars
   20 CLS
   30 PRINT "MOS SysVars (System State Variables) Viewer for";'"the Agon Light 2 Microcomputer"
   35 PRINT STRING$(10,"-=*=-")
   40 PRINT
   50 DEF FN_s(o%):L%=o%:A%=&A0:=USR(&FFF4)AND&FF
   60 DEF FN_w(o%):=FN_s(o%)+FN_s(o%+1)*256
   70 PRINT "time:";FN_s(0);FN_s(1);FN_s(2);FN_s(3)
   80 PRINT' "vpd_flags:";FN_s(4)
   90 PRINT' "keyascii:";FN_s(5);''"mods:";FN_s(6)
  100 PRINT' "cursor:";FN_s(7);",";FN_s(8)
  110 PRINT' "scrpixel R,B,G:";", ";FN_s(&A);", ";FN_s(&B);", ";FN_s(&C)
  120 PRINT' "audio ch:";FN_s(&D);" ok:";FN_s(&E)
  130 PRINT' "scr ";FN_w(&F);"x";FN_w(&11);" cols:";FN_s(&13);" rows:";FN_s(&14)
  140 PRINT' "colours:";FN_s(&15);" mode:";FN_s(&27)
  150 PRINT' "rtc:";FN_s(&1A);"/";FN_s(&1B);"/";FN_s(&1C);" ";FN_s(&1D);":";FN_s(&1E);":";FN_s(&1F)
  160 PRINT' "kbd delay:";FN_w(&22);"ms rate:";FN_w(&24);"ms led:";FN_s(&26)
  170 PRINT' "mouse X:";FN_w(&29);" Y:";FN_w(&2B);" btns:";FN_s(&2D);" wheel:";FN_s(&2E)
  190 PRINT
  192 PRINT STRING$(10,"-=*=-")
  195 PRINT"BBC BASIC for: ";:OSCLI("VERSION"):PRINT
  200 END
