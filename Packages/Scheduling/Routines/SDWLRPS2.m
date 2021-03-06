SDWLRPS2 ;;IOFO BAY PINES/TEH - WAIT LIST REPORT FORMAT 1-SUMMARY;06/12/2002 ; 20 Aug 2002  2:10 PM
 ;;5.3;scheduling;**263,412**;AUG 13 1993
 ;
 ;
 ;******************************************************************
 ;                             CHANGE LOG
 ;                                               
 ;   DATE                        PATCH                   DESCRIPTION
 ;   ----                        -----                   -----------
 ;   
 ;   
 ;   
 ;
EN ;
 D INIT
 I $$S^%ZTLOAD G END
 D HD
 D SORT
 I $$S^%ZTLOAD G END
 D PRT G:POP END  ;SD*5.3*412 added for early exit
 I $$S^%ZTLOAD G END
 D PRT1
 K ^TMP("SDWLRPS2",$J)
 Q
INIT ;Initialize variables
 ;
 I $D(CT1) S SDWLCT1=CT1
 I $D(CT2) S SDWLCT2=CT2
 I $D(DATE) S SDWLDATE=DATE
 I $D(FORM) S SDWLFORM=FORM
 I $D(INS) S (SDWLINS,SDWLINST)=INS
 I $D(OPEN) S SDWLOPEN=OPEN
 S SDWLPG=0
 I $D(ZTSAVE) D
 .F SDWLI="CT1","CT2","FORM","INS","OPEN" S SDWL="SDWL"_SDWLI,@SDWL=$G(ZTSAVE(SDWLI))
 I SDWLINS="ALL" S SDWLIN("ALL")=""
 S SDWLINST=SDWLINS
 S SDWLTXP=$P(SDWLCT1,U,3)
 I SDWLINS'="ALL" F SDWLI=1:1 S SDWLIN=$P($P(SDWLINS,";",SDWLI),U,1) Q:SDWLIN=""  S SDWLIN(SDWLIN)="",^TMP("SDWLRPS2",$J,"D",1,SDWLIN)=0,^TMP("SDWLRPS2",$J,"D",2,SDWLIN)=0
 I SDWLCT2'="ALL" F SDWLI=1:1 S SDWLCL=$P($P(SDWLCT2,";",SDWLI),U,1) Q:SDWLCL=""  S SDWLCT2(SDWLCL)=""
 S SDWLSCX=$S($P(SDWLCT1,U,1)="T":5,1:6)
 D NOW^%DTC S Y=% D DD^%DT S SDWLDTP=Y
 N POP S POP=0  ;SD*5.3*412
 Q
SORT ;Sort Records
 S SDWLCNT=0
 S SDWLDA=0 F  S SDWLDA=$O(^SDWL(409.3,SDWLDA)) Q:SDWLDA<1  D
 .S SDWLX=$G(^SDWL(409.3,SDWLDA,0)),SDWLERR=0,SDWLDFN=+SDWLX
 .;-Check for Institution Sort
 .I SDWLINS'="ALL" D
 ..I '$D(SDWLIN(+$P(SDWLX,U,3))) S SDWLERR=1 Q
 .S SDWLAPDT=$P(SDWLX,U,16),SDWLOPDT=$P(SDWLX,U,2) S X1=DT,X2=SDWLOPDT D ^%DTC S SDWLDWT=+X  I SDWLDWT<0 S SDWLDWT=0
 .S SDWLTYP=$P(SDWLCT1,U,1),SDWLTYPE=$S(SDWLTYP="T":$P(SDWLX,U,6),1:$P(SDWLX,U,7)) I SDWLTYPE="" S SDWLERR=7 Q
 .S SDWLF=$P(SDWLCT1,U,2)
 .I SDWLCT2'="ALL" D
 ..I '$D(SDWLCT2(SDWLTYPE)) S SDWLERR=3
 .I SDWLTYP="" S SDWLERR=4 Q
 .I $P(SDWLX,U,17)'[SDWLOPEN S SDWLERR=6 Q
 .Q:SDWLERR  D
 ..S SDWLSCC=2 D ELIG^VADPT I $D(VAEL(3)) S SDWLSCN=$P(VAEL(3),U,2) I SDWLSCN>49 S SDWLSCC=1
 ..S:'$D(^TMP("SDWLRPS2",$J,"A",+$P(SDWLX,U,3),SDWLTYPE)) ^(SDWLTYPE)=0
 ..S ^TMP("SDWLRPS2",$J,"A",+$P(SDWLX,U,3),SDWLTYPE)=^(SDWLTYPE)+1
 ..S:'$D(^TMP("SDWLRPS2",$J,"B",+$P(SDWLX,U,3),SDWLTYPE,SDWLDFN)) ^(SDWLDFN)=0 S ^TMP("SDWLRPS2",$J,"B",+$P(SDWLX,U,3),SDWLTYPE,SDWLDFN)=^(SDWLDFN)+1
 ..S:'$D(^TMP("SDWLRPS2",$J,"C",SDWLSCC,+$P(SDWLX,U,3),SDWLTYPE)) ^TMP("SDWLRPS2",$J,"C",SDWLSCC,+$P(SDWLX,U,3),SDWLTYPE)=0
 ..S ^TMP("SDWLRPS2",$J,"C",SDWLSCC,+$P(SDWLX,U,3),SDWLTYPE)=^(SDWLTYPE)+1
 ..S ^TMP("SDWLRPS2",$J,"D",SDWLSCC,+$P(SDWLX,U,3),SDWLTYPE,99999999-SDWLDWT,SDWLDA)=""
 ..S SDWLCNT=SDWLCNT+1,^TMP("SDWLRPS2",$J,"D",SDWLSCC,+$P(SDWLX,U,3))=SDWLCNT
 Q
PRT ;
 S SDWLIN=0 F  S SDWLIN=$O(^TMP("SDWLRPS2",$J,"A",SDWLIN)) Q:SDWLIN=""  W !,"Institution: ",$$GET1^DIQ(4,SDWLIN_",",".01"),! D  Q:POP  ;SD*5.3*412
 .D PRA
 Q
PRA ;
 S SDWLSC=0,(SDWLX,SDWLXT)=0 F  S SDWLSC=$O(^TMP("SDWLRPS2",$J,"A",SDWLIN,SDWLSC)) Q:SDWLSC=""  D  Q:POP  ;SD*5.3*412 added Quit to Exit
 .I '$D(SDWLSCX) S SDWLSCX=0
 .S SDWLX=$G(^TMP("SDWLRPS2",$J,"A",SDWLIN,SDWLSC)),SDWLXT=SDWLXT+SDWLX W !,$$EXTERNAL^DILFD(409.3,SDWLSCX,,SDWLSC),?30,SDWLX
 .S SDWLXTT=0,SDWLDFNX=0 F  S SDWLDFNX=$O(^TMP("SDWLRPS2",$J,"B",SDWLIN,SDWLSC,SDWLDFNX)) Q:SDWLDFNX=""  S SDWLXTT=SDWLXTT+1
 W !,?21,"Total #: ",SDWLXT
 I $D(SDWLSPT) D SCR Q:POP  D HD,HD1  ;SD*5.3*412 added Quit
 Q
PRT1 ;
 N DFN
 S SDWLSCC=0 F  S SDWLSCC=$O(^TMP("SDWLRPS2",$J,"D",SDWLSCC)) Q:SDWLSCC=""  Q:$$S^%ZTLOAD  D  Q:POP  ;SD*5.3*412 added Quit for early exit
 .W !,"******* ",SDWLSCC," *******",!
 .S SDWLINS=0 F  S SDWLINS=$O(^TMP("SDWLRPS2",$J,"D",SDWLSCC,SDWLINS)) Q:SDWLINS=""  D  Q:POP  W !  ;SD*5.3*412 added Quit
 ..W !,$P($G(^DIC(4,SDWLINS,0)),U,1),! I '$G(^TMP("SDWLRPS2",$J,"D",SDWLSCC,SDWLINS)) W !,"*** No Patient Records to Report ***" D:$D(SDWLSPT) SCR Q:POP  D HD,HD1 Q  ;SD*5.3*412 added first Quit
 ..S SDWLSC=0 F  S SDWLSC=$O(^TMP("SDWLRPS2",$J,"D",SDWLSCC,SDWLINS,SDWLSC)) Q:SDWLSC=""  D  Q:POP  ;SD*5.3*412 added Quit
 ...S SDWLWT="" F  S SDWLWT=$O(^TMP("SDWLRPS2",$J,"D",SDWLSCC,SDWLINS,SDWLSC,SDWLWT)) Q:SDWLWT=""  D  Q:POP  ;SD*5.3*412 added Quit
 ....S SDWLDA=0 F  S SDWLDA=$O(^TMP("SDWLRPS2",$J,"D",SDWLSCC,SDWLINS,SDWLSC,SDWLWT,SDWLDA)) Q:SDWLDA=""  D  Q:POP  ;SD*5.3*412 added Quit
 .....S X=$G(^SDWL(409.3,SDWLDA,0)),SDWLODT=$P(X,U,2),SDWLDDT=$P(X,U,16) S DFN=+X D  Q:POP  ;SD*5.3*412 added Quit
 ......D DEM^VADPT,1^VADPT
 ......W !,VA("BID"),?6,$E(VADM(1),1,25) W ?32,$E(SDWLODT,4,5),"/",$E(SDWLODT,6,7),"/",($E(SDWLODT,1,3)+1700)
 ......W ?47,$J(99999999-SDWLWT,5)
 ......D:$D(SDWLSPT) SCR Q:POP  D HD,HD1  ;SD*5.3*412 added Quit
 .W !
LINE ;Draw Line
 W !,"_______________________________________________________________________________"
 Q
SCR W ! S DIR(0)="E" D ^DIR S:X="^" POP=1 ; SD*5.3*412
 Q
HD ;Header
 W:$D(IOF) @IOF W !,SDWLDTP,?80-$L("PCMM ASSIGNMENT Wait List Report")\2,"PCMM ASSIGNMENT Wait List Report"
 S SDWLPG=SDWLPG+1 W ?72,"Page: ",SDWLPG
 W !!,?30,"Institution: " D
 .F I=1:1 S X=$P(SDWLINST,";",I) Q:X=""  W:I>1 ! W ?45,$$GET1^DIQ(4,X_",",".01")
 S X=$P(SDWLCT2,U,2)
 W !?27,"Report Category: ",$S($P(SDWLCT1,U,1)="T":"TEAM",1:"POSITION") I X="ALL" W " ALL"
 I X'="ALL" D
 .F I=1:1 S X=$P($P(SDWLCT2,";",I),"^",2) Q:X=""  W !,?45,X
 S X=$G(SDWLOPEN) W !,?36,"Status: ",$S(SDWLOPEN="O":"Open",1:"All")
 S X=$G(SDWLFORM) W !,?28,"Output Format: ",$S(SDWLFORM="S":"Summary",1:"Detailed")
 Q
HD1 ;
 W !!,"Name",?30,"Date Entered",?45,"# of Days Waiting",!!
 Q
END K X1,X2,CT1,CT2,DATE,I,INS,OPEN,FORM
 K ^TMP("SDWLRPS2",$J)
 Q
