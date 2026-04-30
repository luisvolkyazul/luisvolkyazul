   10 REM Cursor movement for Agon Light 2
   20 MODE 24
   25 VDU 17 14: REM SET THE FOREGROUND COLOR TO 14
   27 VDU 23, 1, 0: REM 0=HIDE THE CURSOR; 1=SHOW THE CURSOR; 2=MAKE CURSOR STEADY; 3=MAKE CURSOR FLASH
   30 CLS
   40 x=40:y=32
   45 VDU 23, 64, 153, 189, 219, 126, 36, 60, 36, 36: REM REDIFINE THE ASTERISK CHARACTER
   50 PRINT TAB(x,y) "@";
   60 K=INKEY(10)
   70 IF K=27 END
   80 old_x=x:old_y=y
   90 IF K=8 x=x-1
  100 IF K=21 x=x+1
  110 IF K=10 y=y+1
  120 IF K=11 y=y-1
  130 IF x<0 x=0
  140 IF x>79 x=79
  150 IF y<0 y=0
  160 IF y>63 y=63
  170 IF old_x<>x OR old_y<>y THEN PRINT TAB(old_x,old_y) " ";:PRINT TAB(x,y) "@";
  180 GOTO 60
