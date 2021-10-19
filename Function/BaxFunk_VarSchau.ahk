BaxFunk_VarSchau()
 	{
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force

    	DetectHiddenWindows, On
OnMessage(0x53, "OnHelp")
Gui +OwnDialogs
MsgBox 0x4040, VarSchau, %A_ScriptName%`nBAXTERWORKS VARIABLEN TESTER BOX VERSION 010:`n--------------------------------------------------------------------------------`nBaxNutzerName: %BaxNutzerName%`nNutzer seit: %Erstnutzung% (%Appnutzcount% Starts in %Nutzungstage% Tagen)`nBaxIP: %Bax_IP%`nBax_Start: %Bax_Start%`nScriptIni: %scriptini%`nUserIni: %userini%`nHomeIni: %homeini%`nLogDatei: %backuptxt%`nBax_JobDir: %Bax_JobDir%`nBax_Flex: %Bax_Flex%`nDropZiel1: %Ziel1%`nDropZiel2: %Ziel2%`nA_ScriptHwnd: %A_ScriptHwnd%`n`nA_LineFile: %A_LineFile%`nA_ComputerName: %A_ComputerName%`nA_Username: %A_Username%`nA_MyDocuments:  %A_MyDocuments%`nA_AppData: %A_AppData%`nA_WinDir: %A_WinDir%`n`nA_ComSpec: %A_ComSpec%`nA_Temp: %A_Temp%`nA_OSType: %A_OSType%`n`nA_BatchLines: %A_BatchLines% und A_WinDelay/KeyDelay/ControlDelay %A_WinDelay%/%A_KeyDelay%/%A_ControlDelay%`n

}

OnHelp() {
	If !(FileExist)
	{
	UrlDownloadToFile, http://www.baxterworks.de/software/hilfe/help.htm, Files\help.htm
	}
	run, Files\help.htm
}
return

