; ----------------------------------------------------
; VLCPortable : Lang fr_FR
; ----------------------------------------------------
; Author: sarkos, modifi� par fat115
; License: GPL
; Ce script permet d'inclure la traduction en fran�ais dans le lanceur.
; Compiler: NSIS (http://nsis.sourceforge.net).
; $id=VLCPortableLang_French.nsh $date=2011-02-23
; ----------------------------------------------------
; Copyright (C) 2005-2011 Framakey Team
; Website: http://www.framakey.org
; ----------------------------------------------------
; Traduction des informations de version

!define FILEDESCRIPTIONTEXT "${FULLNAME} pour FramaKey"
!define LEGALTRADEMARKSTEXT "${PROJECT} par ${COMPANY}"
!define LEGALCOPYRIGHTTEXT "2005-2011 ${COMPANY}-${LICENSE}"
!define COMMENTSTEXT "Permet de lancer ${APPNAME} (${APPLANG})depuis un disque amovible. Pour plus de d�tails, visitez ${WEBSITE}"

; ----------------------------------------------------
; Traduction des messages de boite de dialogue

!define NOEXEMSG `"$AppExecutable" est introuvable. Merci de v�rifier votre configuration.`
!define NODATADIRMSG `Le dossier des donn�es "$EXEDIR\$DataDir" est introuvable. Merci de v�rifier votre configuration.`
!define FOUNDPROCESSMSG "Une autre instance de ${APPNAME} est d�j� lanc�e."

; ----------------------------------------------------
; Fin du script