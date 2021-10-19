;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: 			   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 001



Bax_Stats_Nutzungstage(){
	global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force

		#Persistent
		IniRead, Erstnutzung , %userini%, %A_UserName%_%A_ComputerName%, Erstnutzung
		Nutzungstage := A_Now
		Erstnutzung := Erstnutzung
		EnvSub, Nutzungstage, %Erstnutzung%, days
	
}


Bax_Stats_Zwischenzeit(){
	global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force

		#Persistent
		IniRead, Nutzzeit , %userini%, Stats_%A_UserName%_%A_ComputerName%, Nutzzeit_%AppName%
		Zwischenzeit := A_Now
		Letztnutzung := Nutzzeit
		EnvSub, Zwischenzeit, %Letztnutzung%, hours
	
}


Bax_Stats_Zeilenzahl(){
	global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance force
		#Persistent
		IniRead, AnzNutzung , %Bax_Start%\Config\%AppName%.ini, Stats_%A_UserName%_%A_ComputerName%, Appnutzcount


		FileRead, UI_file, %Bax_Start%\Log\%AppName%log.txt
		StrReplace(UI_file, "`n" , "`n", Appnutzcount)
									; wenn in der txt Datei keine Einträge sind (ausgeleert zB) dann
		If (Appnutzcount = AnzNutzung)
		Appnutzcount:=Appnutzcount+1
									; lies den gespeicherten Wert plus 1
		If (Appnutzcount < AnzNutzung)
		Appnutzcount:=AnzNutzung+1


}

