   10 MODE 8
   11 REM FAITH_JOURNEY.BAS - integrated journey: logo, Our Father,
   12 REM daily affirmation, peace prayer, blessing, AMEN, logo, farewell.
   13 REM SPACE advances each screen. Built from chr.bas + companions.
   14 PROC_Init
   15 PROC_LogoScreen
   16 PROC_WaitSpace
   17 MODE 8:PROC_Blessing
   18 PROC_OurFather
   19 PROC_WaitSpace
   20 MODE 8:PROC_Setup
   21 PROC_ShowAffirmation
   22 r=RND(5):IF r=1 THEN PROC_DrawTree(7,300,650,0,100) ELSE IF r=2 THEN PROC_DrawFernIFS ELSE IF r=3 THEN PROC_DrawMapleLeaf ELSE IF r=4 THEN PROC_DrawAnchor ELSE PROC_DrawTaperedTree
   23 PROC_WaitSpace
   24 MODE 8:PROC_PeacePrayer
   25 PROC_WaitSpace
   26 MODE 8:PROC_Blessing
   27 MODE 8:PROC_AmenScreen:PROC_WaitSpace
   28 MODE 8:PROC_LogoScreen:PROC_WaitSpace:PROC_Finale:END
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
  100 PRINTTAB((W%-22)/2,1)"Affirmation of the Day"
  110 i=RND(365)-1
  111 RESTORE 910
  112 FOR I% = 0 TO i
  113   READ AFFIRMATION$, VERSE$
  114 NEXT I%
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
  530 PRINT TAB((W%-12)/2,7)"Inspired by:"
  531 PRINT TAB((W%-LEN(VERSE$))/2,8);VERSE$
  532 PROC_WaitSpace
  533 MOVE 650,0:VDU 23, 1, 0
  535 ENDPROC
  536 :
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
  910 DATA "God loves me with an everlasting love.", "Jeremiah 31:3"
  920 DATA "I am fearfully and wonderfully made.", "Psalm 139:14"
  930 DATA "The Lord is my shepherd; I shall not want.", "Psalm 23:1"
  940 DATA "I can do all things through Christ which strengtheneth me.", "Philippians 4:13"
  950 DATA "God has not given me a spirit of fear, but of power, love, and a sound mind.", "2 Timothy 1:7"
  960 DATA "I am the righteousness of God in Christ Jesus.", "2 Corinthians 5:21"
  970 DATA "The Lord goes before me and will be with me.", "Deuteronomy 31:8"
  980 DATA "I am more than a conqueror through Him that loved me.", "Romans 8:37"
  990 DATA "God supplies all my need according to His riches in glory.", "Philippians 4:19"
 1000 DATA "No weapon formed against me shall prosper.", "Isaiah 54:17"
 1010 DATA "I am hidden with Christ in God.", "Colossians 3:3"
 1020 DATA "The joy of the Lord is my strength.", "Nehemiah 8:10"
 1030 DATA "God is my refuge and strength, a very present help in trouble.", "Psalm 46:1"
 1040 DATA "I am created in the image and likeness of God.", "Genesis 1:27"
 1050 DATA "Christ has redeemed me from the curse of the law.", "Galatians 3:13"
 1060 DATA "I am the light of the world.", "Matthew 5:14"
 1070 DATA "God has plans to prosper me and not to harm me.", "Jeremiah 29:11"
 1080 DATA "I walk by faith, not by sight.", "2 Corinthians 5:7"
 1090 DATA "The Lord my God is with me wherever I go.", "Joshua 1:9"
 1100 DATA "I am a new creature in Christ; old things are passed away.", "2 Corinthians 5:17"
 1110 DATA "God's grace is sufficient for me.", "2 Corinthians 12:9"
 1120 DATA "I am sealed with the Holy Spirit of promise.", "Ephesians 1:13"
 1130 DATA "The Lord is my light and my salvation; whom shall I fear?", "Psalm 27:1"
 1140 DATA "I am rooted and grounded in love.", "Ephesians 3:17"
 1150 DATA "God has given His angels charge over me.", "Psalm 91:11"
 1160 DATA "I have been set free from sin and death.", "Romans 8:2"
 1170 DATA "I am the salt of the earth.", "Matthew 5:13"
 1180 DATA "God works all things together for good in my life.", "Romans 8:28"
 1190 DATA "I am accepted in the Beloved.", "Ephesians 1:6"
 1200 DATA "My God shall fight for me.", "Exodus 14:14"
 1210 DATA "I dwell in the secret place of the Most High.", "Psalm 91:1"
 1220 DATA "I am chosen of God, holy and beloved.", "Colossians 3:12"
 1230 DATA "The peace of God guards my heart and mind.", "Philippians 4:7"
 1240 DATA "God has given me every spiritual blessing in heavenly places.", "Ephesians 1:3"
 1250 DATA "I am an heir of God and a joint-heir with Christ.", "Romans 8:17"
 1260 DATA "The Lord preserves my going out and my coming in.", "Psalm 121:8"
 1270 DATA "I have the mind of Christ.", "1 Corinthians 2:16"
 1280 DATA "I am redeemed by the precious blood of Christ.", "1 Peter 1:19"
 1290 DATA "God's mercy toward me is new every morning.", "Lamentations 3:23"
 1300 DATA "I am strong in the Lord and in the power of His might.", "Ephesians 6:10"
 1310 DATA "The Lord blesses me and keeps me.", "Numbers 6:24"
 1320 DATA "I am the temple of the Holy Ghost.", "1 Corinthians 6:19"
 1330 DATA "I am delivered from the power of darkness.", "Colossians 1:13"
 1340 DATA "God renews my strength like the eagle's.", "Isaiah 40:31"
 1350 DATA "I am forgiven of all my sins through His blood.", "Ephesians 1:7"
 1360 DATA "The Lord is on my side; I will not fear what man can do.", "Psalm 118:6"
 1370 DATA "I am a child of God, born of His Spirit.", "John 1:12"
 1380 DATA "God has put a new song in my mouth.", "Psalm 40:3"
 1390 DATA "I press toward the mark for the prize of the high calling.", "Philippians 3:14"
 1400 DATA "I am clothed with strength and honour.", "Proverbs 31:25"
 1410 DATA "My steps are ordered by the Lord.", "Psalm 37:23"
 1420 DATA "I am complete in Christ.", "Colossians 2:10"
 1430 DATA "God is faithful and will not let me be tempted beyond my ability.", "1 Corinthians 10:13"
 1440 DATA "I have everlasting life through faith in Christ.", "John 3:16"
 1450 DATA "The Lord upholds me with His righteous right hand.", "Isaiah 41:10"
 1460 DATA "I am the head and not the tail.", "Deuteronomy 28:13"
 1470 DATA "God quickens and makes me alive together with Christ.", "Ephesians 2:5"
 1480 DATA "I have been given dominion over the works of His hands.", "Psalm 8:6"
 1490 DATA "I am bought with a price and therefore belong to God.", "1 Corinthians 6:20"
 1500 DATA "Greater is He that is in me than he that is in the world.", "1 John 4:4"
 1510 DATA "I lack no good thing because I seek the Lord.", "Psalm 34:10"
 1520 DATA "I am guarded by the power of God through faith.", "1 Peter 1:5"
 1530 DATA "My heart is established and I shall not be afraid.", "Psalm 112:8"
 1540 DATA "I am a fellow citizen with the saints and of the household of God.", "Ephesians 2:19"
 1550 DATA "God has not forgotten me; He has engraved me on His palms.", "Isaiah 49:16"
 1560 DATA "I am of good cheer because Christ has overcome the world.", "John 16:33"
 1570 DATA "The Lord gives me rest from all my enemies.", "Deuteronomy 12:10"
 1580 DATA "I have been transferred into the kingdom of the Son of His love.", "Colossians 1:13"
 1590 DATA "God satisfies my mouth with good things and renews my youth.", "Psalm 103:5"
 1600 DATA "I am steadfast, unmoveable, always abounding in the work of the Lord.", "1 Corinthians 15:58"
 1610 DATA "The Lord is good to me, a stronghold in the day of trouble.", "Nahum 1:7"
 1620 DATA "I have been raised up and seated in heavenly places in Christ.", "Ephesians 2:6"
 1630 DATA "I receive the crown of life because I love the Lord.", "James 1:12"
 1640 DATA "God's love has been shed abroad in my heart by the Holy Ghost.", "Romans 5:5"
 1650 DATA "I am crucified with Christ; nevertheless I live.", "Galatians 2:20"
 1660 DATA "The Lord makes my way prosperous and gives me good success.", "Joshua 1:8"
 1670 DATA "I call upon the Lord and He answers me.", "Psalm 86:7"
 1680 DATA "I am a branch abiding in the true vine, bearing much fruit.", "John 15:5"
 1690 DATA "God gives wisdom to me liberally when I ask in faith.", "James 1:5"
 1700 DATA "I am confident that the Lord will complete the good work He began in me.", "Philippians 1:6"
 1710 DATA "The Lord is my portion, therefore I will hope in Him.", "Lamentations 3:24"
 1720 DATA "I have been washed, sanctified, and justified in the name of Jesus.", "1 Corinthians 6:11"
 1730 DATA "I delight in the law of the Lord and I prosper in all I do.", "Psalm 1:2-3"
 1740 DATA "The Lord heals all my diseases.", "Psalm 103:3"
 1750 DATA "I am a vessel of honour, sanctified and meet for the Master's use.", "2 Timothy 2:21"
 1760 DATA "God protects me and no plague comes near my dwelling.", "Psalm 91:10"
 1770 DATA "I am an ambassador for Christ.", "2 Corinthians 5:20"
 1780 DATA "God clothes the humble with salvation.", "Psalm 149:4"
 1790 DATA "I am planted in the house of the Lord and I flourish.", "Psalm 92:13"
 1800 DATA "The Lord redeems my life from destruction and crowns me with lovingkindness.", "Psalm 103:4"
 1810 DATA "I am a peculiar people, a chosen generation, a royal priesthood.", "1 Peter 2:9"
 1820 DATA "God gives me favour in the sight of men.", "Proverbs 3:4"
 1830 DATA "I am the workmanship of God, created in Christ Jesus for good works.", "Ephesians 2:10"
 1840 DATA "The Lord turns my mourning into dancing.", "Psalm 30:11"
 1850 DATA "I have peace with God through my Lord Jesus Christ.", "Romans 5:1"
 1860 DATA "The Spirit of God dwells in me and gives life to my body.", "Romans 8:11"
 1870 DATA "I am transformed by the renewing of my mind.", "Romans 12:2"
 1880 DATA "My name is written in the Lamb's book of life.", "Revelation 21:27"
 1890 DATA "I bear fruit in every good work and increase in the knowledge of God.", "Colossians 1:10"
 1900 DATA "I am kept in perfect peace because my mind is stayed on God.", "Isaiah 26:3"
 1910 DATA "God is able to do exceedingly abundantly above all I ask or think.", "Ephesians 3:20"
 1920 DATA "The Lord preserves my soul.", "Psalm 121:7"
 1930 DATA "I have the full armour of God and I stand against the enemy.", "Ephesians 6:11"
 1940 DATA "I am loved with a love that cannot be separated from me.", "Romans 8:38-39"
 1950 DATA "God is my ever-present help and I will not be moved.", "Psalm 46:5"
 1960 DATA "I trust in the Lord with all my heart and He directs my paths.", "Proverbs 3:5-6"
 1970 DATA "The Lord is faithful to establish and guard me.", "2 Thessalonians 3:3"
 1980 DATA "I have obtained an inheritance in Christ.", "Ephesians 1:11"
 1990 DATA "God gives beauty for ashes and the oil of joy for mourning.", "Isaiah 61:3"
 2000 DATA "I am steadied by the right hand of God.", "Isaiah 41:10"
 2010 DATA "I shall not die but live and declare the works of the Lord.", "Psalm 118:17"
 2020 DATA "I am born of God and the evil one does not touch me.", "1 John 5:18"
 2030 DATA "The Lord is my rock, my fortress, and my deliverer.", "Psalm 18:2"
 2040 DATA "I am justified freely by His grace through the redemption in Christ.", "Romans 3:24"
 2050 DATA "God reveals deep and secret things to me.", "Daniel 2:22"
 2060 DATA "I am delivered from every evil work and preserved unto His kingdom.", "2 Timothy 4:18"
 2070 DATA "God is my Father and I cry, Abba, Father, to Him.", "Romans 8:15"
 2080 DATA "I am abundantly satisfied with the fatness of God's house.", "Psalm 36:8"
 2090 DATA "The Lord grants me sleep, for He gives it to His beloved.", "Psalm 127:2"
 2100 DATA "I am free from condemnation because I am in Christ Jesus.", "Romans 8:1"
 2110 DATA "The Lord fights my battles and I hold my peace.", "Exodus 14:14"
 2120 DATA "I am kept by the power of God.", "1 Peter 1:5"
 2130 DATA "God anoints my head with oil and my cup runs over.", "Psalm 23:5"
 2140 DATA "I have been given the keys of the kingdom of heaven.", "Matthew 16:19"
 2150 DATA "The Lord gives me wisdom and knowledge.", "Proverbs 2:6"
 2160 DATA "I am washed in the blood of the Lamb.", "Revelation 1:5"
 2170 DATA "God causes me to triumph in Christ always.", "2 Corinthians 2:14"
 2180 DATA "I am rich in faith and an heir of the kingdom God promised.", "James 2:5"
 2190 DATA "The Lord is near to all who call upon Him in truth.", "Psalm 145:18"
 2200 DATA "I have overcome the world because of my faith.", "1 John 5:4"
 2210 DATA "God has given me the spirit of wisdom and revelation.", "Ephesians 1:17"
 2220 DATA "I am planted by the rivers of water and my leaf shall not wither.", "Psalm 1:3"
 2230 DATA "The Lord makes me to lie down in green pastures.", "Psalm 23:2"
 2240 DATA "I am built upon the foundation of Christ, the chief cornerstone.", "Ephesians 2:20"
 2250 DATA "God keeps me in all my ways.", "Psalm 91:11"
 2260 DATA "I am sanctified through the offering of the body of Christ.", "Hebrews 10:10"
 2270 DATA "The Spirit of the Lord God is upon me and He has anointed me.", "Isaiah 61:1"
 2280 DATA "The Lord gives power to the faint and increases the strength of those with no might.", "Isaiah 40:29"
 2290 DATA "I have God's exceeding great and precious promises.", "2 Peter 1:4"
 2300 DATA "I am filled with all the fulness of God.", "Ephesians 3:19"
 2310 DATA "The Lord restores my soul.", "Psalm 23:3"
 2320 DATA "I am not ashamed of the gospel, for it is the power of God.", "Romans 1:16"
 2330 DATA "God remembers me according to His mercy.", "Psalm 25:7"
 2340 DATA "I am alive unto God through Jesus Christ our Lord.", "Romans 6:11"
 2350 DATA "God leads me in the paths of righteousness for His name's sake.", "Psalm 23:3"
 2360 DATA "I have received abundance of grace and the gift of righteousness.", "Romans 5:17"
 2370 DATA "The Lord delights in me and has set His love upon me.", "Psalm 18:19"
 2380 DATA "I am steadfast in faith, resisting the enemy.", "1 Peter 5:9"
 2390 DATA "God keeps me from stumbling and presents me faultless before His glory.", "Jude 1:24"
 2400 DATA "I have been given eternal life and no one can snatch me from God's hand.", "John 10:28"
 2410 DATA "The Lord hears my voice and my supplication.", "Psalm 116:1"
 2420 DATA "I am strengthened with all might according to His glorious power.", "Colossians 1:11"
 2430 DATA "I wait on the Lord and He renews my strength.", "Isaiah 40:31"
 2440 DATA "The Lord is my helper; I will not fear what man shall do.", "Hebrews 13:6"
 2450 DATA "I am called according to God's purpose and He works all things for my good.", "Romans 8:28"
 2460 DATA "God gives me a garment of praise for a spirit of heaviness.", "Isaiah 61:3"
 2470 DATA "I am the friend of God.", "John 15:15"
 2480 DATA "The Lord gives me the desires of my heart as I delight in Him.", "Psalm 37:4"
 2490 DATA "I am thoroughly furnished unto all good works.", "2 Timothy 3:17"
 2500 DATA "God is my shade upon my right hand.", "Psalm 121:5"
 2510 DATA "I am healed by the stripes of Jesus Christ.", "Isaiah 53:5"
 2520 DATA "The Lord covers me with His feathers and under His wings I trust.", "Psalm 91:4"
 2530 DATA "I am blessed in my basket and in my store.", "Deuteronomy 28:5"
 2540 DATA "God's word is a lamp to my feet and a light to my path.", "Psalm 119:105"
 2550 DATA "I am an overcomer by the blood of the Lamb and the word of my testimony.", "Revelation 12:11"
 2560 DATA "The Lord grants me long life and shows me His salvation.", "Psalm 91:16"
 2570 DATA "I have been granted access by faith into His grace.", "Romans 5:2"
 2580 DATA "God is not the author of confusion but of peace in my life.", "1 Corinthians 14:33"
 2590 DATA "I am established and anointed by God.", "2 Corinthians 1:21"
 2600 DATA "The Lord preserves the way of His saints.", "Proverbs 2:8"
 2610 DATA "I have been adopted into the family of God.", "Ephesians 1:5"
 2620 DATA "God bottles my tears and is attentive to my sorrows.", "Psalm 56:8"
 2630 DATA "I am called to inherit a blessing.", "1 Peter 3:9"
 2640 DATA "God did not spare His own Son but freely gives me all things with Him.", "Romans 8:32"
 2650 DATA "I am built up a spiritual house and a holy priesthood.", "1 Peter 2:5"
 2660 DATA "The Lord satisfies my longing soul and fills my hungry soul with goodness.", "Psalm 107:9"
 2670 DATA "I have obtained mercy and am now the people of God.", "1 Peter 2:10"
 2680 DATA "God gives me double for my former trouble.", "Isaiah 61:7"
 2690 DATA "I am the apple of God's eye.", "Zechariah 2:8"
 2700 DATA "The Lord has set my feet in a large place.", "Psalm 18:19"
 2710 DATA "I am made nigh to God by the blood of Christ.", "Ephesians 2:13"
 2720 DATA "God fights against them that fight against me.", "Psalm 35:1"
 2730 DATA "I am a keeper of God's covenant and I receive His steadfast love.", "Psalm 103:18"
 2740 DATA "The Lord is the strength of my life.", "Psalm 27:1"
 2750 DATA "I am washed and made white as snow.", "Isaiah 1:18"
 2760 DATA "God opens rivers in high places and fountains in the valleys for me.", "Isaiah 41:18"
 2770 DATA "I have boldness and confident access to God through faith in Christ.", "Ephesians 3:12"
 2780 DATA "The Lord makes even my enemies to be at peace with me.", "Proverbs 16:7"
 2790 DATA "I am shielded by God's faithfulness.", "Psalm 91:4"
 2800 DATA "God has put His Spirit within me and causes me to walk in His statutes.", "Ezekiel 36:27"
 2810 DATA "I am growing in grace and in the knowledge of my Lord Jesus Christ.", "2 Peter 3:18"
 2820 DATA "The Lord has made a way for me in the wilderness and rivers in the desert.", "Isaiah 43:19"
 2830 DATA "I have received the spirit of adoption, not of bondage again to fear.", "Romans 8:15"
 2840 DATA "I am submitted to God and the devil flees from me.", "James 4:7"
 2850 DATA "The Lord has clothed me with the garments of salvation.", "Isaiah 61:10"
 2860 DATA "I am called and chosen and faithful.", "Revelation 17:14"
 2870 DATA "God takes pleasure in my prosperity.", "Psalm 35:27"
 2880 DATA "I am bold as a lion because of my righteousness in Christ.", "Proverbs 28:1"
 2890 DATA "The Lord quiets me with His love and rejoices over me with singing.", "Zephaniah 3:17"
 2900 DATA "I have the earnest of the Spirit in my heart.", "2 Corinthians 1:22"
 2910 DATA "God encamps the angel of the Lord around me because I fear Him.", "Psalm 34:7"
 2920 DATA "The Lord rescues me from every snare of the enemy.", "Psalm 124:7"
 2930 DATA "I have been given all things that pertain to life and godliness.", "2 Peter 1:3"
 2940 DATA "God commanded blessings upon me in my storehouse and all I set my hand to.", "Deuteronomy 28:8"
 2950 DATA "I am not conformed to the world but transformed by God.", "Romans 12:2"
 2960 DATA "The Lord establishes my thoughts as I commit my works to Him.", "Proverbs 16:3"
 2970 DATA "My prayer avails much because I am righteous through Christ.", "James 5:16"
 2980 DATA "God leads me beside the still waters and restores my soul.", "Psalm 23:2-3"
 2990 DATA "I am enriched by Christ in all utterance and all knowledge.", "1 Corinthians 1:5"
 3000 DATA "The Lord makes all grace abound toward me.", "2 Corinthians 9:8"
 3010 DATA "I am rooted, built up, and established in Christ.", "Colossians 2:7"
 3020 DATA "God is perfecting that which concerns me.", "Psalm 138:8"
 3030 DATA "I am reconciled to God through the death of His Son.", "Romans 5:10"
 3040 DATA "The Lord gives His beloved sleep and rest.", "Psalm 127:2"
 3050 DATA "I have put on the new man which is renewed in knowledge.", "Colossians 3:10"
 3060 DATA "God establishes my heart blameless in holiness.", "1 Thessalonians 3:13"
 3070 DATA "I am abounding in hope through the power of the Holy Ghost.", "Romans 15:13"
 3080 DATA "The Lord sets me in safety from them that puff at me.", "Psalm 12:5"
 3090 DATA "God anoints me with the oil of gladness.", "Psalm 45:7"
 3100 DATA "I am grounded and settled and not moved away from the hope of the gospel.", "Colossians 1:23"
 3110 DATA "The Lord binds up my broken heart and heals my wounds.", "Psalm 147:3"
 3120 DATA "I have the assurance of salvation and the earnest of the Spirit.", "Ephesians 1:14"
 3130 DATA "God separates me from my sins as far as the east is from the west.", "Psalm 103:12"
 3140 DATA "I am fruitful and multiply, blessed by the hand of God.", "Genesis 1:28"
 3150 DATA "The Lord laughs at my enemies and holds them in derision for my sake.", "Psalm 2:4"
 3160 DATA "I am strong and courageous because God is with me.", "Joshua 1:9"
 3170 DATA "God writes His laws in my heart and on my mind.", "Hebrews 10:16"
 3180 DATA "I am a partaker of the divine nature.", "2 Peter 1:4"
 3190 DATA "The Lord makes my paths straight as I acknowledge Him.", "Proverbs 3:6"
 3200 DATA "I have been set apart and sanctified by God the Father.", "Jude 1:1"
 3210 DATA "God is my sun and shield; He gives grace and glory.", "Psalm 84:11"
 3220 DATA "I am secure in Christ, hid with Him in God.", "Colossians 3:3"
 3230 DATA "The Lord makes me glad through His work and I triumph in it.", "Psalm 92:4"
 3240 DATA "I have been made a partaker of Christ.", "Hebrews 3:14"
 3250 DATA "God gives me the tongue of the learned to speak a word in season.", "Isaiah 50:4"
 3260 DATA "I am precious in the sight of God and He loves me.", "Isaiah 43:4"
 3270 DATA "The Lord goes with me through fire and water to a wealthy place.", "Psalm 66:12"
 3280 DATA "I have redemption through His blood and the forgiveness of sins.", "Colossians 1:14"
 3290 DATA "God beautifies the meek with salvation.", "Psalm 149:4"
 3300 DATA "I am a minister of reconciliation, bearing glad tidings.", "2 Corinthians 5:18"
 3310 DATA "The Lord overthrows the plans of the wicked set against me.", "Proverbs 15:26"
 3320 DATA "I have been purified from all unrighteousness by His faithfulness.", "1 John 1:9"
 3330 DATA "God turns my captivity and restores my fortunes.", "Psalm 126:4"
 3340 DATA "The Lord honours those who honour Him.", "1 Samuel 2:30"
 3350 DATA "I have the assurance that what I ask in prayer, believing, I shall receive.", "Matthew 21:22"
 3360 DATA "God preserves me from trouble and surrounds me with songs of deliverance.", "Psalm 32:7"
 3370 DATA "I am a faithful steward of the manifold grace of God.", "1 Peter 4:10"
 3380 DATA "The Lord makes the crooked places straight and the rough places plain for me.", "Isaiah 40:4"
 3390 DATA "I have been made to sit together in heavenly places in Christ Jesus.", "Ephesians 2:6"
 3400 DATA "God enlarges my heart to run in the way of His commandments.", "Psalm 119:32"
 3410 DATA "The Lord gives me the heathen for my inheritance.", "Psalm 2:8"
 3420 DATA "I have a building of God, a house not made with hands, eternal in the heavens.", "2 Corinthians 5:1"
 3430 DATA "God keeps me as the apple of His eye and hides me under the shadow of His wings.", "Psalm 17:8"
 3440 DATA "I am not afraid of evil tidings because my heart is fixed, trusting in the Lord.", "Psalm 112:7"
 3450 DATA "The Lord opens to me His good treasure and blesses all my work.", "Deuteronomy 28:12"
 3460 DATA "I have received the promise of the Spirit through faith.", "Galatians 3:14"
 3470 DATA "God is my exceeding great reward.", "Genesis 15:1"
 3480 DATA "The Lord hears me and saves me out of all my troubles.", "Psalm 34:6"
 3490 DATA "I have been given a spirit of power, love, and self-control.", "2 Timothy 1:7"
 3500 DATA "I am raised with Christ and seek the things which are above.", "Colossians 3:1"
 3510 DATA "The Lord makes His face shine upon me and is gracious to me.", "Numbers 6:25"
 3520 DATA "I have received mercy and found grace to help in time of need.", "Hebrews 4:16"
 3530 DATA "God inclines my ear to wisdom and my heart to understanding.", "Proverbs 2:2"
 3540 DATA "I am reigning in life through the one man Jesus Christ.", "Romans 5:17"
 3550 DATA "The Lord blesses my bread and my water and takes sickness from me.", "Exodus 23:25"
 3560 DATA "I have been baptized into Christ and put on Christ.", "Galatians 3:27"
 3570 DATA "I am standing firm in the liberty wherewith Christ has made me free.", "Galatians 5:1"
 3580 DATA "The Lord teaches my hands to war and my fingers to fight.", "Psalm 144:1"
 3590 DATA "I have received the promise of eternal inheritance through His death.", "Hebrews 9:15"
 3600 DATA "God gives me the former and the latter rain in due season.", "Joel 2:23"
 3610 DATA "The Lord is in the midst of me, the mighty God, and He saves.", "Zephaniah 3:17"
 3620 DATA "I have been granted precious and very great promises of God.", "2 Peter 1:4"
 3630 DATA "God opens my eyes to behold wondrous things out of His law.", "Psalm 119:18"
 3640 DATA "I am the planting of the Lord, that He might be glorified.", "Isaiah 61:3"
 3650 DATA "The Lord has put a new spirit within me.", "Ezekiel 36:26"
 3660 DATA "I have obtained favour of the Lord and am filled with good things.", "Proverbs 8:35"
 3670 DATA "God is exalted, yet He has respect for the lowly like me.", "Psalm 138:6"
 3680 DATA "I am a soldier of Jesus Christ, enduring hardship for His name.", "2 Timothy 2:3"
 3690 DATA "The Lord goes before me and makes the crooked places straight.", "Isaiah 45:2"
 3700 DATA "I have a High Priest who sympathises with my weaknesses.", "Hebrews 4:15"
 3710 DATA "God remembers His covenant and shows me great kindness.", "Genesis 24:27"
 3720 DATA "I am filled with the fruit of righteousness to the glory of God.", "Philippians 1:11"
 3730 DATA "The Lord loads me daily with benefits.", "Psalm 68:19"
 3740 DATA "I have the earnest of my inheritance until the redemption of the purchased possession.", "Ephesians 1:14"
 3750 DATA "God protects me from the snare of the fowler and the noisome pestilence.", "Psalm 91:3"
 3760 DATA "I am chosen before the foundation of the world to be holy and blameless.", "Ephesians 1:4"
 3770 DATA "The Lord satisfies my longing with His goodness.", "Psalm 103:5"
 3780 DATA "I have boldness to enter the Holiest by the blood of Jesus.", "Hebrews 10:19"
 3790 DATA "God makes all grace abound to me so that I abound in every good work.", "2 Corinthians 9:8"
 3800 DATA "I am a fellow worker with God.", "1 Corinthians 3:9"
 3810 DATA "The Lord makes me glad according to the days He afflicted me.", "Psalm 90:15"
 3820 DATA "I have been given authority to tread on serpents and scorpions.", "Luke 10:19"
 3830 DATA "God is my confidence and He keeps my foot from being caught.", "Proverbs 3:26"
 3840 DATA "I am growing from glory to glory by the Spirit of the Lord.", "2 Corinthians 3:18"
 3850 DATA "The Lord is a wall of fire around me and the glory in my midst.", "Zechariah 2:5"
 3860 DATA "I have put on the armour of light.", "Romans 13:12"
 3870 DATA "God gives me pastors after His own heart who feed me with knowledge.", "Jeremiah 3:15"
 3880 DATA "I am complete in God, who is the head of all principality and power.", "Colossians 2:10"
 3890 DATA "The Lord is on my right hand so I shall not be moved.", "Psalm 16:8"
 3900 DATA "I have been kept blameless unto the coming of our Lord Jesus Christ.", "1 Thessalonians 5:23"
 3910 DATA "God teaches me to profit and leads me in the way I should go.", "Isaiah 48:17"
 3920 DATA "I am a son of God through faith in Christ Jesus.", "Galatians 3:26"
 3930 DATA "The Lord is the portion of my cup and maintains my lot.", "Psalm 16:5"
 3940 DATA "I have been purified as silver is tried, tested and approved of God.", "Psalm 66:10"
 3950 DATA "God has given me treasure in heaven that no thief can steal.", "Luke 12:33"
 3960 DATA "I am planted in righteousness and established far from oppression.", "Isaiah 54:14"
 3970 DATA "I have peace that passes all understanding, guarding my heart.", "Philippians 4:7"
 3980 DATA "God sends His word and heals me.", "Psalm 107:20"
 3990 DATA "I am kept in the hollow of His hand and none can pluck me out.", "John 10:29"
 4000 DATA "The Lord gives me the spirit of wisdom and understanding.", "Isaiah 11:2"
 4010 DATA "I have learned in whatever state I am to be content.", "Philippians 4:11"
 4020 DATA "God is faithful to sanctify me wholly, body, soul, and spirit.", "1 Thessalonians 5:23"
 4030 DATA "I am waiting on the Lord and He is good to me.", "Lamentations 3:25"
 4040 DATA "The Lord repays me double for my trouble and shame.", "Isaiah 61:7"
 4050 DATA "I have a hope both sure and steadfast, anchored in the soul.", "Hebrews 6:19"
 4060 DATA "God lifts me up from the miry clay and sets my feet on a rock.", "Psalm 40:2"
 4070 DATA "I am called to liberty in Christ and serve others through love.", "Galatians 5:13"
 4080 DATA "The Lord goes with me; He will not fail me or forsake me.", "Deuteronomy 31:6"
 4090 DATA "I have been given an incorruptible inheritance reserved in heaven.", "1 Peter 1:4"
 4100 DATA "God is my exceeding joy and gladness.", "Psalm 43:4"
 4110 DATA "I am transformed into the same image of Christ from glory to glory.", "2 Corinthians 3:18"
 4120 DATA "The Lord is faithful and just to cleanse me from all unrighteousness.", "1 John 1:9"
 4130 DATA "I am confident I shall see the goodness of the Lord in the land of the living.", "Psalm 27:13"
 4140 DATA "God crowns my year with His goodness and His paths drop fatness.", "Psalm 65:11"
 4150 DATA "I have been predestinated to be conformed to the image of His Son.", "Romans 8:29"
 4160 DATA "The Lord comforts me in all my tribulation.", "2 Corinthians 1:4"
 4170 DATA "I am known of God and have come to know Him.", "Galatians 4:9"
 4180 DATA "The Lord makes my feet like hinds' feet and sets me upon high places.", "Habakkuk 3:19"
 4190 DATA "I have been made kings and priests unto God.", "Revelation 1:6"
 4200 DATA "God satisfies me with long life and shows me His salvation.", "Psalm 91:16"
 4210 DATA "I am translated out of darkness into His marvellous light.", "1 Peter 2:9"
 4220 DATA "The Lord rewards me openly as I pray to Him in secret.", "Matthew 6:6"
 4230 DATA "I am justified by His blood and saved from wrath through Him.", "Romans 5:9"
 4240 DATA "God gives me songs in the night and makes me joyful.", "Job 35:10"
 4250 DATA "I am sealed unto the day of redemption.", "Ephesians 4:30"
 4260 DATA "The Lord causes me to inherit the land and abide therein.", "Psalm 37:29"
 4270 DATA "I have the victory that overcomes the world, even my faith.", "1 John 5:4"
 4280 DATA "God speaks peace to me, His saint, and turns me not to folly.", "Psalm 85:8"
 4290 DATA "I am established in the faith and overflow with thanksgiving.", "Colossians 2:7"
 4300 DATA "The Lord lifts up my head above mine enemies around me.", "Psalm 27:6"
 4310 DATA "I have been granted to know the mysteries of the kingdom of God.", "Luke 8:10"
 4320 DATA "God blesses my coming in and my going out.", "Deuteronomy 28:6"
 4330 DATA "I am growing up in Him who is the Head, even Christ.", "Ephesians 4:15"
 4340 DATA "The Lord delivers me from all my fears.", "Psalm 34:4"
 4350 DATA "I have the hope of glory, Christ dwelling in me.", "Colossians 1:27"
 4360 DATA "God is working in me both to will and to do His good pleasure.", "Philippians 2:13"
 4370 DATA "I am an heir according to the hope of eternal life.", "Titus 3:7"
 4380 DATA "The Lord makes me glad through His works; I triumph in the works of His hands.", "Psalm 92:4"
 4390 DATA "I have been made a partaker of His holiness.", "Hebrews 12:10"
 4400 DATA "God gives me the tongue of the learned and wakens my ear morning by morning.", "Isaiah 50:4"
 4410 DATA "I am growing up into a holy temple in the Lord.", "Ephesians 2:21"
 4420 DATA "The Lord teaches me His statutes and I meditate on His wonders.", "Psalm 119:27"
 4430 DATA "I have been made free from the law of sin and death.", "Romans 8:2"
 4440 DATA "God opens the windows of heaven over me and pours out abundant blessing.", "Malachi 3:10"
 4450 DATA "I am planted and watered by God and He gives the increase.", "1 Corinthians 3:7"
 4460 DATA "The Lord preserves me from all evil and preserves my soul.", "Psalm 121:7"
 4470 DATA "I have a living hope through the resurrection of Jesus Christ.", "1 Peter 1:3"
 4480 DATA "God is my glory and the lifter up of my head.", "Psalm 3:3"
 4490 DATA "I am casting all my care upon Him, for He cares for me.", "1 Peter 5:7"
 4500 DATA "The Lord rejoices over me with singing and exults over me with loud singing.", "Zephaniah 3:17"
 4510 DATA "I have been chosen to bring forth fruit and that my fruit should remain.", "John 15:16"
 4520 DATA "God commands His lovingkindness in the daytime and His song is with me in the night.", "Psalm 42:8"
 4530 DATA "I am surrounded by God as the mountains surround Jerusalem.", "Psalm 125:2"
 4540 DATA "The Lord has engraved me on the palms of His hands; my walls are before Him.", "Isaiah 49:16"
 4550 DATA "I will bless the Lord at all times; His praise shall continually be in my mouth.", "Psalm 34:1"
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
 5100 REM ================================================
 5101 REM  Journey helpers
 5102 REM ================================================
 5103 DEF PROC_Init
 5104 W% = FN_GETBYTE_VDP(&13)
 5105 H% = FN_GETBYTE_VDP(&14)
 5106 C% = FN_GETBYTE_VDP(&15)
 5107 cell% = 14: REM logical units per logo pixel
 5108 blk% = 12: REM filled size of each logo pixel (2-unit gap)
 5109 DIM pal%(5)
 5110 pal%(0)=11:pal%(1)=15:pal%(2)=14:pal%(3)=13:pal%(4)=10:pal%(5)=9
 5111 ENDPROC
 5112 :
 5120 REM Advance on the space bar only
 5121 DEF PROC_WaitSpace
 5122 REPEAT UNTIL GET=32
 5123 ENDPROC
 5124 :
 5130 DEF PROC_Finale
 5131 COLOUR 128+11:COLOUR 55:CLS: REM light yellow bg, light orange letters
 5132 end_text$ = "GO IN PEACE - GOD BLESS YOU!"
 5133 PRINT TAB((W%-LEN(end_text$))/2,H%/2) end_text$
 5134 PROC_WaitSpace
 5135 VDU 23,1,1;0;0;0;: REM show the cursor only after the final space
 5136 ENDPROC
 5137 :
 5140 REM Wait cs% centiseconds (300 = 3 seconds)
 5141 DEF PROC_Wait(cs%)
 5142 TIME = 0
 5143 REPEAT UNTIL TIME >= cs%
 5144 ENDPROC
 5145 :
 5200 REM ================================================
 5201 REM  Logo screen (from BELIEVE_BREATHE_PRAY.BAS)
 5202 REM ================================================
 5203 DEF PROC_LogoScreen
 5204 VDU 23,1,0;0;0;0;: REM hide cursor
 5205 COLOUR 128+4:CLS
 5206 k% = 0: REM letter colour cycler
 5207 PROC_DrawStars
 5208 PROC_DrawBorder
 5209 PROC_DrawLogo
 5210 ENDPROC
 5211 :
 5220 REM Scatter little stars outside the circle
 5221 DEF PROC_DrawStars
 5222 LOCAL i%,x,y,dx,dy
 5223 FOR i%=1 TO 120
 5224   x=RND(1280)-1:y=RND(1024)-1
 5225   dx=x-640:dy=y-512
 5226   IF dx*dx+dy*dy > 260000 THEN GCOL 0,pal%(RND(6)-1):PLOT 69,x,y
 5227 NEXT i%
 5228 ENDPROC
 5229 :
 5240 REM Circular border: two solid rings with a dotted ring between
 5241 DEF PROC_DrawBorder
 5242 LOCAL a
 5243 PROC_Circle(640,512,488,11)
 5244 PROC_Circle(640,512,484,11)
 5245 PROC_Circle(640,512,452,13)
 5246 GCOL 0,15
 5247 FOR a=0 TO 354 STEP 6
 5248   PLOT 69,640+468*COS(RAD(a)),512+468*SIN(RAD(a))
 5249 NEXT a
 5250 ENDPROC
 5251 :
 5260 DEF PROC_Circle(cx,cy,r,col%)
 5261 LOCAL a
 5262 GCOL 0,col%
 5263 MOVE cx+r,cy
 5264 FOR a=4 TO 360 STEP 4
 5265   DRAW cx+r*COS(RAD(a)),cy+r*SIN(RAD(a))
 5266 NEXT a
 5267 ENDPROC
 5268 :
 5300 DEF PROC_DrawLogo
 5301 PROC_BigText("BELIEVE,",710)
 5302 PROC_BigText("BREATHE,",560)
 5303 PROC_BigText("AND PRAY!",410)
 5304 ENDPROC
 5305 :
 5310 REM Print t$ in big letters, centred, top edge at ytop
 5311 DEF PROC_BigText(t$,ytop)
 5312 LOCAL i%,x0,ch$
 5313 x0 = 640-(LEN(t$)*6*cell%-cell%)/2
 5314 FOR i%=1 TO LEN(t$)
 5315   ch$=MID$(t$,i%,1)
 5316   IF ch$<>" " THEN PROC_BigChar(ch$,x0+(i%-1)*6*cell%,ytop)
 5317 NEXT i%
 5318 ENDPROC
 5319 :
 5320 REM Draw one 5x7 character from the font DATA at line 5400
 5321 DEF PROC_BigChar(ch$,x,ytop)
 5322 LOCAL idx%,r%,c%,row$,d$
 5323 idx% = INSTR("BELIVRATHNDPY,!M",ch$)
 5324 IF idx%=0 THEN ENDPROC
 5325 GCOL 0,pal%(k% MOD 6):k%=k%+1
 5326 RESTORE 5400
 5327 IF idx%>1 THEN FOR r%=1 TO (idx%-1)*7:READ d$:NEXT r%
 5328 FOR r%=0 TO 6
 5329   READ row$
 5330   FOR c%=1 TO 5
 5331   IF MID$(row$,c%,1)="#" THEN PROC_Block(x+(c%-1)*cell%,ytop-r%*cell%)
 5332   NEXT c%
 5333 NEXT r%
 5334 ENDPROC
 5335 :
 5340 REM Filled square with top-left corner at (x,y), two triangles
 5341 DEF PROC_Block(x,y)
 5342 MOVE x,y-blk%
 5343 MOVE x+blk%,y-blk%
 5344 PLOT 85,x,y
 5345 PLOT 85,x+blk%,y
 5346 ENDPROC
 5347 :
 5390 REM 5x7 font, 7 rows per character, in the order "BELIVRATHNDPY,!M"
 5400 DATA "####.","#...#","#...#","####.","#...#","#...#","####."
 5401 DATA "#####","#....","#....","####.","#....","#....","#####"
 5402 DATA "#....","#....","#....","#....","#....","#....","#####"
 5403 DATA "#####","..#..","..#..","..#..","..#..","..#..","#####"
 5404 DATA "#...#","#...#","#...#","#...#","#...#",".#.#.","..#.."
 5405 DATA "####.","#...#","#...#","####.","#.#..","#..#.","#...#"
 5406 DATA "..#..",".#.#.","#...#","#####","#...#","#...#","#...#"
 5407 DATA "#####","..#..","..#..","..#..","..#..","..#..","..#.."
 5408 DATA "#...#","#...#","#...#","#####","#...#","#...#","#...#"
 5409 DATA "#...#","##..#","#.#.#","#..##","#...#","#...#","#...#"
 5410 DATA "####.","#...#","#...#","#...#","#...#","#...#","####."
 5411 DATA "####.","#...#","#...#","####.","#....","#....","#...."
 5412 DATA "#...#","#...#",".#.#.","..#..","..#..","..#..","..#.."
 5413 DATA ".....",".....",".....",".....","..##.","..##.",".#..."
 5414 DATA "..#..","..#..","..#..","..#..","..#..",".....","..#.."
 5415 DATA "#...#","##.##","#.#.#","#...#","#...#","#...#","#...#"
 5416 :
 5500 REM ================================================
 5501 REM  Prayers (from OUR_FATHER.BAS / PEACE_PRAYER.BAS)
 5502 REM ================================================
 5503 REM Sign of the Cross on a red screen, held for 3 seconds
 5504 DEF PROC_Blessing
 5505 VDU 23,1,0;0;0;0;: REM hide cursor while the prayers reveal
 5506 COLOUR 128+1:COLOUR 15:CLS
 5507 b1$ = "In the name of the Father,"
 5508 b2$ = "and of the Son,"
 5509 b3$ = "and of the Holy Spirit..."
 5510 PRINT TAB((W%-LEN(b1$))/2,H%/2-3);b1$
 5511 PROC_Wait(300)
 5512 PRINT TAB((W%-LEN(b2$))/2,H%/2-1);b2$
 5513 PROC_Wait(300)
 5514 PRINT TAB((W%-LEN(b3$))/2,H%/2+1);b3$
 5515 PROC_Wait(300)
 5516 ENDPROC
 5517 :
 5520 REM The Lord's Prayer, revealed line by line, on dark blue
 5521 DEF PROC_OurFather
 5522 COLOUR 128+4:COLOUR 14:CLS
 5523 RESTORE 5550
 5524 row% = 3
 5525 FOR I% = 1 TO 12
 5526   READ L$
 5527   PRINT TAB((W%-LEN(L$))/2,row%);L$
 5528   row% = row% + 2
 5529   IF I% < 12 THEN PROC_Wait(300)
 5530 NEXT I%
 5531 ENDPROC
 5532 :
 5550 DATA "Our Father, who art in heaven,"
 5551 DATA "hallowed be thy name;"
 5552 DATA "thy kingdom come;"
 5553 DATA "thy will be done"
 5554 DATA "on earth as it is in heaven."
 5555 DATA "Give us this day our daily bread;"
 5556 DATA "and forgive us our trespasses,"
 5557 DATA "as we forgive those"
 5558 DATA "who trespass against us;"
 5559 DATA "and lead us not into temptation,"
 5560 DATA "but deliver us from evil."
 5561 DATA "Amen."
 5562 :
 5600 REM Peace prayer on white, light blue letters
 5601 DEF PROC_PeacePrayer
 5602 VDU 23,1,0;0;0;0;: REM hide cursor
 5603 COLOUR 128+15:COLOUR 14:CLS
 5604 RESTORE 5650
 5605 row% = 3
 5606 FOR I% = 1 TO 8
 5607   READ L$
 5608   PRINT TAB((W%-LEN(L$))/2,row%);L$
 5609   row% = row% + 2
 5610   IF I% < 8 THEN PROC_Wait(300)
 5611 NEXT I%
 5612 ENDPROC
 5613 :
 5650 DATA "Lord, thank You for this breath,"
 5651 DATA "this moment, this day."
 5652 DATA "Quiet the noise of yesterday"
 5653 DATA "and the fear of tomorrow."
 5654 DATA "Let peace - the peace that"
 5655 DATA "surpasses understanding -"
 5656 DATA "guard my heart and mind right now."
 5657 DATA "Amen."
 5658 :
 5700 REM Giant AMEN filling the centre of the screen
 5701 DEF PROC_AmenScreen
 5702 VDU 23,1,0;0;0;0;: REM hide cursor
 5703 COLOUR 128+4:CLS
 5704 k% = 0: REM letter colour cycler
 5705 PROC_DrawStars
 5706 cell% = 40:blk% = 36: REM enlarge the block font
 5707 PROC_BigText("AMEN!",652)
 5708 cell% = 14:blk% = 12: REM restore logo sizing
 5709 ENDPROC
