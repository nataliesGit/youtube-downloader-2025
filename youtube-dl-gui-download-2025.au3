#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=data\ico3.ico
#AutoIt3Wrapper_Res_Icon_Add=data\ico3.ico
#AutoIt3Wrapper_Res_File_Add=data\wordle.JPG
#AutoIt3Wrapper_Res_File_Add=data\yt-dlp.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <WinAPIFiles.au3>
#include <File.au3>
#include <SQLite.au3>
#include <SQLite.dll.au3>
#Include <Array.au3>
#include <GuiComboBox.au3>
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <StringConstants.au3>
#include <Inet.au3>
#include <GUIConstants.au3>
#include <WinAPISys.au3>
#include <NetShare.au3>
#include <GuiComboBox.au3>
#include <Date.au3>
#include <DateTimeConstants.au3>

Local $bFileInstall = true
Global $picture,$youtubedl
if $bFileInstall Then
	If Not FileExists("c:\tempYoutube-dl\") Then
		DirCreate("c:\tempYoutube-dl\")
		DirCreate("c:\tempYoutube-dl\data\")
		FileInstall("data\logo.JPG","C:\tempYoutube-dl\data\logo.JPG")
		FileInstall("data\ico3.ico","C:\tempYoutube-dl\data\ico3.ico")
		FileInstall("data\yt-dlp.exe","C:\tempYoutube-dl\data\yt-dlp.exe")

	EndIf
	$picture = "c:\tempYoutube-dl\data\logo.JPG"
	$youtubedl = "c:\tempYoutube-dl\data\yt-dlp.exe"
	$icon = "c:\tempYoutube-dl\data\ico3.ico"


Else
	$picture = @ScriptDir & "\data\logo.JPG"
	$youtubedl = @ScriptDir & "\data\yt-dlp.exe"
	$icon =  @ScriptDir & "\data\ico3.ico"
EndIf

#Region ### START Koda GUI section ### Form=c:\_natalie_eigene\youtube-dll-gui\youtube-dll.kxf
$Form1 = GUICreate("youtube-dl", 541, 487, 274, 122)
$Pic1 = GUICtrlCreatePic($picture, 296, 16, 215, 214)
GUISetIcon($icon, -1)
$mInfo = GUICtrlCreateMenu("Info")
$mVerteiler = GUICtrlCreateMenuItem("Info zu diesem Tool", $mInfo)
$mAutoitLink = GUICtrlCreateMenuItem("Autoit Webseite", $mInfo)


$Label1 = GUICtrlCreateLabel("Download Youtube Video", 24, 16, 184, 22)
GUICtrlSetFont(-1, 12, 400, 0, "Bauhaus 93")
GUICtrlSetColor(-1, 0x808080)
$radioTextfile = GUICtrlCreateRadio("Liste aus Datei", 24, 56, 89, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$radioPublic = GUICtrlCreateRadio("oeffentlich", 24, 80, 113, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$radioPrivate = GUICtrlCreateRadio("privat", 24, 104, 113, 17)
$Label2 = GUICtrlCreateLabel("Speicherort", 56, 211, 58, 17)
$buttonSpeicherort = GUICtrlCreateButton(" ... ", 24, 208, 27, 25)
$labelSpeicher = GUICtrlCreateLabel("c:\temp", 24, 240, 490, 17)
$Label4 = GUICtrlCreateLabel("Adresse (URL)", 24, 277, 73, 17)
$editUrl = GUICtrlCreateEdit("", 24, 304, 489, 49)
GUICtrlSetData(-1, StringFormat("URL hier einfügen"))
$checkboxProxy = GUICtrlCreateCheckbox("Proxy", 24, 360, 97, 17)
$inputProxy = GUICtrlCreateInput("1590.schueler01:test12345@10.86.5.16:8080", 24, 384, 489, 21)
GUICtrlSetTip(-1, "nutzer:Passwort@10.86.5.16:8080 oder ohne Authentifizierung: 127.0.0.1:3128")

$buttonStart = GUICtrlCreateButton("START", 440, 424, 75, 25)
$labelNutzer = GUICtrlCreateLabel("Nutzer", 24, 136, 35, 17)
$labelPasswort = GUICtrlCreateLabel("Passwort", 24, 168, 47, 17)
$inputNutzer = GUICtrlCreateInput("natalie.goerke@gmail.com", 72, 132, 177, 21)
GUICtrlSetTip(-1, "nutzername@web.de - abhaengig vom email Provider für Youtube")

$passStyle = BitOr($ES_PASSWORD, $GUI_SS_DEFAULT_INPUT )
Global $inputPasswort = GUICtrlCreateInput("xxxxxxxx", 73, 164, 177, 21,$passStyle,0)

$checkboxSound = GUICtrlCreateCheckbox("nur Sound", 296, 274, 97, 17)
$buttonVerzeichnis = GUICtrlCreateButton("oeffne Verzeichnis", 24, 424, 107, 25)
$buttonDatei = GUICtrlCreateButton(" ... ", 115, 50, 27, 25)
$labelDatei = GUICtrlCreateLabel("Auswahl Datei", 146, 57, 104, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###



Global $downloadArt, $speicherOrt, $nurSound, $liste
Global $command
Global $Clear1, $Clear2, $Clear3, $Clear4 = 0
init()

Func init()
	hideLogin()
	GUICtrlSetState($inputProxy,$GUI_HIDE)
	GUICtrlSetState($buttonDatei,$GUI_HIDE)
	GUICtrlSetState($labelDatei,$GUI_HIDE)
	If Not FileExists("c:\temp\") Then
		DirCreate("c:\temp\")
	EndIf
	$speicherOrt = "c:\temp"
	$downloadArt = "publicList"
EndFunc

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $mAutoitLink
			Run(@ComSpec & " /c Start https://www.autoitscript.com/site/autoit/")
		Case $buttonVerzeichnis
			Run("C:\WINDOWS\EXPLORER.EXE /n,/e," & $speicherOrt)

		Case $mVerteiler
						MsgBox(64, "Info", "Tool zum Download von youtube Videos." & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"" & @CRLF & _
						"dies ist eine GUI für yt-dlp.exe und wurde mit Autoit erstellt." & @CRLF & _
						""&@CRLF&@CRLF&@CRLF&"Natalie Scheuble, November 2018")
		Case $GUI_EVENT_CLOSE
			cleanup()
			Exit
		case $buttonSpeicherort
			selectFolder()
		case $buttonDatei
			selectListe()
		case $radioPrivate
			checkDownloadArt()
;~ 		case $radioEinzel
;~ 			checkDownloadArt()
		case $radioPublic
			checkDownloadArt()
		case $radioTextfile
			checkDownloadArt()
		case $checkboxSound
			if GUICtrlRead($checkboxSound) = 1 Then
				$nurSound = 1
			Else
				$nurSound = 0
			EndIf
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle", $nurSound)
		case $checkboxProxy
;~ 			MsgBox($MB_SYSTEMMODAL, "Kontrolle", GUICtrlRead($checkboxProxy))
			if GUICtrlRead($checkboxProxy) = 4 Then
				GUICtrlSetState($inputProxy,$GUI_HIDE)
			Else
				GUICtrlSetState($inputProxy,$GUI_SHOW)
			EndIf
		case $buttonStart
			runCommands()
	EndSwitch

;~ 		Felder werden bei Fokus geleert
	    If _IsFocused ($Form1, $inputPasswort) And $Clear1 = 0 Then
			 GUICtrlSetData ($inputPasswort, "")
			 $Clear1 = 1
		 ElseIf $Clear1 = 1  And Not _IsFocused ($Form1, $inputPasswort) Then
			$Clear1 = 0
		 EndIf

	    If _IsFocused ($Form1, $inputNutzer) And $Clear2 = 0 Then
			 GUICtrlSetData ($inputNutzer, "")
			 $Clear2 = 1
		 ElseIf $Clear2 = 1  And Not _IsFocused ($Form1, $inputNutzer) Then
			$Clear2 = 0
		 EndIf

	    If _IsFocused ($Form1, $inputProxy) And $Clear3 = 0 Then
			 GUICtrlSetData ($inputProxy, "")
			 $Clear3 = 1
		 ElseIf $Clear3 = 1  And Not _IsFocused ($Form1, $inputProxy) Then
			$Clear3 = 0
		 EndIf

	    If _IsFocused ($Form1, $editUrl) And $Clear4 = 0 Then
			 GUICtrlSetData ($editUrl, "")
			 $Clear4 = 1
		 ElseIf $Clear4 = 1  And Not _IsFocused ($Form1, $editUrl) Then
			$Clear4 = 0
		 EndIf
WEnd

Func _IsFocused($hWnd, $nCID)
    Return ControlGetHandle($hWnd, '', $nCID) = ControlGetHandle($hWnd, '', ControlGetFocus($hWnd))
EndFunc   ;==>_IsFocused

func hideLogin()
	GUICtrlSetState($labelNutzer,$GUI_HIDE)
	GUICtrlSetState($labelPasswort,$GUI_HIDE)
	GUICtrlSetState($inputNutzer,$GUI_HIDE)
	GUICtrlSetState($inputPasswort,$GUI_HIDE)
EndFunc
func showLogin()
	GUICtrlSetState($labelNutzer,$GUI_SHOW)
	GUICtrlSetState($labelPasswort,$GUI_SHOW)
	GUICtrlSetState($inputNutzer,$GUI_SHOW)
	GUICtrlSetState($inputPasswort,$GUI_SHOW)
EndFunc
func showDateiwahl()
	GUICtrlSetState($buttonDatei,$GUI_SHOW)
	GUICtrlSetState($labelDatei,$GUI_SHOW)
EndFunc
func hideDateiwahl()
	GUICtrlSetState($buttonDatei,$GUI_HIDE)
	GUICtrlSetState($labelDatei,$GUI_HIDE)
EndFunc


func checkDownloadArt()
;~   if GUICtrlRead($radioEinzel) = 1 Then
;~ 	  $downloadArt = "einzel"
;~ 	  hideLogin()
;~   EndIf
  if GUICtrlRead($radioPublic) = 1 Then
	  $downloadArt = "publicList"
	  hideLogin()
	  hideDateiwahl()
  EndIf
  if GUICtrlRead($radioPrivate) = 1 Then
	  $downloadArt = "privateList"
	  showLogin()
	  hideDateiwahl()
  EndIf

  if GUICtrlRead($radioTextfile) = 1 Then
	  $downloadArt = "textfile"
	  hideLogin()
	  showDateiwahl()
  endIf


endFunc

func selectFolder()
	$speicherOrt = FileSelectFolder("Speicherort waehlen","C:\")
	GUICtrlSetData($labelSpeicher,$speicherOrt)
EndFunc
func selectListe()
	$liste = FileOpenDialog("Auswahl einer Textdatei (mit Dateiendung 'txt')", @WindowsDir & "\", "Textdatei (*.txt)")
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle", $liste)
	$temp = StringSplit ( $liste, "\")
;~ 	_ArrayDisplay($temp)
	$lastElement = $temp[UBound($temp)-1]
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle", $lastElement)
	GUICtrlSetData($labelDatei,$lastElement)
EndFunc


func runCommands()
;~ 	$url = "https://www.youtube.com/watch?v=2HeEEQi4PEQ&t=109s"
;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle", $url)
;~ 	$DOS = Run(@ComSpec & ' /c yt-dlp.exe  -ci --console-title '&$url, "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
;~ 	ProcessWaitClose($DOS)
;~ 	$Message = StdoutRead($DOS)
;~ 	MsgBox($MB_SYSTEMMODAL, "cmd output", $Message)

;~ 	----------------- Zusammenbauen des youtube-dl strings -------------------------------------
	$speicherOrt = GUICtrlRead($labelSpeicher)
;~ 	MsgBox($MB_SYSTEMMODAL, "speicher", StringLen($speicherOrt))
	if StringLen($speicherOrt) = 3 Then
		MsgBox($MB_SYSTEMMODAL, "Info", "Bitte Ordner als Speicherort angeben")
	Else
		$proxy = GUICtrlRead($inputProxy)
		$proxy = '"'&$proxy&'"'
		$url = GUICtrlRead($editUrl)
		$url = '"'&$url&'"'
		$nutzer = GUICtrlRead($inputNutzer)
		$pass = GUICtrlRead($inputPasswort)




		$creds = " -u "&$nutzer&" -p "&$pass
	;~ 	if $speicherOrt = "" then $speicherOrt ="c:\temp"
		$speicherOrt = StringReplace ( $speicherOrt, "\\", "\")   ;für den Fall dass root von Laufwerk angegeben wird, dann kommt zu E:\\Ergebnis_dd.mm.yyyy\
		$speicherOrt = '"'&$speicherOrt&'"'
	;~ 	MsgBox($MB_SYSTEMMODAL, "Kontrolle $speicherOrt", $speicherOrt)
		$out = $speicherOrt&"/%(title)s.%(ext)s"

		if $downloadArt = "publicList" Then
			if GUICtrlRead($checkboxProxy) = 1 Then
				$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&' -ci --console-title '&$url
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&'  -f bestaudio -ci --console-title '&$url
				EndIf
			Else   ;-ohne proxy
				$command = $youtubedl&' --update -o '&$out&' -ci --console-title '&$url
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&'  -f bestaudio -ci --console-title '&$url
				EndIf
			EndIf
		EndIf


		if $downloadArt = "privateList" Then
			if GUICtrlRead($checkboxProxy) = 1 Then
				$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&$creds&' -ci --console-title '&$url
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&$creds&'  -f bestaudio -ci --console-title '&$url
				EndIf
			Else   ;-ohne proxy
				$command = $youtubedl&' --update -o '&$out&$creds&' -ci --console-title '&$url
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&$creds&'  -f bestaudio -ci --console-title '&$url
				EndIf
			EndIf
		EndIf
		if $downloadArt = "textfile" Then
			$liste = '"'&$liste&'"'
			if GUICtrlRead($checkboxProxy) = 1 Then
				$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&' -ci --console-title -a '&$liste
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&'  -f bestaudio -ci --console-title -a '&$liste
				EndIf
			Else   ;-ohne proxy
				$command = $youtubedl&' --update -o '&$out&' -ci --console-title -a '&$liste
				if GUICtrlRead($checkboxSound) = 1 Then
					$command = $youtubedl&' --update -o '&$out&'  -f bestaudio -ci --console-title -a '&$liste
				EndIf
			EndIf

		endif



	;~ 	MsgBox($MB_SYSTEMMODAL, "$out", $out)
	;~ 	$command = $youtubedl&'  -ci --console-title "https://www.youtube.com/watch?v=2HeEEQi4PEQ&t=109s"'
	;~ 	$command = $youtubedl&' --update -o '&$out&' --proxy '&$proxy&' -ci --console-title '&$url

;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle", $command)
		$DOS = Run(@ComSpec & ' /k '&$command&' --no-check-certificate', "", @SW_show)
		ProcessWaitClose($DOS)
		Run("C:\WINDOWS\EXPLORER.EXE /n,/e," & $speicherOrt)
	;~ 	$Message = StdoutRead($DOS)
	;~ 	FileWrite("c:\temp\youtube-dl.log", $Message)

	;~ 	$DOS = Run(@ComSpec & ' /c yt-dlp.exe --update', "", @SW_HIDE, $STDERR_CHILD + $STDOUT_CHILD)
	EndIf
EndFunc

func cleanup()
	$filePathNeu = "C:\tempYoutube-dl\data\yt-dlp.exe.new"
	$filePathAlt = "C:\tempYoutube-dl\data\yt-dlp.exe"
	If FileExists($filePathNeu) Then
;~ 		MsgBox($MB_SYSTEMMODAL, "Kontrolle", $filePathNeu)
		FileDelete ($filePathAlt)
		FileMove($filePathNeu, $filePathAlt)
    EndIf

;~ 	$filePath = "c:\tempYoutube-dl"
;~     If FileExists($filePath) Then
;~ 		DirRemove ($filePath ,1 )
;~     EndIf
EndFunc

