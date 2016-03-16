; ----------------------------------------------------
; VLCPortable
; ----------------------------------------------------
; Par fat115
; Utilisant comme base de travail les scripts de John T. Haller et Sarkos et pyg
; License : GPL
; Ce script permet de créer le lanceur de VLCPortable.
; Compiler: NSIS (http://www.nullsoft.com).
; Require plugins: newadvsplash
; $id=VLCPortable.nsi $date=2011-05-06
; ----------------------------------------------------
;Copyright (C) 2005-2011 Framakey

;Website: http://www.framakey.org

;This software is OSI Certified Open Source Software.
;OSI Certified is a certification mark of the Open Source Initiative.

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with this program; if not, write to the Free Software
;Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA	02110-1301, USA.
; ----------------------------------------------------
; Général
; ---- Modifiez les valeurs souhaitées ----
; Définition variables entête
!define APPLANG "French"
!searchparse /file "..\..\App\AppInfo\appinfo.ini" `AppID=` FULLNAME
!searchparse /file "..\..\App\AppInfo\appinfo.ini" `PackageVersion=` VER
!searchparse /file "..\..\App\AppInfo\appinfo.ini" `Description=` SUBTITLE
!searchparse /file "..\..\App\AppInfo\appinfo.ini" `License=` LICENSE
!searchreplace APPNAME ${FULLNAME} "Portable" ""
!define LAUNCHVER "01" ;Version du lanceur
!define SCRIPTVER "1.0.0.1" ;Version du script du lanceur
!define PROJECT "Framakey" ;Nom du projet
!define COMPANY "Framakey.org" ;Nom du groupe développant le projet
!define WEBSITE "http://www.framakey.org"
!define DEFAULTEXE "vlc.exe"
!define DEFAULTAPPDIR "App\VLC"
!define DEFAULTDATADIR "Data\settings"
!define MUTEXNAME "${FULLNAME}_${VER}"

; ----------------------------------------------
; --- Options : décommentez pour application ---
; ----------------------------------------------
; copie et sauvegarde/restauration automatique du dossier %APPDATA%\Nom_de_l_appli\.
!define APPDATABACKUP 

; pour les applications basée sur Mozilla, il est nécessaire de mettre en place
; une boucle de vérification à cause d'une relance automatique
; !define MOZLOOP

; met en place un flag pour création d'un lanceur à partir d'un
; media en lecture seule
; !define READONLYL

/*----------------------------------------------------------------
		Définition du format de la chaine de lancement
------------------------------------------------------------------
Le define suivant vous permet de configurer la chaine d'exécution 
et donc, entre autres, l'ordre des paramètres et d'éventuels
paramètres "obligatoires".
Pour info :
$AppDirectory => le dossier de l'exécutable (cf DEFAULTAPPDIR)
$AppExecutable => le nom de l'exécutable (cf DEFAULTEXE)
$DataDirUnified => le dossier réellement utilisé pour les données
	Il peut être différent de $DataDir pour une appli en lecture
	seule par exemple ($PLUGINSDIR\${FULLNAME})
$Parameters => les paramètres passés au lanceur
$AdditionalParameters => les paramètres du fichier INI
Exemple : la chaine de lancement du FramaKiosk =>
`"$AppDirectory\$AppExecutable" -profilesDir "$DataDirUnified" -webapp $Parameters $AdditionalParameters "$EXEDIR\Data\FramaKiosk\index.html"`
----------------------------------------------------------------*/
!define EXECSTRING `"$AppDirectory\$AppExecutable" $Parameters $AdditionalParameters `

/*----------------------------------------------------
	Compilation conditionnelle : lecture seule
----------------------------------------------------*/
!ifdef READONLYL
Caption "${FULLNAME} - Edition CD/DVD - ${SUBTITLE}"
OutFile "..\..\${FULLNAME}_RO.exe"
!else
Caption "${FULLNAME} - ${SUBTITLE}"
OutFile "..\..\${FULLNAME}.exe"
!endif

; ----------------------------------------------------------------
; ---- à partir de là, vous n'avez normalement rien à modifier ---
; ----------------------------------------------------------------

; Nom de l'exécutable
Name "${FULLNAME}"

; Icone
Icon "..\..\App\AppInfo\appicon.ico"
WindowIcon Off

; Options de Compilation
CRCCheck On
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user

; Compression Optimale
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On

; ----------------------------------------------------
; Liste des includes
;(Standard NSIS)
!include FileFunc.nsh
!include LogicLib.nsh

; Personnalisées
!include "${FULLNAME}Lang_${APPLANG}.nsh"

; ----------------------------------------------------
; Informations de Version

VIProductVersion "${VER}"
VIAddVersionKey ProductName "${FULLNAME}"
VIAddVersionKey FileDescription "${FILEDESCRIPTIONTEXT}"
VIAddVersionKey LegalTrademarks "${LEGALTRADEMARKSTEXT}"
VIAddVersionKey LegalCopyright "${LEGALCOPYRIGHTTEXT}"
VIAddVersionKey Comments "${COMMENTSTEXT}"
VIAddVersionKey CompanyName "${COMPANY}"
VIAddVersionKey OriginalFilename "${FULLNAME}.exe"
VIAddVersionKey InternalName "${FULLNAME}-${VER}-r${LAUNCHVER}"
VIAddVersionKey FileVersion "${SCRIPTVER}"

; ----------------------------------------------------
; Variables

Var AppDirectory
Var AppExecutable
Var DataDir
Var Parameters
Var AdditionalParameters
Var DisableSplashScreen
Var DataDirUnified

; ----------------------------------------------------
; Sections

Section "Main"

/*----------------------------------------------------
          Définition/Récupération des valeurs
----------------------------------------------------*/

; Récupération des paramètres passés au lanceur (par exemple par CAFE)
	${GetParameters} $Parameters

; Définition des valeurs par défaut des paramètres
	StrCpy "$DisableSplashScreen" "false"
	StrCpy "$AppDirectory" "$EXEDIR\${DEFAULTAPPDIR}"
	StrCpy "$AppExecutable" "${DEFAULTEXE}"
	StrCpy "$DataDir" "$EXEDIR\${DEFAULTDATADIR}"
	StrCpy "$AdditionalParameters" ""

; S'il existe un fichier INI, on remplace les valeurs par défaut par les valeurs définies
	${If} ${FileExists} "$EXEDIR\${FULLNAME}.ini"
		ReadINIStr $0 "$EXEDIR\${FULLNAME}.ini" "${FULLNAME}" "DisableSplashScreen"
			StrCmp $0 "" +2 0
				StrCpy "$DisableSplashScreen" "$0"
		ReadINIStr $0 "$EXEDIR\${FULLNAME}.ini" "${FULLNAME}" "${APPNAME}Directory"
			StrCmp $0 "" +2 0
				StrCpy "$AppDirectory" "$EXEDIR\$0"
		ReadINIStr $0 "$EXEDIR\${FULLNAME}.ini" "${FULLNAME}" "${APPNAME}Executable"
			StrCmp $0 "" +2 0
				StrCpy "$AppExecutable" "$0"
		ReadINIStr $0 "$EXEDIR\${FULLNAME}.ini" "${FULLNAME}" "SettingsDirectory"
			StrCmp $0 "" +2 0
				StrCpy "$DataDir" "$EXEDIR\$0"
		ReadINIStr $0 "$EXEDIR\${FULLNAME}.ini" "${FULLNAME}" "AdditionalParameters"
			StrCmp $0 "" +2 0
				StrCpy "$AdditionalParameters" "$0"
		ClearErrors
	${EndIf}

/*-------------------------------------------------------
Compilation conditionnelle : définition de DataDirUnified
-------------------------------------------------------*/
!ifdef APPDATABACKUP
	StrCpy $DataDirUnified "$APPDATA\${APPNAME}"
!else
	!ifdef READONLYL
		StrCpy $DataDirUnified"$PLUGINSDIR\${FULLNAME}"
	!else
		StrCpy $DataDirUnified $DataDir
	!endif
!endif

/*----------------------------------------------------
				Vérifications
----------------------------------------------------*/

; Si l'exécutable est introuvable
	${IfNot} ${FileExists} "$AppDirectory\$AppExecutable"
		MessageBox MB_OK|MB_ICONEXCLAMATION `${NOEXEMSG}`
		Quit
	${EndIf}

; Si la version portable est déjà lancée : on lance directement
	System::Call 'kernel32::OpenMutexA(i 0x00020000, i 0, t "${MUTEXNAME}") i .r1 ?e'
	${If} $1 <> 0
		Exec '${EXECSTRING}'
		Quit
	${EndIf}

; Si la version locale est déjà lancée
	FindProcDLL::FindProc "${DEFAULTEXE}"
	${If} $R0 = 1
		MessageBox MB_OK|MB_ICONEXCLAMATION `${FOUNDPROCESSMSG}`
		Quit
	${EndIf}

; on teste s'il faut afficher le splashscreen
	${If} $DisableSplashScreen != "true"
		; Affiche le splash screen
		File /oname=$PLUGINSDIR\splash.jpg "${FULLNAME}_splash.jpg"
		newadvsplash::show /NOUNLOAD 2000 200 200 -1 /L $PLUGINSDIR\splash.jpg
		Sleep 500
	${EndIf}

/*----------------------------------------------------
	Compilation conditionnelle : recopie de $DataDir
----------------------------------------------------*/

!ifdef APPDATABACKUP
; Sauvegarde des préférences de l'application locale
	${If} ${FileExists} "$APPDATA\${APPNAME}\*.*"
		Rename "$APPDATA\${APPNAME}" "$APPDATA\${APPNAME}-BackupBy${FULLNAME}"
	${EndIf}
!endif
!ifdef APPDATABACKUP | READONLYL
; Copie des préférences de l'application portable
	CreateDirectory "$DataDirUnified"
	CopyFiles /SILENT "$DataDir\*.*" "$DataDirUnified"
!endif

/*----------------------------------------------------
					Exécution
----------------------------------------------------*/

; Première instance portable : on crée un mutex
	System::Call 'kernel32::CreateMutexA(i 0, i 0, t "${MUTEXNAME}") i .r1 ?e'
; Lancement de l'application
	SetOutPath "$AppDirectory"
	ExecWait '${EXECSTRING}'

/*----------------------------------------------------
	Compilation conditionnelle : boucle MOZILLA
----------------------------------------------------*/

!ifdef MOZLOOP
; boucle de vérification pour les applis Mozilla
	${Do}
		Sleep 1000
		FindProcDLL::FindProc "$AppExecutable"
	${LoopUntil} $R0 = 0
!endif

/*----------------------------------------------------
Compilation conditionnelle : permutation dans APPDATA
----------------------------------------------------*/

!ifdef APPDATABACKUP
	!ifndef READONLYL
	; enregistrement des préférences portables
		RMDir /r "$DataDir"
		CreateDirectory "$DataDir"
		CopyFiles /SILENT "$APPDATA\${APPNAME}\*.*" "$DataDir\"
	!endif
; restauration des préférences fixes
	RMDir /r "$APPDATA\${APPNAME}"
	Rename "$APPDATA\${APPNAME}-BackupBy${FULLNAME}" "$APPDATA\${APPNAME}"
!endif

/*----------------------------------------------------
			Déchargement du splashscreen
----------------------------------------------------*/
	${If} ${FileExists} "$PLUGINSDIR\splash.jpg"
		newadvsplash::stop /WAIT
	${EndIf}

SectionEnd

Function .onInit
    InitPluginsDir
FunctionEnd



