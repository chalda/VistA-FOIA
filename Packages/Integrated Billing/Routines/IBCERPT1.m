IBCERPT1 ;ALB/JEH - ELECTRONIC REPORT DISPOSITION ;21-FEB-01
 ;;2.0;INTEGRATED BILLING;**137**;21-MAR-1994
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
EN ; -- main entry
 D EN^VALM("IBCE ELEC REPORT DISP")
 Q
 ;
INIT ; -- set up variables
 S U="^"
 D BLD
 Q
 ;
BLD ; -- build list of reports
 N IBI,IBREC,IBDESC,IBDISP,IBREP,NUMBER,IBCNT,IBIEN,X
 S VALMCNT=0
 K ^TMP("IBREP DISP",$J),^TMP("IBREP DISP1",$J)
 S IBI=0,IBREP="",IBCNT=0
 F  S IBREP=$O(^IBE(361.2,"B",IBREP)) Q:IBREP=""  F  S IBI=$O(^IBE(361.2,"B",IBREP,IBI)) Q:'IBI  S IBCNT=IBCNT+1,IBREC=$G(^IBE(361.2,IBI,0)),^TMP("IBREP DISP",$J,IBCNT)=IBI_U_$P(IBREC,U)_U_$P(IBREC,U,2)_U_$P(IBREC,U,3)
 ;
 S IBCNT=0
 I '$D(^TMP("IBREP DISP",$J)) D
 . S (IBCNT,VALMCNT)=2
 . S ^TMP("IBREP DISP1",$J,1,0)=" "
 . S ^TMP("IBREP DISP1",$J,2,0)="No reports available for dispositioning"
 S IBI=0 F  S IBI=$O(^TMP("IBREP DISP",$J,IBI)) Q:'IBI  S IBREC=^(IBI) D
 . S IBCNT=IBCNT+1,X=""
 . S IBIEN=+$P(IBREC,U)
 . S X=$$SETFLD^VALM1(IBCNT,X,"NUMBER")
 . S X=$$SETFLD^VALM1($P(IBREC,U,2),X,"REPORT")
 . S X=$$SETFLD^VALM1($P(IBREC,U,4),X,"DESC")
 . S X=$$SETFLD^VALM1($$EXPAND^IBTRE(361.2,.02,+$P(IBREC,U,3)),X,"DISP")
 . D SET(X)
 Q
 ;
SET(X) ;list manager screen
 S VALMCNT=VALMCNT+1
 S ^TMP("IBREP DISP1",$J,VALMCNT,0)=X
 S ^TMP("IBREP DISP1",$J,"IDX",VALMCNT,IBCNT)=""
 S ^TMP("IBREP DISP1",$J,IBCNT)=VALMCNT_U_IBIEN
 Q
EDIT ;
 N IBDA,DIE,DA,DR,Y
 D FULL^VALM1
 S IBDA=$$SEL(.IBDA)
 I 'IBDA G EDITQ
 S DIE="^IBE(361.2,",DR=".02"
 S IBDA=0 F  S IBDA=$O(IBDA(IBDA)) Q:'IBDA!($D(Y)>0)  D
 . S DA=$P(IBDA(IBDA),U) W !,"REPORT: "_$P(^IBE(361.2,DA,0),U)_"//"
 . D ^DIE W !
 D BLD
EDITQ S VALMBCK="R"
 Q
EXIT ; -- clean up and exit
 K ^TMP("IBREP DISP",$J),^TMP("IBREP DISP1",$J)
 D CLEAN^VALM10
 Q
 ;
HDR ;
 Q
SEL(IBDA) ;Select entry from list
 N IBZ,VALMY
 D EN^VALM2($G(XQORNOD(0)))
 S (IBZ,IBDA)=0 F  S IBDA=$O(VALMY(IBDA)) Q:'IBDA  S IBZ=IBZ+1,IBDA(IBDA)=$P($G(^TMP("IBREP DISP1",$J,IBDA)),U,2)
 Q IBZ
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
