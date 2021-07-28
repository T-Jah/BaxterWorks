;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_ConfigGui_Create()   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 011



Bax_Keys_Create(){
global
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8
		#SingleInstance ignore


If !(FileExist(File1) && FileExist(File2))
{
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_banner.png,  Grafix\bw_banner.png
	UrlDownloadToFile, http://www.baxterworks.de/software/pix/bw_software2.png,  Grafix\bw_software2.png
}

;MsgBox, %Bax_Start%`n%A_ScriptDir%
Gui,Keys:New
Gui,Keys:+Owner  ; Definiert Keys als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,Keys:Font, s9, Segoe UI

Gui,Keys:Add, Tab3, hWndhTab x8 y8 w490 h477
SendMessage 0x1329, 0, 0x00170055,, ahk_id %hTab% ; TCM_SETITEMSIZE
GuiControl,, %hTab%, BaxterWorks|IfActive|Windows

IconLib = %Bax_Start%\Grafix\AutoGUI.icl
IL := IL_Create(3)
IL_Add(IL, IconLib, 22)
IL_Add(IL, IconLib, 24)
IL_Add(IL, IconLib, 41)
SendMessage 0x1303, 0, IL,, ahk_id %hTab% ; TCM_SETIMAGELIST

SetTabIcon(hTab, 1, 1)
SetTabIcon(hTab, 2, 2)
SetTabIcon(hTab, 3, 3)

SendMessage 0x132B, 0, 5 | (4 << 16),, ahk_id %hTab% ; TCM_SETPADDING

Gui,Keys:Tab, 1
    Gui,Keys:Add,StatusBar
    Gui,Keys:Add, ListView, hWndhLVBaxterWorks x18 y44 w430 h428 +LV0x14000, Aktion|Taste
    SetExplorerTheme(hLVEBaxterWorks)

    LV_Add("", "Ton AN/AUS", "STRG+. (Punkt)")
    LV_Add("", "HotKeys, dieses Fenster", "STRG+2")
    LV_Add("", "App SuchBax", "STRG+5")
    LV_Add("", "AHK Handbuch", "STRG+0")
    LV_Add("", "HTML Code für fette Schrift", "STRG+B")
    LV_Add("", "Findet IPs in Markierung, zeigt GeoDaten", "STRG+I")
    LV_Add("", "HTML Codierung", "STRG+ß (und Umlaute)")
    LV_Add("", "Backup: iSafeText", "STRG+ALT+B")
    LV_Add("", "Schreibweise MARKIERUNG", "STRG+ALT+I")
    LV_Add("", "Schreibweise markierung", "STRG+ALT+O")
    LV_Add("", "Schreibweise Markierung", "STRG+ALT+P")
    LV_Add("", "App GetReadyBax (Config)", "STRG+SHIFT+1")
    LV_Add("", "App NumpadZeichner", "STRG+SHIFT+2")
    LV_Add("", "App CaptureBax", "STRG+SHIFT+3")
    LV_Add("", "App Bax_Flex (UserVariable)", "STRG+SHIFT+0")
    LV_Add("", "Markierung in eckigen Klammern", "STRG+SHIFT+B")
    LV_Add("", "IP Adressen, lokal und online", "STRG+SHIFT+I")
    LV_Add("", "App: KillerBax", "STRG+SHIFT+K")
    LV_Add("", "Funktion: 2Win", "STRG+SHIFT+N")
    LV_Add("", "OnTop, jedes Fenster", "STRG+SHIFT+O")
    LV_Add("", "Reload aller Skripte", "STRG+SHIFT+R")
    LV_Add("", "App UhrDigiSimple", "STRG+SHIFT+U")
    LV_Add("", "Funktion: VarSchau", "STRG+SHIFT+V")
    LV_Add("", "aktuelles Datum", "STRG+WIN+F1 (.heute)")
    LV_Add("", "aktuelle Uhrzeit", "STRG+WIN+F2 (.jetzt)")
    LV_Add("", "Datumsrechner", "STRG+WIN+F3 (.dann)")
    LV_Add("", "Markdown Code für Links", "STRG+WIN+B")
    LV_Add("", "Panic-Button", "STRG+WIN+P")
    LV_Add("", "Toggle Hotkeys AN/AUS", "STRG+WIN+T")
    LV_Add("", "Dropper-Fenster", "STRG+WIN+ALT+D")
    ;LV_Add("", "", "")
Loop % LV_GetCount("Col")  ; Auto-size each column to fit its contents.
    LV_ModifyCol(1, "240")
    LV_ModifyCol(2, "AutoHdr")
    SB_SetText(LV_GetCount() . " BaxterWorks Tastenkürzel für deinen PC.")


Gui,Keys:Tab, 2
    Gui,Keys:Add, ListView, hWndhLVIfActive x18 y44 w430 h428 +LV0x14000, Aktion|Taste
    SetExplorerTheme(hLVGUIIfActive)

    LV_Add("", "Notepad: BaxterWorks Fenster", "STRG + N")
    ;LV_Add("", "", "")
Loop % LV_GetCount("Col")  ; Auto-size each column to fit its contents.
    LV_ModifyCol(1, "240")
    LV_ModifyCol(2, "AutoHdr")

Gui,Keys:Tab, 3
    Gui,Keys:Add, ListView, hWndhLVWindows x18 y44 w430 h428 +LV0x14000, Aktion|Taste
    SetExplorerTheme(hLVWindows)

    LV_Add("", "Taskmanager", "STRG+ALT+Entf")
    LV_Add("", "aktive Fenster durchschalten", "ALT+Tab")
    LV_Add("", "Bildschirmtastatur an/aus", "WIN+STRG+o")
    LV_Add("", "Einstellungen, System", "WIN+i")
    LV_Add("", "XBOX Gamebar, MultiGrafix (je nach Hardware)", "WIN+g")
    LV_Add("", "Explorer: Ansicht ändern", "STRG+Mausrad")
    LV_Add("", "Taskleiste: Lautstärke ändern", "Mausrad über Leiste")
    LV_Add("", "Ton: an/aus", "STRG+. (Punkt)")
    LV_Add("", "Sprachausgabe: an/aus", "STRG+WIN+EINGABE")
    LV_Add("", "Fenster schieben", "WIN+Pfeil rechts/links")
    LV_Add("", "Fenster schieben, Monitor 2", "WIN+Shift+Pfeil rechts/links")
    ;LV_Add("", "", "")
Loop % LV_GetCount("Col")  ; Auto-size each column to fit its contents.
    LV_ModifyCol(1, "240")
    LV_ModifyCol(2, "AutoHdr")
Gui,Keys:Tab

Gui,Keys:Add, Button, gKeysGuiClose x346 y494 w86 h24 Default, &tüss
Gui,Keys:Show, w490 h550, BaxterWorks HotKey Collection
	
Return

KeysGuiEscape:
KeysGuiClose:
WinClose
Gui, Keys:Destroy
Return
}


SetExplorerTheme(hWnd) {
    Return DllCall("UxTheme.dll\SetWindowTheme", "Ptr", hWnd, "WStr", "Explorer", "Ptr", 0)    
}

SetTabIcon(hTab, Item, IconIndex) {
    Static OffImg := (3 * 4) + (A_PtrSize - 4) + A_PtrSize + 4
    Static Size := (5 * 4) + (2 * A_PtrSize) + (A_PtrSize - 4)
    VarSetCapacity(TCITEM, Size, 0)
    NumPut(0x2, TCITEM, 0, "UInt") ; 0x2 = TCIF_IMAGE
    NumPut(IconIndex - 1, TCITEM, OffImg, "Int")
    SendMessage 0x133D, Item - 1, &TCITEM,, ahk_id %hTab% ; TCM_SETITEM
}


