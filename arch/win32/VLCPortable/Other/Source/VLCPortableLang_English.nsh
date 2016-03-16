; ----------------------------------------------------
; VLCPortable : Lang en_EN
; ----------------------------------------------------
; Author: sarkos, modified by fat115
; License: GPL
; This script allows to include english translation into the launcher.
; Compiler: NSIS (http://nsis.sourceforge.net).
; $id=VLCPortableLang_English.nsh $date=2011-02-23
; ----------------------------------------------------
; Copyright (C) 2005-2011 Framakey Team
; Website: http://www.framakey.org
; ----------------------------------------------------
; Translated version informations

!define FILEDESCRIPTIONTEXT "${FULLNAME} for FramaKey"
!define LEGALTRADEMARKSTEXT "${PROJECT} by ${COMPANY}"
!define LEGALCOPYRIGHTTEXT "2005-2011 ${COMPANY}-${LICENSE}"
!define COMMENTSTEXT "Allows ${APPNAME} (${APPLANG}) to be run from a removable drive.  For additional details, visit ${WEBSITE}"

; ----------------------------------------------------
; Translated dialog box messages

!define NOEXEMSG `Unable to find "$AppExecutable". Please check your settings.`
!define NODATADIRMSG `Unable to find the data folder "$EXEDIR\$DataDir". Please check your settings.`
!define FOUNDPROCESSMSG "Another ${APPNAME} instance is already launched."

; ----------------------------------------------------
; Script End