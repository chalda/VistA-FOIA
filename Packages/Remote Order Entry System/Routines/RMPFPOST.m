RMPFPOST ;DDC/KAW-POSTINIT FOR ROES V2.0 [ 06/16/95   3:06 PM ]
 ;;2.0;REMOTE ORDER/ENTRY SYSTEM;;JUN 16, 1995
 W !!,"Adding server mail groups ."
PT0 S (AB,XY)="",X="RMPF-FILE-UPDATE" W "."
 S AB=$O(^XMB(3.8,"B",X,0)) G PT1:AB
 S DIC="^XMB(3.8,",DIC(0)="L",DLAYGO=3.8
 S DIC("DR")="4////PU" K DD,DO D FILE^DICN
 I Y=-1 W !!,"MAIL GROUP NOT ADDED:  RMPF-FILE-UPDATE" G POST1
 S AB=+Y
PT1 S XY=$O(^XMB(3.6,"B","RMPF-FILE-UPDATE",0)) W "." G PT2:XY
 S DIC="^XMB(3.6,",DIC(0)="L",DLAYGO=3.6 K DD,DO D FILE^DICN
 I Y=-1 W $C(7),!!,"BULLETIN NOT ADDED: RMPF-FILE-UPDATE" G POST2
 S (XY,DA(1))=+Y,DIC="^XMB(3.9,"_XY_",2,",DIC(0)="L",DLAYGO=3.6
 S X=AB K DD,DO D FILE^DICN
PT2 S DA=$O(^DIC(19,"B","RMPF-FILE-UPDATE",0)) W "." G PST0:'DA
 S DIE="^DIC(19,",DR="220////"_XY_";222////"_AB D ^DIE
PST0 S (AB,XY)="",X="RMPF ROES UPDATES (ASPS)" W "."
 S AB=$O(^XMB(3.8,"B",X,0)) G PST1:AB
 S DIC="^XMB(3.8,",DIC(0)="L",DLAYGO=3.8
 S DIC("DR")="4////PU" K DD,DO D FILE^DICN
 I Y=-1 W !!,"MAIL GROUP NOT ADDED:  RMPF ROES UPDATES (ASPS)" G POST1
 S AB=+Y
PST1 S XY=$O(^XMB(3.6,"B","RMPFMESSAGE (ASPS)",0)) W "." G PST2:XY
 S DIC="^XMB(3.6,",DIC(0)="L",DLAYGO=3.6 K DD,DO D FILE^DICN
 I Y=-1 W $C(7),!!,"BULLETIN NOT ADDED: RMPFMESSAGE (ASPS)" G POST2
 S (XY,DA(1))=+Y,DIC="^XMB(3.9,"_XY_",2,",DIC(0)="L",DLAYGO=3.6
 S X=AB K DD,DO D FILE^DICN
PST2 S DA=$O(^DIC(19,"B","RMPFLOADMESSAGE(ASPS)",0)) W "." G POST0:'DA
 S DIE="^DIC(19,",DR="220////"_XY_";222////"_AB D ^DIE
POST0 S (AB,XY)="",X="RMPF ROES UPDATES (PSAS)" W "."
 S AB=$O(^XMB(3.8,"B",X,0)) G POST1:AB
 S DIC="^XMB(3.8,",DIC(0)="L",DLAYGO=3.8
 S DIC("DR")="4////PU" K DD,DO D FILE^DICN
 I Y=-1 W !!,"MAIL GROUP NOT ADDED:  RMPF ROES UPDATES" G POST1
 S AB=+Y
POST1 S XY=$O(^XMB(3.6,"B","RMPFMESSAGE (PSAS)",0)) W "." G POST2:XY
 S DIC="^XMB(3.6,",DIC(0)="L",DLAYGO=3.6 K DD,DO D FILE^DICN
 I Y=-1 W $C(7),!!,"BULLETIN NOT ADDED" G POST2
 S (XY,DA(1))=+Y,DIC="^XMB(3.9,"_XY_",2,",DIC(0)="L",DLAYGO=3.6
 S X=AB K DD,DO D FILE^DICN
POST2 S DA=$O(^DIC(19,"B","RMPFLOADMESSAGE(PSAS)",0)) W "." G MENU:'DA
 S DIE="^DIC(19,",DR="220////"_XY_";222////"_AB D ^DIE
MENU S X=$O(^DIC(19,"B","RMPF O/E STATION ASPS",0)) G MENU1:'X
 S DIE="^RMPF(791810.5,",DA=1,DR=".03////"_X D ^DIE
MENU1 S X=$O(^DIC(19,"B","RMPF O/E STATION PSAS",0)) G ORDER:'X
 S DIE="^RMPF(791810.5,",DA=2,DR=".03////"_X D ^DIE
ORDER K ^DD(791810.0101,0,"NM","TRANSACTION") G ^RMPFPOSU
