YSANTEG ;ISC/XTSUMBLD KERNEL - Package checksum checker ;2960327.160557
        ;;5.01;MENTAL HEALTH;**10**;Dec 30, 1994
 ;;7.3;2960327.160557
 S XT4="I 1",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
CONT F XT1=1:1 S XT2=$T(ROU+XT1) Q:XT2=""  S X=$P(XT2," ",1),XT3=$P(XT2,";",3) X XT4 I $T W !,X X ^%ZOSF("TEST") S:'$T XT3=0 X:XT3 ^%ZOSF("RSUM") W ?10,$S('XT3:"Routine not in UCI",XT3'=Y:"Calculated "_$C(7)_Y_", off by "_(Y-XT3),1:"ok")
 ;
 K %1,%2,%3,X,Y,XT1,XT2,XT3,XT4 Q
ONE S XT4="I $D(^UTILITY($J,X))",X=$T(+3) W !!,"Checksum routine created on ",$P(X,";",4)," by KERNEL V",$P(X,";",3),!
 W !,"Check a subset of routines:" K ^UTILITY($J) X ^%ZOSF("RSEL")
 W ! G CONT
ROU ;;
YSAIN001 ;;12392288
YSAIN002 ;;14260937
YSAIN003 ;;12099349
YSAIN004 ;;5693713
YSAIN005 ;;15213753
YSAIN006 ;;11533080
YSAIN007 ;;11086575
YSAIN008 ;;11436904
YSAIN009 ;;11139394
YSAIN00A ;;11413289
YSAIN00B ;;11508841
YSAIN00C ;;8770232
YSAIN00D ;;14476671
YSAIN00E ;;12671694
YSAIN00F ;;10580238
YSAIN00G ;;11072833
YSAIN00H ;;10705014
YSAIN00I ;;10630624
YSAIN00J ;;10777411
YSAIN00K ;;10392550
YSAIN00L ;;10473563
YSAIN00M ;;10217942
YSAIN00N ;;8893872
YSAIN00O ;;10074802
YSAIN00P ;;9534185
YSAIN00Q ;;8973922
YSAIN00R ;;8353380
YSAIN00S ;;9082557
YSAIN00T ;;8740197
YSAIN00U ;;9639516
YSAIN00V ;;9588218
YSAIN00W ;;9698603
YSAIN00X ;;10357762
YSAIN00Y ;;11894669
YSAIN00Z ;;14926969
YSAIN010 ;;13195215
YSAIN011 ;;11330034
YSAIN012 ;;9441202
YSAIN013 ;;7462694
YSAIN014 ;;2525664
YSAIN015 ;;8361839
YSAIN016 ;;2133710
YSAINIS ;;2172679
YSAINIT ;;10263704
YSAINIT1 ;;4837746
YSAINIT2 ;;5232645
YSAINIT3 ;;16808170
YSAINIT4 ;;3357817
YSAINIT5 ;;560828
YSAPOST ;;1560168
YTCLERK1 ;;6001127
YTMCMI2 ;;5830325
YTMMPI2B ;;14737364
YTMMPI2D ;;5928810
YTNEOPI ;;7973707
YTNEOPI1 ;;11956684
YTNEOPI2 ;;9028720
YTPAI ;;7779058
YTPAI1 ;;7571845
YTSCL9R ;;7339003
YTSCL9R1 ;;6147436
YTSF36 ;;5370215
