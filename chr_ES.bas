   10 MODE 8
   20 REM CHRISTIAN_AFFIRMATIONS_ES.BAS (Spanish version)
   21 REM Accented chars built via CHR$() only - see docs/superpowers
   22 PROC_Setup
   23 PROC_ShowAffirmation
   24 r=RND(5):IF r=1 THEN PROC_DrawTree(7,300,650,0,100) ELSE IF r=2 THEN PROC_DrawFernIFS ELSE IF r=3 THEN PROC_DrawMapleLeaf ELSE IF r=4 THEN PROC_DrawAnchor ELSE PROC_DrawTaperedTree
   25 PROC_ExitToBASIC
   26 END
   29 DEF PROC_Setup
   30 W% = FN_GETBYTE_VDP(&13)
   40 H% = FN_GETBYTE_VDP(&14)
   50 C% = FN_GETBYTE_VDP(&15)
   55 DBLH$ = CHR$(141)
   56 FLSH$ = CHR$(136)
   60 BG%=128+(RND(C%+1)-1)
   70 FG%=RND(C%+1)-1
   80 IF FG% + 128 = BG% THEN FG%=FG% + 5
   90 COLOUR BG%:COLOUR FG%:CLS
   95 ENDPROC
   97 DEF PROC_ShowAffirmation
   98 header$ = "Afirmaci" + CHR$(243) + "n del D" + CHR$(237) + "a"
  100 PRINTTAB((W%-LEN(header$))/2,1)header$
  110 i=RND(365)-1
  111 RESTORE 910
  112 FOR I% = 0 TO i
  113   READ AFFIRMATION$, VERSE$
  114 NEXT I%
  115 AFFIRMATION$ = FN_Accentize$(AFFIRMATION$) : VERSE$ = FN_Accentize$(VERSE$)
  460 split% = INSTR(AFFIRMATION$, " ", LEN(AFFIRMATION$)/3)
  490 left_text_1$ = LEFT$(AFFIRMATION$, split%)
  500 mid_text_2$ = MID$(AFFIRMATION$, split% + 1)
  510 split_2 = INSTR(mid_text_2$, " ", LEN(mid_text_2$)/2)
  515 mid_text_2a$ = LEFT$(mid_text_2$, split_2)
  520 right_text_3$ = MID$(mid_text_2$, split_2 + 1)
  525 COLOUR (FG%+8) MOD (C%+1)
  526 PRINT TAB((W%-LEN(left_text_1$))/2,3);left_text_1$
  527 PRINT TAB((W%-LEN(mid_text_2a$))/2,4);mid_text_2a$
  528 PRINT TAB((W%-LEN(right_text_3$))/2,5);right_text_3$
  529 COLOUR FG%
  530 PRINT TAB((W%-13)/2,7)"Inspirado en:"
  531 PRINT TAB((W%-LEN(VERSE$))/2,8);VERSE$
  532 X=GET
  533 MOVE 650,0:VDU 23, 1, 0
  535 ENDPROC
  536 :
  538 DEF PROC_ExitToBASIC
  539 KEY = GET
  540 end_text$ = CHR$(161) + "LISTO PARA APRENDER AGON!":end_text_length = LEN(end_text$)
  541 MODE 8:COLOUR 128 + 4:COLOUR 9:VDU 23, 1, 1:CLS:PRINTTAB((W%-end_text_length)/2,1) end_text$':COLOUR 2
  542 ENDPROC
  543 :
  550 REM GET SYSTEM VARIABLES
  560 DEF FN_GETBYTE_VDP(V%)
  570 A% = &A0
  580 L% = V%
  590 = USR(&FFF4)
  600 :
  601 REM TREE
  602 REM Sourced from
  603 REM https://youtu.be/EQrnlK37Qho?si=2tOtH_Lpx6kiC4mq&t=372
  604 REM Uncomment line 125 for colour version
  605 :
  610 REM ------------RECURSIVE TREE------------
  620 REM    BY ANDY FANDANGO @PIXEL_FANDANGO
  630 :
  640 REM MODE 20
  650 REM TIME=0
  660 REM MOVE 0,500
  670 REM PROC_DrawTree(7,300,500,0,100)
  680 REM @%=&0002020A
  690 REM PRINT "TIME TAKEN: "; TIME/100
  700 REM @%=0
  710 END
  715 :
  720 DEF PROC_DrawTree(i,x,y,a,l)
  725 GCOL 0,RND(16)
  730 da=RND(9)*0.1
  732 IF i > 5 DRAW y,x+2 ELSE IF i > 3 DRAW y,x+1 ELSE DRAW y,x
  734 IF i > 5 DRAW y,x-2 ELSE IF i > 3 DRAW y,x-1 ELSE DRAW y,x
  740 REM DRAW y,x
  750 IF i=0 ENDPROC
  760 PROC_DrawTree(i-1,x+RND(l)*COS(a-da),y+l*SIN(a-da),a-da,l*.9)
  770 MOVE y,x
  780 PROC_DrawTree(i-1,x+l*COS(a+da),y+RND(l)*SIN(a+da),a+da,l*.9)
  790 ENDPROC
  792 :
  794 DEF PROC_DrawFernIFS
  796 LOCAL i,r,x,y,x1,y1,sx,sy
  798 x=0:y=0
  800 VDU 23,1,0;0;0;0;
  802 GCOL 0,2
  804 FOR i=1 TO 5000
  806   r=RND(100)
  808   IF r=1 THEN x1=0:y1=0.16*y ELSE IF r<=86 THEN x1=0.85*x+0.04*y:y1=-0.04*x+0.85*y+1.6 ELSE IF r<=93 THEN x1=0.2*x-0.26*y:y1=0.23*x+0.22*y+1.6 ELSE x1=-0.15*x+0.28*y:y1=0.26*x+0.24*y+0.44
  810   x=x1:y=y1
  812   sx=620+x*65
  814   sy=220+y*48
  816   PLOT 69,sx,sy
  818 NEXT
  820 VDU 23,1,1;0;0;0;
  822 ENDPROC
  830 DEF PROC_DrawMapleLeaf
  831 LOCAL cx,cy,s
  832 cx=650:cy=500:s=1
  833 GCOL 0,1
  834 REM Top of leaf then drawing to the right
  835 MOVE cx, cy+20
  836 DRAW cx+40*s, cy-40*s
  837 DRAW cx+120*s, cy-30*s
  838 DRAW cx+100*s, cy-90*s
  839 DRAW cx+170*s, cy-80*s
  840 DRAW cx+130*s, cy-150*s
  841 DRAW cx+190*s, cy-170*s
  842 DRAW cx+140*s, cy-220*s
  843 DRAW cx+80*s, cy-260*s
  844 DRAW cx, cy-240*s: REM CENTER BOTTOM
  845 REM Drawing from center bottom to tips of leaf on right side
  846 DRAW cx+190*s, cy-170*s
  847 MOVE cx, cy-240*s
  848 DRAW cx+170*s, cy-80*s
  849 MOVE cx, cy-240*s
  850 DRAW cx+120*s, cy-30*s
  851 MOVE cx, cy-240*s
  852 DRAW cx, cy+20
  853 REM Drawing from center bottom to the left and upwards
  854 MOVE cx, cy-240*s
  855 DRAW cx-80*s, cy-260*s
  856 DRAW cx-140*s, cy-220*s
  857 DRAW cx-190*s, cy-170*s
  858 DRAW cx-130*s, cy-150*s
  859 DRAW cx-170*s, cy-80*s
  860 DRAW cx-100*s, cy-90*s
  861 DRAW cx-120*s, cy-30*s
  862 DRAW cx-40*s, cy-40*s
  863 DRAW cx, cy+20
  864 REM Drawing from center bottom to tips of leaf on left side
  865 MOVE cx, cy-240*s
  866 DRAW cx-190*s, cy-170*s
  867 MOVE cx, cy-240*s
  868 DRAW cx-170*s, cy-80*s
  869 MOVE cx, cy-240*s
  870 DRAW cx-120*s, cy-30*s: MOVE cx, cy-240*s: DRAW cx, cy-290*s
  871 VDU 23,1,1;0;0;0;
  872 ENDPROC
  873 :
  874 :
  900 REM DATA statements: affirmation text, Bible verse reference
910 DATA "Dios me ama con amor eterno.", "Jerem`ias 31:3"
920 DATA "Fui creado de manera maravillosa y admirable.", "Salmo 139:14"
930 DATA "El Se`nor es mi pastor; nada me faltar`a.", "Salmo 23:1"
940 DATA "Todo lo puedo en Cristo que me fortalece.", "Filipenses 4:13"
950 DATA "Dios no me ha dado esp`iritu de cobard`ia, sino de poder, amor y dominio propio.", "2 Timoteo 1:7"
960 DATA "Soy la justicia de Dios en Cristo Jes`us.", "2 Corintios 5:21"
970 DATA "El Se`nor va delante de m`i y estar`a conmigo.", "Deuteronomio 31:8"
980 DATA "Soy m`as que vencedor por medio de aquel que me am`o.", "Romanos 8:37"
990 DATA "Dios suple todas mis necesidades conforme a sus riquezas en gloria.", "Filipenses 4:19"
1000 DATA "Ninguna arma forjada contra m`i prosperar`a.", "Isa`ias 54:17"
1010 DATA "Estoy escondido con Cristo en Dios.", "Colosenses 3:3"
1020 DATA "El gozo del Se`nor es mi fortaleza.", "Nehem`ias 8:10"
1030 DATA "Dios es mi refugio y fortaleza, mi pronto auxilio en las tribulaciones.", "Salmo 46:1"
1040 DATA "Fui creado a imagen y semejanza de Dios.", "G`enesis 1:27"
1050 DATA "Cristo me ha redimido de la maldici`on de la ley.", "G`alatas 3:13"
1060 DATA "Soy la luz del mundo.", "Mateo 5:14"
1070 DATA "Dios tiene planes para prosperarme y no para da`narme.", "Jerem`ias 29:11"
1080 DATA "Camino por fe, no por vista.", "2 Corintios 5:7"
1090 DATA "El Se`nor mi Dios est`a conmigo dondequiera que voy.", "Josu`e 1:9"
1100 DATA "Soy una nueva criatura en Cristo; las cosas viejas pasaron.", "2 Corintios 5:17"
1110 DATA "La gracia de Dios me basta.", "2 Corintios 12:9"
1120 DATA "Estoy sellado con el Esp`iritu Santo de la promesa.", "Efesios 1:13"
1130 DATA "El Se`nor es mi luz y mi salvaci`on; `?a qui`en temer`e?", "Salmo 27:1"
1140 DATA "Estoy arraigado y cimentado en amor.", "Efesios 3:17"
1150 DATA "Dios ha dado orden a sus `angeles acerca de m`i.", "Salmo 91:11"
1160 DATA "He sido liberado del pecado y de la muerte.", "Romanos 8:2"
1170 DATA "Soy la sal de la tierra.", "Mateo 5:13"
1180 DATA "Dios hace que todas las cosas ayuden a bien en mi vida.", "Romanos 8:28"
1190 DATA "Soy aceptado en el Amado.", "Efesios 1:6"
1200 DATA "Mi Dios pelear`a por m`i.", "`Exodo 14:14"
1210 DATA "Habito al abrigo del Alt`isimo.", "Salmo 91:1"
1220 DATA "Soy escogido de Dios, santo y amado.", "Colosenses 3:12"
1230 DATA "La paz de Dios guarda mi coraz`on y mi mente.", "Filipenses 4:7"
1240 DATA "Dios me ha dado toda bendici`on espiritual en los lugares celestiales.", "Efesios 1:3"
1250 DATA "Soy heredero de Dios y coheredero con Cristo.", "Romanos 8:17"
1260 DATA "El Se`nor guarda mi salida y mi entrada.", "Salmo 121:8"
1270 DATA "Tengo la mente de Cristo.", "1 Corintios 2:16"
1280 DATA "Soy redimido por la preciosa sangre de Cristo.", "1 Pedro 1:19"
1290 DATA "La misericordia de Dios hacia m`i es nueva cada ma`nana.", "Lamentaciones 3:23"
1300 DATA "Soy fuerte en el Se`nor y en el poder de su fuerza.", "Efesios 6:10"
1310 DATA "El Se`nor me bendice y me guarda.", "N`umeros 6:24"
1320 DATA "Soy templo del Esp`iritu Santo.", "1 Corintios 6:19"
1330 DATA "He sido librado del poder de las tinieblas.", "Colosenses 1:13"
1340 DATA "Dios renueva mis fuerzas como las del `aguila.", "Isa`ias 40:31"
1350 DATA "Soy perdonado de todos mis pecados por medio de su sangre.", "Efesios 1:7"
1360 DATA "El Se`nor est`a de mi lado; no temer`e lo que el hombre me pueda hacer.", "Salmo 118:6"
1370 DATA "Soy hijo de Dios, nacido de su Esp`iritu.", "Juan 1:12"
1380 DATA "Dios ha puesto un c`antico nuevo en mi boca.", "Salmo 40:3"
1390 DATA "Prosigo hacia la meta para ganar el premio del supremo llamamiento.", "Filipenses 3:14"
1400 DATA "Estoy vestido de fuerza y honor.", "Proverbios 31:25"
1410 DATA "Mis pasos son ordenados por el Se`nor.", "Salmo 37:23"
1420 DATA "Estoy completo en Cristo.", "Colosenses 2:10"
1430 DATA "Dios es fiel y no permitir`a que sea tentado m`as de lo que puedo soportar.", "1 Corintios 10:13"
1440 DATA "Tengo vida eterna por la fe en Cristo.", "Juan 3:16"
1450 DATA "El Se`nor me sostiene con su diestra de justicia.", "Isa`ias 41:10"
1460 DATA "Soy cabeza y no cola.", "Deuteronomio 28:13"
1470 DATA "Dios me da vida juntamente con Cristo.", "Efesios 2:5"
1480 DATA "Se me ha dado dominio sobre las obras de sus manos.", "Salmo 8:6"
1490 DATA "Fui comprado por precio y por eso pertenezco a Dios.", "1 Corintios 6:20"
1500 DATA "Mayor es el que est`a en m`i que el que est`a en el mundo.", "1 Juan 4:4"
1510 DATA "No me falta ning`un bien porque busco al Se`nor.", "Salmo 34:10"
1520 DATA "Soy guardado por el poder de Dios mediante la fe.", "1 Pedro 1:5"
1530 DATA "Mi coraz`on est`a firme y no temer`e.", "Salmo 112:8"
1540 DATA "Soy conciudadano de los santos y miembro de la familia de Dios.", "Efesios 2:19"
1550 DATA "Dios no me ha olvidado; me ha grabado en las palmas de sus manos.", "Isa`ias 49:16"
1560 DATA "Tengo buen `animo porque Cristo ha vencido al mundo.", "Juan 16:33"
1570 DATA "El Se`nor me da descanso de todos mis enemigos.", "Deuteronomio 12:10"
1580 DATA "He sido trasladado al reino del Hijo de su amor.", "Colosenses 1:13"
1590 DATA "Dios sacia de bien mi boca y renueva mi juventud.", "Salmo 103:5"
1600 DATA "Soy firme y constante, abundando siempre en la obra del Se`nor.", "1 Corintios 15:58"
1610 DATA "El Se`nor es bueno conmigo, fortaleza en el d`ia de la angustia.", "Nah`um 1:7"
1620 DATA "He sido resucitado y sentado en los lugares celestiales en Cristo.", "Efesios 2:6"
1630 DATA "Recibo la corona de vida porque amo al Se`nor.", "Santiago 1:12"
1640 DATA "El amor de Dios ha sido derramado en mi coraz`on por el Esp`iritu Santo.", "Romanos 5:5"
1650 DATA "Estoy crucificado con Cristo; sin embargo, vivo.", "G`alatas 2:20"
1660 DATA "El Se`nor hace prosperar mi camino y me da buen `exito.", "Josu`e 1:8"
1670 DATA "Invoco al Se`nor y `el me responde.", "Salmo 86:7"
1680 DATA "Soy un p`ampano que permanece en la vid verdadera, llevando mucho fruto.", "Juan 15:5"
1690 DATA "Dios me da sabidur`ia abundantemente cuando pido con fe.", "Santiago 1:5"
1700 DATA "Tengo confianza en que el Se`nor completar`a la buena obra que comenz`o en m`i.", "Filipenses 1:6"
1710 DATA "El Se`nor es mi porci`on, por eso en `el esperar`e.", "Lamentaciones 3:24"
1720 DATA "He sido lavado, santificado y justificado en el nombre de Jes`us.", "1 Corintios 6:11"
1730 DATA "Me deleito en la ley del Se`nor y prospero en todo lo que hago.", "Salmo 1:2-3"
1740 DATA "El Se`nor sana todas mis dolencias.", "Salmo 103:3"
1750 DATA "Soy un vaso de honra, santificado y `util para el Maestro.", "2 Timoteo 2:21"
1760 DATA "Dios me protege y ninguna plaga se acerca a mi morada.", "Salmo 91:10"
1770 DATA "Soy embajador de Cristo.", "2 Corintios 5:20"
1780 DATA "Dios viste a los humildes con salvaci`on.", "Salmo 149:4"
1790 DATA "Estoy plantado en la casa del Se`nor y florecer`e.", "Salmo 92:13"
1800 DATA "El Se`nor rescata mi vida de la destrucci`on y me corona de misericordia.", "Salmo 103:4"
1810 DATA "Soy pueblo adquirido por Dios, generaci`on escogida, real sacerdocio.", "1 Pedro 2:9"
1820 DATA "Dios me da gracia ante los ojos de los hombres.", "Proverbios 3:4"
1830 DATA "Soy hechura de Dios, creado en Cristo Jes`us para buenas obras.", "Efesios 2:10"
1840 DATA "El Se`nor convierte mi lamento en baile.", "Salmo 30:11"
1850 DATA "Tengo paz con Dios por medio de mi Se`nor Jesucristo.", "Romanos 5:1"
1860 DATA "El Esp`iritu de Dios habita en m`i y da vida a mi cuerpo.", "Romanos 8:11"
1870 DATA "Soy transformado mediante la renovaci`on de mi entendimiento.", "Romanos 12:2"
1880 DATA "Mi nombre est`a escrito en el libro de la vida del Cordero.", "Apocalipsis 21:27"
1890 DATA "Llevo fruto en toda buena obra y crezco en el conocimiento de Dios.", "Colosenses 1:10"
1900 DATA "Soy guardado en perfecta paz porque mi mente conf`ia en Dios.", "Isa`ias 26:3"
1910 DATA "Dios puede hacer much`isimo m`as de lo que pido o entiendo.", "Efesios 3:20"
1920 DATA "El Se`nor guarda mi alma.", "Salmo 121:7"
1930 DATA "Tengo toda la armadura de Dios y resisto al enemigo.", "Efesios 6:11"
1940 DATA "Soy amado con un amor del cual nada me puede separar.", "Romanos 8:38-39"
1950 DATA "Dios es mi pronto auxilio y no ser`e movido.", "Salmo 46:5"
1960 DATA "Conf`io en el Se`nor con todo mi coraz`on y `el endereza mis caminos.", "Proverbios 3:5-6"
1970 DATA "El Se`nor es fiel para afirmarme y guardarme.", "2 Tesalonicenses 3:3"
1980 DATA "He obtenido herencia en Cristo.", "Efesios 1:11"
1990 DATA "Dios me da hermosura en lugar de ceniza y aceite de gozo en lugar de luto.", "Isa`ias 61:3"
2000 DATA "Soy sostenido por la diestra de Dios.", "Isa`ias 41:10"
2010 DATA "No morir`e, sino que vivir`e y contar`e las obras del Se`nor.", "Salmo 118:17"
2020 DATA "Soy nacido de Dios y el maligno no me toca.", "1 Juan 5:18"
2030 DATA "El Se`nor es mi roca, mi fortaleza y mi libertador.", "Salmo 18:2"
2040 DATA "Soy justificado gratuitamente por su gracia mediante la redenci`on en Cristo.", "Romanos 3:24"
2050 DATA "Dios me revela lo profundo y lo escondido.", "Daniel 2:22"
2060 DATA "Soy librado de toda obra mala y preservado para su reino.", "2 Timoteo 4:18"
2070 DATA "Dios es mi Padre y clamo: `!Abba, Padre!", "Romanos 8:15"
2080 DATA "Soy saciado en abundancia de la grosura de la casa de Dios.", "Salmo 36:8"
2090 DATA "El Se`nor me concede el sue`no, pues lo da a sus amados.", "Salmo 127:2"
2100 DATA "Estoy libre de condenaci`on porque estoy en Cristo Jes`us.", "Romanos 8:1"
2110 DATA "El Se`nor pelea mis batallas y yo guardo silencio.", "`Exodo 14:14"
2120 DATA "Soy guardado por el poder de Dios.", "1 Pedro 1:5"
2130 DATA "Dios unge mi cabeza con aceite y mi copa est`a rebosando.", "Salmo 23:5"
2140 DATA "Se me han dado las llaves del reino de los cielos.", "Mateo 16:19"
2150 DATA "El Se`nor me da sabidur`ia y conocimiento.", "Proverbios 2:6"
2160 DATA "Soy lavado en la sangre del Cordero.", "Apocalipsis 1:5"
2170 DATA "Dios hace que triunfe siempre en Cristo.", "2 Corintios 2:14"
2180 DATA "Soy rico en fe y heredero del reino que Dios prometi`o.", "Santiago 2:5"
2190 DATA "El Se`nor est`a cerca de todos los que lo invocan de verdad.", "Salmo 145:18"
2200 DATA "He vencido al mundo por medio de mi fe.", "1 Juan 5:4"
2210 DATA "Dios me ha dado esp`iritu de sabidur`ia y de revelaci`on.", "Efesios 1:17"
2220 DATA "Estoy plantado junto a corrientes de aguas y mi hoja no caer`a.", "Salmo 1:3"
2230 DATA "El Se`nor me hace descansar en verdes pastos.", "Salmo 23:2"
2240 DATA "Estoy edificado sobre el fundamento de Cristo, la principal piedra angular.", "Efesios 2:20"
2250 DATA "Dios me guarda en todos mis caminos.", "Salmo 91:11"
2260 DATA "Soy santificado mediante la ofrenda del cuerpo de Cristo.", "Hebreos 10:10"
2270 DATA "El Esp`iritu del Se`nor est`a sobre m`i y me ha ungido.", "Isa`ias 61:1"
2280 DATA "El Se`nor da esfuerzo al cansado y multiplica las fuerzas al que no tiene ninguna.", "Isa`ias 40:29"
2290 DATA "Tengo las grand`isimas y preciosas promesas de Dios.", "2 Pedro 1:4"
2300 DATA "Soy lleno de toda la plenitud de Dios.", "Efesios 3:19"
2310 DATA "El Se`nor conforta mi alma.", "Salmo 23:3"
2320 DATA "Proclamo el evangelio sin temor, porque es poder de Dios.", "Romanos 1:16"
2330 DATA "Dios se acuerda de m`i seg`un su misericordia.", "Salmo 25:7"
2340 DATA "Estoy vivo para Dios mediante Jesucristo nuestro Se`nor.", "Romanos 6:11"
2350 DATA "Dios me gu`ia por sendas de justicia por amor de su nombre.", "Salmo 23:3"
2360 DATA "He recibido abundancia de gracia y el don de la justicia.", "Romanos 5:17"
2370 DATA "El Se`nor se deleita en m`i y ha puesto su amor sobre m`i.", "Salmo 18:19"
2380 DATA "Soy firme en la fe, resistiendo al enemigo.", "1 Pedro 5:9"
2390 DATA "Dios me guarda de caer y me presenta sin mancha delante de su gloria.", "Judas 1:24"
2400 DATA "Se me ha dado vida eterna y nadie me arrebatar`a de la mano de Dios.", "Juan 10:28"
2410 DATA "El Se`nor oye mi voz y mi s`uplica.", "Salmo 116:1"
2420 DATA "Soy fortalecido con todo poder conforme a su gloriosa potencia.", "Colosenses 1:11"
2430 DATA "Espero en el Se`nor y `el renueva mis fuerzas.", "Isa`ias 40:31"
2440 DATA "El Se`nor es mi ayudador; no temer`e lo que me pueda hacer el hombre.", "Hebreos 13:6"
2450 DATA "Soy llamado conforme a su prop`osito y `el hace que todo ayude a bien.", "Romanos 8:28"
2460 DATA "Dios me da manto de alegr`ia en lugar del esp`iritu angustiado.", "Isa`ias 61:3"
2470 DATA "Soy amigo de Dios.", "Juan 15:15"
2480 DATA "El Se`nor me concede las peticiones de mi coraz`on porque me deleito en `el.", "Salmo 37:4"
2490 DATA "Estoy enteramente capacitado para toda buena obra.", "2 Timoteo 3:17"
2500 DATA "Dios es mi sombra a mi mano derecha.", "Salmo 121:5"
2510 DATA "Soy sanado por las llagas de Jesucristo.", "Isa`ias 53:5"
2520 DATA "El Se`nor me cubre con sus plumas y bajo sus alas conf`io.", "Salmo 91:4"
2530 DATA "Soy bendito en mi canasta y en mi artesa.", "Deuteronomio 28:5"
2540 DATA "La palabra de Dios es l`ampara a mis pies y lumbrera a mi camino.", "Salmo 119:105"
2550 DATA "Soy vencedor por la sangre del Cordero y la palabra de mi testimonio.", "Apocalipsis 12:11"
2560 DATA "El Se`nor me concede larga vida y me muestra su salvaci`on.", "Salmo 91:16"
2570 DATA "He obtenido entrada por la fe a esta gracia.", "Romanos 5:2"
2580 DATA "Dios no es autor de confusi`on sino de paz en mi vida.", "1 Corintios 14:33"
2590 DATA "Soy confirmado y ungido por Dios.", "2 Corintios 1:21"
2600 DATA "El Se`nor guarda el camino de sus santos.", "Proverbios 2:8"
2610 DATA "He sido adoptado en la familia de Dios.", "Efesios 1:5"
2620 DATA "Dios pone mis l`agrimas en su redoma y atiende mis angustias.", "Salmo 56:8"
2630 DATA "Soy llamado para heredar bendici`on.", "1 Pedro 3:9"
2640 DATA "Dios no escatim`o a su propio Hijo y con `el me da tambi`en todas las cosas.", "Romanos 8:32"
2650 DATA "Soy edificado como casa espiritual y sacerdocio santo.", "1 Pedro 2:5"
2660 DATA "El Se`nor sacia mi alma que tiene sed y llena de bien mi alma que tiene hambre.", "Salmo 107:9"
2670 DATA "He alcanzado misericordia y ahora soy pueblo de Dios.", "1 Pedro 2:10"
2680 DATA "Dios me da doble honra en lugar de mi pasada afrenta.", "Isa`ias 61:7"
2690 DATA "Soy la ni`na de los ojos de Dios.", "Zacar`ias 2:8"
2700 DATA "El Se`nor ha puesto mis pies en lugar espacioso.", "Salmo 18:19"
2710 DATA "He sido acercado a Dios por la sangre de Cristo.", "Efesios 2:13"
2720 DATA "Dios pelea contra los que pelean contra m`i.", "Salmo 35:1"
2730 DATA "Guardo el pacto de Dios y recibo su misericordia constante.", "Salmo 103:18"
2740 DATA "El Se`nor es la fortaleza de mi vida.", "Salmo 27:1"
2750 DATA "Soy lavado y emblanquecido como la nieve.", "Isa`ias 1:18"
2760 DATA "Dios abre para m`i r`ios en las alturas y fuentes en medio de los valles.", "Isa`ias 41:18"
2770 DATA "Tengo seguridad y acceso confiado a Dios mediante la fe en Cristo.", "Efesios 3:12"
2780 DATA "El Se`nor hace que aun mis enemigos est`en en paz conmigo.", "Proverbios 16:7"
2790 DATA "Soy protegido por la fidelidad de Dios.", "Salmo 91:4"
2800 DATA "Dios ha puesto su Esp`iritu dentro de m`i y hace que ande en sus estatutos.", "Ezequiel 36:27"
2810 DATA "Crezco en la gracia y el conocimiento de mi Se`nor Jesucristo.", "2 Pedro 3:18"
2820 DATA "El Se`nor ha hecho para m`i camino en el desierto y r`ios en la soledad.", "Isa`ias 43:19"
2830 DATA "He recibido el esp`iritu de adopci`on, no de esclavitud para volver al temor.", "Romanos 8:15"
2840 DATA "Estoy sometido a Dios y el diablo huye de m`i.", "Santiago 4:7"
2850 DATA "El Se`nor me ha vestido con ropas de salvaci`on.", "Isa`ias 61:10"
2860 DATA "Soy llamado, escogido y fiel.", "Apocalipsis 17:14"
2870 DATA "Dios se complace en mi prosperidad.", "Salmo 35:27"
2880 DATA "Soy atrevido como un le`on por mi justicia en Cristo.", "Proverbios 28:1"
2890 DATA "El Se`nor me tranquiliza con su amor y se regocija sobre m`i con c`anticos.", "Sofon`ias 3:17"
2900 DATA "Tengo las arras del Esp`iritu en mi coraz`on.", "2 Corintios 1:22"
2910 DATA "Dios acampa a su `angel alrededor de m`i porque le temo.", "Salmo 34:7"
2920 DATA "El Se`nor me rescata de todo lazo del enemigo.", "Salmo 124:7"
2930 DATA "Se me ha dado todo lo que concierne a la vida y a la piedad.", "2 Pedro 1:3"
2940 DATA "Dios ordena bendici`on sobre mis graneros y todo lo que emprendo.", "Deuteronomio 28:8"
2950 DATA "No soy conformado a este mundo, sino transformado por Dios.", "Romanos 12:2"
2960 DATA "El Se`nor afirma mis pensamientos cuando encomiendo mis obras a `el.", "Proverbios 16:3"
2970 DATA "Mi oraci`on puede mucho porque soy justo por medio de Cristo.", "Santiago 5:16"
2980 DATA "Dios me gu`ia junto a aguas de reposo y conforta mi alma.", "Salmo 23:2-3"
2990 DATA "Soy enriquecido en Cristo en toda palabra y todo conocimiento.", "1 Corintios 1:5"
3000 DATA "El Se`nor hace que toda gracia abunde hacia m`i.", "2 Corintios 9:8"
3010 DATA "Estoy arraigado, edificado y confirmado en Cristo.", "Colosenses 2:7"
3020 DATA "Dios perfecciona lo que me concierne.", "Salmo 138:8"
3030 DATA "Soy reconciliado con Dios mediante la muerte de su Hijo.", "Romanos 5:10"
3040 DATA "El Se`nor da a sus amados el sue`no y el descanso.", "Salmo 127:2"
3050 DATA "Me he vestido del nuevo hombre, renovado en conocimiento.", "Colosenses 3:10"
3060 DATA "Dios afirma mi coraz`on irreprensible en santidad.", "1 Tesalonicenses 3:13"
3070 DATA "Abundo en esperanza por el poder del Esp`iritu Santo.", "Romanos 15:13"
3080 DATA "El Se`nor me pone a salvo de los que me acosan.", "Salmo 12:5"
3090 DATA "Dios me unge con `oleo de alegr`ia.", "Salmo 45:7"
3100 DATA "Estoy fundado y firme, sin moverme de la esperanza del evangelio.", "Colosenses 1:23"
3110 DATA "El Se`nor sana mi coraz`on quebrantado y venda mis heridas.", "Salmo 147:3"
3120 DATA "Tengo la certeza de la salvaci`on y las arras del Esp`iritu.", "Efesios 1:14"
3130 DATA "Dios aleja de m`i mis pecados tanto como est`a lejos el oriente del occidente.", "Salmo 103:12"
3140 DATA "Soy fruct`ifero y me multiplico, bendecido por la mano de Dios.", "G`enesis 1:28"
3150 DATA "El Se`nor se r`ie de mis enemigos y los tiene en poco por mi causa.", "Salmo 2:4"
3160 DATA "Soy fuerte y valiente porque Dios est`a conmigo.", "Josu`e 1:9"
3170 DATA "Dios escribe sus leyes en mi coraz`on y en mi mente.", "Hebreos 10:16"
3180 DATA "Soy participante de la naturaleza divina.", "2 Pedro 1:4"
3190 DATA "El Se`nor endereza mis veredas cuando lo reconozco.", "Proverbios 3:6"
3200 DATA "He sido apartado y santificado por Dios el Padre.", "Judas 1:1"
3210 DATA "Dios es mi sol y escudo; `el da gracia y gloria.", "Salmo 84:11"
3220 DATA "Estoy seguro en Cristo, escondido con `el en Dios.", "Colosenses 3:3"
3230 DATA "El Se`nor me alegra con su obra y triunfo en ella.", "Salmo 92:4"
3240 DATA "He sido hecho participante de Cristo.", "Hebreos 3:14"
3250 DATA "Dios me da lengua de sabios para hablar palabra a tiempo.", "Isa`ias 50:4"
3260 DATA "Soy precioso ante los ojos de Dios y `el me ama.", "Isa`ias 43:4"
3270 DATA "El Se`nor va conmigo por el fuego y el agua hacia un lugar de abundancia.", "Salmo 66:12"
3280 DATA "Tengo redenci`on por su sangre y el perd`on de los pecados.", "Colosenses 1:14"
3290 DATA "Dios hermosea a los humildes con salvaci`on.", "Salmo 149:4"
3300 DATA "Soy ministro de reconciliaci`on, portador de buenas nuevas.", "2 Corintios 5:18"
3310 DATA "El Se`nor frustra los planes del malvado en mi contra.", "Proverbios 15:26"
3320 DATA "He sido purificado de toda maldad por su fidelidad.", "1 Juan 1:9"
3330 DATA "Dios cambia mi cautiverio y restaura mi suerte.", "Salmo 126:4"
3340 DATA "El Se`nor honra a los que lo honran.", "1 Samuel 2:30"
3350 DATA "Tengo la certeza de que todo lo que pida en oraci`on, creyendo, lo recibir`e.", "Mateo 21:22"
3360 DATA "Dios me guarda de la angustia y me rodea de c`anticos de liberaci`on.", "Salmo 32:7"
3370 DATA "Soy fiel administrador de la multiforme gracia de Dios.", "1 Pedro 4:10"
3380 DATA "El Se`nor endereza para m`i lo torcido y allana lo `aspero.", "Isa`ias 40:4"
3390 DATA "He sido sentado juntamente en los lugares celestiales en Cristo Jes`us.", "Efesios 2:6"
3400 DATA "Dios ensancha mi coraz`on para correr por el camino de sus mandamientos.", "Salmo 119:32"
3410 DATA "El Se`nor me da las naciones como herencia.", "Salmo 2:8"
3420 DATA "Tengo un edificio de Dios, casa no hecha de manos, eterna en los cielos.", "2 Corintios 5:1"
3430 DATA "Dios me guarda como la ni`na de sus ojos y me esconde bajo la sombra de sus alas.", "Salmo 17:8"
3440 DATA "No temo malas noticias porque mi coraz`on est`a firme, confiado en el Se`nor.", "Salmo 112:7"
3450 DATA "El Se`nor me abre su buen tesoro y bendice toda la obra de mis manos.", "Deuteronomio 28:12"
3460 DATA "He recibido la promesa del Esp`iritu mediante la fe.", "G`alatas 3:14"
3470 DATA "Dios es mi recompensa sobremanera grande.", "G`enesis 15:1"
3480 DATA "El Se`nor me oye y me libra de todas mis angustias.", "Salmo 34:6"
3490 DATA "Se me ha dado esp`iritu de poder, amor y dominio propio.", "2 Timoteo 1:7"
3500 DATA "He resucitado con Cristo y busco las cosas de arriba.", "Colosenses 3:1"
3510 DATA "El Se`nor hace resplandecer su rostro sobre m`i y tiene de m`i misericordia.", "N`umeros 6:25"
3520 DATA "He recibido misericordia y hallado gracia para el oportuno socorro.", "Hebreos 4:16"
3530 DATA "Dios inclina mi o`ido a la sabidur`ia y mi coraz`on al entendimiento.", "Proverbios 2:2"
3540 DATA "Reino en vida por medio de Jesucristo.", "Romanos 5:17"
3550 DATA "El Se`nor bendice mi pan y mi agua y aparta de m`i toda enfermedad.", "`Exodo 23:25"
3560 DATA "He sido bautizado en Cristo y me he vestido de Cristo.", "G`alatas 3:27"
3570 DATA "Estoy firme en la libertad con que Cristo me hizo libre.", "G`alatas 5:1"
3580 DATA "El Se`nor adiestra mis manos para la batalla y mis dedos para la guerra.", "Salmo 144:1"
3590 DATA "He recibido la promesa de la herencia eterna mediante su muerte.", "Hebreos 9:15"
3600 DATA "Dios me da la lluvia temprana y la tard`ia a su tiempo.", "Joel 2:23"
3610 DATA "El Se`nor est`a en medio de m`i, poderoso, `el salva.", "Sofon`ias 3:17"
3620 DATA "Se me han concedido preciosas y grand`isimas promesas de Dios.", "2 Pedro 1:4"
3630 DATA "Dios abre mis ojos para ver las maravillas de su ley.", "Salmo 119:18"
3640 DATA "Soy plant`io del Se`nor, para que `el sea glorificado.", "Isa`ias 61:3"
3650 DATA "El Se`nor ha puesto un esp`iritu nuevo dentro de m`i.", "Ezequiel 36:26"
3660 DATA "He alcanzado el favor del Se`nor y estoy lleno de bienes.", "Proverbios 8:35"
3670 DATA "Dios es excelso, pero mira al humilde como yo.", "Salmo 138:6"
3680 DATA "Soy soldado de Jesucristo, soportando penurias por su nombre.", "2 Timoteo 2:3"
3690 DATA "El Se`nor va delante de m`i y endereza los lugares torcidos.", "Isa`ias 45:2"
3700 DATA "Tengo un sumo sacerdote que se compadece de mis debilidades.", "Hebreos 4:15"
3710 DATA "Dios se acuerda de su pacto y me muestra gran bondad.", "G`enesis 24:27"
3720 DATA "Estoy lleno de frutos de justicia para la gloria de Dios.", "Filipenses 1:11"
3730 DATA "El Se`nor me colma de beneficios cada d`ia.", "Salmo 68:19"
3740 DATA "Tengo las arras de mi herencia hasta la redenci`on de la posesi`on adquirida.", "Efesios 1:14"
3750 DATA "Dios me libra del lazo del cazador y de la peste destructora.", "Salmo 91:3"
3760 DATA "Fui escogido antes de la fundaci`on del mundo para ser santo y sin mancha.", "Efesios 1:4"
3770 DATA "El Se`nor sacia de bien mis deseos.", "Salmo 103:5"
3780 DATA "Tengo libertad para entrar al Lugar Sant`isimo por la sangre de Jes`us.", "Hebreos 10:19"
3790 DATA "Dios hace que toda gracia abunde en m`i para que abunde en toda buena obra.", "2 Corintios 9:8"
3800 DATA "Soy colaborador de Dios.", "1 Corintios 3:9"
3810 DATA "El Se`nor me alegra conforme a los d`ias que me afligi`o.", "Salmo 90:15"
3820 DATA "Se me ha dado autoridad para hollar serpientes y escorpiones.", "Lucas 10:19"
3830 DATA "Dios es mi confianza y guarda mi pie de ser apresado.", "Proverbios 3:26"
3840 DATA "Voy de gloria en gloria por el Esp`iritu del Se`nor.", "2 Corintios 3:18"
3850 DATA "El Se`nor es un muro de fuego alrededor de m`i y gloria en medio de m`i.", "Zacar`ias 2:5"
3860 DATA "Me he vestido de la armadura de luz.", "Romanos 13:12"
3870 DATA "Dios me da pastores seg`un su coraz`on que me alimentan con conocimiento.", "Jerem`ias 3:15"
3880 DATA "Estoy completo en Dios, quien es la cabeza de todo principado y potestad.", "Colosenses 2:10"
3890 DATA "El Se`nor est`a a mi diestra, no ser`e conmovido.", "Salmo 16:8"
3900 DATA "He sido guardado irreprensible para la venida de nuestro Se`nor Jesucristo.", "1 Tesalonicenses 5:23"
3910 DATA "Dios me ense`na provechosamente y me gu`ia por el camino que debo seguir.", "Isa`ias 48:17"
3920 DATA "Soy hijo de Dios por la fe en Cristo Jes`us.", "G`alatas 3:26"
3930 DATA "El Se`nor es la porci`on de mi copa y sostiene mi suerte.", "Salmo 16:5"
3940 DATA "He sido purificado como se prueba y aprueba la plata.", "Salmo 66:10"
3950 DATA "Dios me ha dado tesoro en el cielo que ning`un ladr`on puede robar.", "Lucas 12:33"
3960 DATA "Soy plantado en justicia y establecido lejos de la opresi`on.", "Isa`ias 54:14"
3970 DATA "Tengo la paz que sobrepasa todo entendimiento, guardando mi coraz`on.", "Filipenses 4:7"
3980 DATA "Dios env`ia su palabra y me sana.", "Salmo 107:20"
3990 DATA "Soy guardado en la mano de Dios y nadie me puede arrebatar.", "Juan 10:29"
4000 DATA "El Se`nor me da esp`iritu de sabidur`ia y de entendimiento.", "Isa`ias 11:2"
4010 DATA "He aprendido a contentarme cualquiera que sea mi situaci`on.", "Filipenses 4:11"
4020 DATA "Dios es fiel para santificarme por entero, cuerpo, alma y esp`iritu.", "1 Tesalonicenses 5:23"
4030 DATA "Espero en el Se`nor y `el es bueno conmigo.", "Lamentaciones 3:25"
4040 DATA "El Se`nor me recompensa el doble por mi aflicci`on pasada.", "Isa`ias 61:7"
4050 DATA "Tengo una esperanza segura y firme, ancla del alma.", "Hebreos 6:19"
4060 DATA "Dios me saca del lodo cenagoso y pone mis pies sobre una roca.", "Salmo 40:2"
4070 DATA "Soy llamado a libertad en Cristo y sirvo a otros por amor.", "G`alatas 5:13"
4080 DATA "El Se`nor va conmigo; no me dejar`a ni me desamparar`a.", "Deuteronomio 31:6"
4090 DATA "Se me ha dado una herencia incorruptible reservada en los cielos.", "1 Pedro 1:4"
4100 DATA "Dios es mi alegr`ia y mi gozo sobremanera.", "Salmo 43:4"
4110 DATA "Soy transformado en la misma imagen de Cristo de gloria en gloria.", "2 Corintios 3:18"
4120 DATA "El Se`nor es fiel y justo para limpiarme de toda maldad.", "1 Juan 1:9"
4130 DATA "Tengo la certeza de ver la bondad del Se`nor en la tierra de los vivientes.", "Salmo 27:13"
4140 DATA "Dios corona mi a`no con sus bienes y sus caminos destilan abundancia.", "Salmo 65:11"
4150 DATA "He sido predestinado a ser conforme a la imagen de su Hijo.", "Romanos 8:29"
4160 DATA "El Se`nor me consuela en toda mi tribulaci`on.", "2 Corintios 1:4"
4170 DATA "Soy conocido de Dios y he llegado a conocerlo.", "G`alatas 4:9"
4180 DATA "El Se`nor hace mis pies como de cierva y me hace andar en las alturas.", "Habacuc 3:19"
4190 DATA "He sido hecho rey y sacerdote para Dios.", "Apocalipsis 1:6"
4200 DATA "Dios me sacia de larga vida y me muestra su salvaci`on.", "Salmo 91:16"
4210 DATA "He sido trasladado de las tinieblas a su luz admirable.", "1 Pedro 2:9"
4220 DATA "El Se`nor me recompensa en p`ublico cuando oro a `el en secreto.", "Mateo 6:6"
4230 DATA "Soy justificado por su sangre y salvado de la ira por medio de `el.", "Romanos 5:9"
4240 DATA "Dios me da c`anticos en la noche y me llena de alegr`ia.", "Job 35:10"
4250 DATA "Soy sellado para el d`ia de la redenci`on.", "Efesios 4:30"
4260 DATA "El Se`nor hace que herede la tierra y more en ella.", "Salmo 37:29"
4270 DATA "Tengo la victoria que vence al mundo: mi fe.", "1 Juan 5:4"
4280 DATA "Dios habla paz a m`i, su santo, y no me deja volver a la insensatez.", "Salmo 85:8"
4290 DATA "Estoy confirmado en la fe y rebosando de gratitud.", "Colosenses 2:7"
4300 DATA "El Se`nor levanta mi cabeza sobre mis enemigos alrededor de m`i.", "Salmo 27:6"
4310 DATA "Se me ha concedido conocer los misterios del reino de Dios.", "Lucas 8:10"
4320 DATA "Dios bendice mi entrada y mi salida.", "Deuteronomio 28:6"
4330 DATA "Crezco en aquel que es la cabeza, es decir, Cristo.", "Efesios 4:15"
4340 DATA "El Se`nor me libra de todos mis temores.", "Salmo 34:4"
4350 DATA "Tengo la esperanza de gloria, Cristo habitando en m`i.", "Colosenses 1:27"
4360 DATA "Dios obra en m`i as`i el querer como el hacer conforme a su voluntad.", "Filipenses 2:13"
4370 DATA "Soy heredero conforme a la esperanza de la vida eterna.", "Tito 3:7"
4380 DATA "El Se`nor me alegra con sus obras; triunfo en las obras de sus manos.", "Salmo 92:4"
4390 DATA "He sido hecho participante de su santidad.", "Hebreos 12:10"
4400 DATA "Dios me da lengua de sabios y despierta mi o`ido ma`nana tras ma`nana.", "Isa`ias 50:4"
4410 DATA "Crezco para ser un templo santo en el Se`nor.", "Efesios 2:21"
4420 DATA "El Se`nor me ense`na sus estatutos y medito en sus maravillas.", "Salmo 119:27"
4430 DATA "He sido librado de la ley del pecado y de la muerte.", "Romanos 8:2"
4440 DATA "Dios abre las ventanas de los cielos sobre m`i y derrama bendici`on abundante.", "Malaqu`ias 3:10"
4450 DATA "Soy plantado y regado por Dios y `el da el crecimiento.", "1 Corintios 3:7"
4460 DATA "El Se`nor me guarda de todo mal y guarda mi alma.", "Salmo 121:7"
4470 DATA "Tengo una esperanza viva mediante la resurrecci`on de Jesucristo.", "1 Pedro 1:3"
4480 DATA "Dios es mi gloria y el que levanta mi cabeza.", "Salmo 3:3"
4490 DATA "Echo toda mi ansiedad sobre `el, porque `el tiene cuidado de m`i.", "1 Pedro 5:7"
4500 DATA "El Se`nor se goza sobre m`i con c`anticos y se alegra por m`i con gran alegr`ia.", "Sofon`ias 3:17"
4510 DATA "He sido escogido para llevar fruto y que mi fruto permanezca.", "Juan 15:16"
4520 DATA "Dios env`ia su misericordia de d`ia y su c`antico est`a conmigo de noche.", "Salmo 42:8"
4530 DATA "Estoy rodeado por Dios como los montes rodean a Jerusal`en.", "Salmo 125:2"
4540 DATA "El Se`nor me ha grabado en las palmas de sus manos; mis muros est`an siempre delante de `el.", "Isa`ias 49:16"
4550 DATA "Bendecir`e al Se`nor en todo tiempo; su alabanza estar`a de continuo en mi boca.", "Salmo 34:1"
4551 :
 4560 DEF PROC_DrawAnchor
 4561 LOCAL cx,cy,s
 4562 REM ================================================
 4563 REM  PROC_DrawAnchor - Draws a Christian anchor
 4564 REM ================================================
 4565 REM  BBC BASIC: Y increases UPWARD, (0,0) = bottom-left
 4566 REM
 4567 REM  Parameters (change line 4589):
 4568 REM    cx  = X center of anchor  (default: 640)
 4569 REM    cy  = Y center of anchor  (default: 450)
 4570 REM    s   = scale factor        (default: 1)
 4571 REM
 4572 REM  Anchor parts:
 4573 REM    Eye     - octagonal ring at top
 4574 REM    Stock   - horizontal crossbar near top
 4575 REM    Shaft   - long vertical bar
 4576 REM    Crown   - bottom of shaft, arms join here
 4577 REM    Arms    - sweep outward and upward from crown
 4578 REM    Flukes  - arrow tips at ends of arms
 4579 REM
 4580 REM  Key Y values (relative to cy):
 4581 REM    Eye center:    cy + 200
 4582 REM    Stock:         cy + 100
 4583 REM    Shaft top:     cy + 180 (eye bottom)
 4584 REM    Crown:         cy - 180
 4585 REM    Arm low:       cy - 200
 4586 REM    Fluke tips:    cy - 60
 4587 REM ================================================
 4588 REM ----Centered in drawing area below text----
 4589 cx=640:cy=450:s=1
 4590 VDU 23,1,0;0;0;0;
 4591 GCOL 0,1
 4592 REM ----EYE (octagonal ring at top)----
 4593 REM Octagon approximating a circle centered at cx, cy+200
 4594 MOVE cx,     cy+220*s
 4595 DRAW cx+14*s, cy+214*s
 4596 DRAW cx+20*s, cy+200*s
 4597 DRAW cx+14*s, cy+186*s
 4598 DRAW cx,     cy+180*s
 4599 DRAW cx-14*s, cy+186*s
 4600 DRAW cx-20*s, cy+200*s
 4601 DRAW cx-14*s, cy+214*s
 4602 DRAW cx,     cy+220*s
 4603 REM ----STOCK (horizontal crossbar)----
 4604 MOVE cx-60*s, cy+100*s
 4605 DRAW cx+60*s, cy+100*s
 4606 MOVE cx-60*s, cy+105*s
 4607 DRAW cx-60*s, cy+95*s
 4608 MOVE cx+60*s, cy+105*s
 4609 DRAW cx+60*s, cy+95*s
 4610 REM ----SHAFT (vertical bar)----
 4611 REM From bottom of eye down to the crown
 4612 MOVE cx, cy+180*s
 4613 DRAW cx, cy-180*s
 4614 REM ----CROWN REINFORCEMENT----
 4615 MOVE cx-15*s, cy-180*s
 4616 DRAW cx+15*s, cy-180*s
 4617 REM ----LEFT ARM----
 4618 REM Sweeps outward and upward from crown to left fluke
 4619 MOVE cx, cy-180*s
 4620 DRAW cx-40*s, cy-200*s
 4621 DRAW cx-80*s, cy-160*s
 4622 DRAW cx-120*s, cy-80*s
 4623 REM ----LEFT FLUKE----
 4624 MOVE cx-120*s, cy-80*s
 4625 DRAW cx-135*s, cy-60*s
 4626 DRAW cx-105*s, cy-95*s
 4627 DRAW cx-120*s, cy-80*s
 4628 REM ----RIGHT ARM----
 4629 REM Sweeps outward and upward from crown to right fluke
 4630 MOVE cx, cy-180*s
 4631 DRAW cx+40*s, cy-200*s
 4632 DRAW cx+80*s, cy-160*s
 4633 DRAW cx+120*s, cy-80*s
 4634 REM ----RIGHT FLUKE----
 4635 MOVE cx+120*s, cy-80*s
 4636 DRAW cx+135*s, cy-60*s
 4637 DRAW cx+105*s, cy-95*s
 4638 DRAW cx+120*s, cy-80*s
 4639 VDU 23,1,1;0;0;0;
 4640 ENDPROC
 4641 :
 4642 REM ============================================================
 4643 REM  PROC_DrawTaperedTree
 4644 REM  Tapered recursive tree from TREE_1.BAS
 4645 REM  Draws in mode 8 (640x480). Trunk is thick and tapers by
 4646 REM  half at each branch level. Branches recurse to depth 7.
 4647 REM  Uses only MOVE/DRAW - no PLOT fill commands.
 4648 REM ============================================================
 4649 DEF PROC_DrawTaperedTree
 4650 LOCAL TrX,TrY,TrLen,TrThk,TrDepth,TrSpread,TrJitter,TrShrink,TrSteps
 4651 VDU 23,1,0;0;0;0;
 4652 GCOL 0,29
 4653 TrX      = 640
 4654 TrY      = 31
 4655 TrLen    = 210
 4656 TrThk    = 70
 4657 TrDepth  = 7
 4658 TrSpread = INT(RND(10)+25)
 4659 TrJitter = 10
 4660 TrShrink = 0.68
 4661 TrSteps  = 20
 4662 PROCbranch(TrX,TrY,0,TrLen,TrThk,INT(TrThk/2),TrDepth,TrSpread,TrJitter,TrShrink,TrSteps)
 4663 VDU 23,1,1;0;0;0;
 4664 ENDPROC
 4665 :
 4666 REM ============================================================
 4667 REM  PROCbranch - recursive tapered branch
 4668 REM  Parameters:
 4669 REM    x1,y1   = base of branch (Agon coords, Y=0 at bottom)
 4670 REM    ang     = angle in degrees, 0=straight up
 4671 REM    ln      = length of this branch
 4672 REM    thkB    = thickness (line count) at base
 4673 REM    thkT    = thickness (line count) at tip
 4674 REM    dep     = recursion depth remaining
 4675 REM    spr     = spread angle each side in degrees
 4676 REM    jit     = max random jitter degrees
 4677 REM    shr     = length shrink factor per level
 4678 REM    stp     = number of taper steps along branch
 4679 REM ============================================================
 4680 DEF PROCbranch(x1,y1,ang,ln,thkB,thkT,dep,spr,jit,shr,stp)
 4681 LOCAL s,c,px,py
 4682 LOCAL i,j,t,thkNow,half
 4683 LOCAL sx,sy,ex,ey,ox,oy
 4684 LOCAL ax2,ay2,newThk,newTip,newLen,angL,angR,lc,lx,ly,gc
 4685 :
 4686 s = SIN(RAD(ang))
 4687 c = COS(RAD(ang))
 4688 px = -c : py = s
 4689 :
 4690 FOR i = 0 TO stp-1
 4691   t      = i/stp
 4692   thkNow = INT(thkB + (thkT-thkB)*t + 0.5)
 4693   IF thkNow < 1 THEN thkNow = 1
 4694   half   = (thkNow-1)/2
 4695   sx = x1 + ln*s*(i/stp)
 4696   sy = y1 + ln*c*(i/stp)
 4697   ex = x1 + ln*s*((i+1)/stp)
 4698   ey = y1 + ln*c*((i+1)/stp)
 4699   FOR j = 0 TO thkNow-1
 4700     ox = (j-half)*px
 4701     oy = (j-half)*py
 4702     MOVE sx+ox, sy+oy
 4703     DRAW ex+ox, ey+oy
 4704   NEXT j
 4705 NEXT i
 4706 :
 4707 ax2 = x1 + ln*s
 4708 ay2 = y1 + ln*c
 4709 IF dep > 0 THEN GOTO 4722
 4710 FOR lc = 1 TO 6
 4711   lx = ax2 + RND(10) - 5
 4712   ly = ay2 + RND(10) - 5
 4713   gc = (RND(5)-1)*8 + 2
 4714   GCOL 0,gc
 4715   PLOT 69, lx, ly
 4716   PLOT 69, lx+1, ly+1
 4717   PLOT 69, lx+2, ly
 4718 NEXT lc
 4719 GCOL 0,29
 4720 ENDPROC
 4722 :
 4723 newThk = thkT : IF newThk < 1 THEN newThk = 1
 4724 newTip = INT(newThk/2) : IF newTip < 1 THEN newTip = 1
 4725 newLen = ln * shr * (0.85 + RND(1)*0.3)
 4726 angL   = ang - INT(RND(spr)) - INT(RND(jit))
 4727 angR   = ang + INT(RND(spr)) + INT(RND(jit))
 4728 PROCbranch(ax2,ay2,angL,newLen,newThk,newTip,dep-1,spr,jit,shr,stp)
 4729 PROCbranch(ax2,ay2,angR,newLen,newThk,newTip,dep-1,spr,jit,shr,stp)
 4730 ENDPROC
 4740 :
 4750 REM ================================================
 4760 REM  Spanish accent decoding (see docs/superpowers specs
 4770 REM  2026-07-08-spanish-translation-design.md). DATA
 4780 REM  statements cannot hold CHR$() expressions, so
 4790 REM  accented chars are escape-coded there as backtick
 4800 REM  plus base letter (e.g. `o = o-acute) and decoded
 4810 REM  here at runtime after READ.
 4820 REM ================================================
 4830 DEF FN_Accentize$(t$)
 4840 LOCAL out$, i%, c$
 4850 out$=""
 4860 FOR i%=1 TO LEN(t$)
 4870   c$=MID$(t$,i%,1)
 4880   IF c$="`" THEN i%=i%+1:out$=out$+FN_AccentChar$(MID$(t$,i%,1)) ELSE out$=out$+c$
 4890 NEXT i%
 4900 =out$
 4910 :
 4920 DEF FN_AccentChar$(c$)
 4930 IF c$="a" THEN = CHR$(225)
 4940 IF c$="e" THEN = CHR$(233)
 4950 IF c$="i" THEN = CHR$(237)
 4960 IF c$="o" THEN = CHR$(243)
 4970 IF c$="u" THEN = CHR$(250)
 4980 IF c$="A" THEN = CHR$(193)
 4990 IF c$="E" THEN = CHR$(201)
 5000 IF c$="I" THEN = CHR$(205)
 5010 IF c$="O" THEN = CHR$(211)
 5020 IF c$="U" THEN = CHR$(218)
 5030 IF c$="n" THEN = CHR$(241)
 5040 IF c$="N" THEN = CHR$(209)
 5050 IF c$="?" THEN = CHR$(191)
 5060 IF c$="!" THEN = CHR$(161)
 5070 =c$
