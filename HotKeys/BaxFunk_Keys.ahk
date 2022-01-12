;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: Bax_Keys_Create()   	                       │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 006

		

Bax_Keys_Create(){
global
		#SingleInstance ignore
		SendMode Input			; Macht Send synonym mit SendInput, hohe Geschwindigkeit und Zuverlässigkeit.
		SetTitleMatchMode 2  		; Verhindert, dass unten der vollständige Pfad der Datei angegeben werden muss.
		SetWorkingDir %Bax_Start%
		FileEncoding UTF-8


;MsgBox, %Bax_Start%`n%A_ScriptDir%
Gui,Keys:New
Gui,Keys:+Owner  ; Definiert Keys als Unterfenster vom Hauptfenster des Skripts, um dessen Taskleistenschaltfläche zu verstecken.
Gui,Keys:Font, s9, Segoe UI

Gui,Keys:Add, Tab3, hWndhTab x8 y8 w490 h477
SendMessage 0x1329, 0, 0x00170055,, ahk_id %hTab% ; TCM_SETITEMSIZE
GuiControl,, %hTab%, HotKeys|HotStrings|Windows

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
    Gui,Keys:Add, ListView, hWndhLVHotKeys x18 y44 w430 h430 +LV0x14000, Aktion|Taste
    SetExplorerTheme(hLVHotKeys)

    LV_Add("", "Ton AN/AUS", "STRG+. (Punkt)")
    LV_Add("", "BaxMenü - Hauptmenü BaxterWorks", "STRG+1")
    LV_Add("", "HotKeys, dieses Fenster", "STRG+2")
    LV_Add("", "App: SuchBax", "STRG+5")
    LV_Add("", "AHK Handbuch", "STRG+0")
    LV_Add("", "HTML Code für fette Schrift", "STRG+B")
    LV_Add("", "Findet IPs in Markierung, zeigt GeoDaten", "STRG+I")
    LV_Add("", "HTML Codierung", "STRG+ß (und Umlaute)")
    LV_Add("", "Backup: iSafeText", "STRG+ALT+B")
    LV_Add("", "Schreibweise MARKIERUNG", "STRG+ALT+I")
    LV_Add("", "Schreibweise markierung", "STRG+ALT+O")
    LV_Add("", "Schreibweise Markierung", "STRG+ALT+P")
    LV_Add("", "App: GetReadyBax (Config)", "STRG+SHIFT+1")
    LV_Add("", "App: NumpadZeichner", "STRG+SHIFT+2")
    LV_Add("", "App: CaptureBax", "STRG+SHIFT+3")
    LV_Add("", "App: Bax_Flex (UserVariable)", "STRG+SHIFT+0")
    LV_Add("", "Markierung in eckigen Klammern", "STRG+SHIFT+B")
    LV_Add("", "App: DesktopPainter", "STRG+SHIFT+D")
    LV_Add("", "App: EmojiMenu", "STRG+SHIFT+E")
    LV_Add("", "App: FavoriteFolders", "STRG+SHIFT+F")
    LV_Add("", "IP Adressen, lokal und online", "STRG+SHIFT+I")
    LV_Add("", "App: KillerBax", "STRG+SHIFT+K")
    LV_Add("", "App: MiniDBs", "STRG+SHIFT+M")
    LV_Add("", "Funktion: 2Win", "STRG+SHIFT+N")
    LV_Add("", "OnTop, jedes Fenster", "STRG+SHIFT+O")
    LV_Add("", "Reload aller Skripte", "STRG+SHIFT+R")
    LV_Add("", "App: UhrDigiSimple", "STRG+SHIFT+U")
    LV_Add("", "Funktion: VarSchau", "STRG+SHIFT+V")
    LV_Add("", "App: neArtWürfel", "STRG+SHIFT+W")
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


Gui,Keys:Tab, 2
    Gui,Keys:Add, ListView, hWndhLVHotStrings x18 y44 w430 h430 +LV0x14000, Auslöser|Aktion
    SetExplorerTheme(hLVHotStrings)

    LV_Add("", ".vfl", "💙 VfL Bochum 1848 💙")
    LV_Add("", ":)", "😃")
    LV_Add("", ";)", "😎")
    LV_Add("", ":(", "😥")
    LV_Add("", "...?", "❔")
    LV_Add("", ".rec", "🛑")
    LV_Add("", ".lol", "😂")
    LV_Add("", ".kotz", "🤮")
    LV_Add("", ".denk", "🤔")
    LV_Add("", ".cool", "😎")
    LV_Add("", ".schock", "😳")
    LV_Add("", ".heul", "😢")
    LV_Add("", ".groll", "😠")
    LV_Add("", ".roll", "🙄")
    LV_Add("", ".kill", "💀")
    LV_Add("", ".gift", "☠️")
    LV_Add("", ".shit", "💩")
    LV_Add("", ".herz", "❤️")
    LV_Add("", ".bombe", "💣")
    LV_Add("", ".blase", "🗨️")
    LV_Add("", ".zzz", "💤")
    LV_Add("", ".boom", "💥")
    LV_Add("", ".ball", "⚽")
    LV_Add("", ".sieg", "✌️")
    LV_Add("", ".gut", "👍")
    LV_Add("", ".mies", "👎")
    LV_Add("", ".stark", "💪")
    LV_Add("", ".stern", "🌟")
    LV_Add("", ".kalt", "❄️")
    LV_Add("", ".schnee", "⛄")
    LV_Add("", ".hot", "🔥")
    LV_Add("", ".warm", "🌡️")
    LV_Add("", ".kaffee", "☕")
    LV_Add("", ".pilz", "🍄")
    LV_Add("", ".schnecke", "🐌")
    LV_Add("", ".frosch", "🐸")
    LV_Add("", ".küken", "🐥")
    LV_Add("", ".meld", "🙋‍")
    LV_Add("", ".grrr", "😬")
    LV_Add("", ".hmmm", "😐")
    LV_Add("", ".kiss", "😘💋")
    LV_Add("", ".love", "😍💘")
    LV_Add("", ".lecker", "😛")
    LV_Add("", ".yes", "✓")
    LV_Add("", ".no", "✖")
    LV_Add("", ".top", "‣")
    LV_Add("", ".kopf", "🎧")
    LV_Add("", ".zack", "💥💪")
    LV_Add("", ".arzt", "👨👩‍⚕️")
    LV_Add("", ".bogen", "🏹")
    LV_Add("", ".herb", "🌿")
    LV_Add("", ".ziggi", "🚬")
    LV_Add("", ".fast", "🏃🏇⛷🚴‍🚗🛵🦽🏍💨")
    LV_Add("", ".paar", "💑")
    LV_Add("", ".brief", "💌")
    LV_Add("", ".weck", "⏰")
    LV_Add("", ".maske", "😷")
    LV_Add("", ".drop", "💧")
    LV_Add("", ".reggae", "🔴🟡🟢")
    LV_Add("", ".buch", "📖📕📚")
    LV_Add("", ".paket", "📦")
    LV_Add("", ".stift", "✏️")
    LV_Add("", ".kredit", "💳")
    LV_Add("", ".euro", "💶")
    LV_Add("", ".pin", "📌")
    LV_Add("", ".gear", "⚙️")
    LV_Add("", ".müll", "🗑️")
    LV_Add("", ".cut", "✂️")
    LV_Add("", ".key", "🔑")
    LV_Add("", ".closed", "🔒")
    LV_Add("", ".pill", "💊")
    LV_Add("", ".bett", "🛏️")
    LV_Add("", ".sperre", "⛔️🚫🚧")
    LV_Add("", ".laut", "📢")
    LV_Add("", ".think", "💭")
    LV_Add("", ".speak", "💬")
    LV_Add("", ".flag", "🚩🏴‍☠️🏳️‍🌈🏳🏴🏁")
    LV_Add("", ".clown", "🤡")
    LV_Add("", ".loch", "🕳")
    LV_Add("", ".wink", "👋")
    LV_Add("", ".zeigl", "👈")
    LV_Add("", ".zeigr", "👉")
    LV_Add("", ".faust", "🤛🤜👊")
    LV_Add("", ".pray", "🙏")
    LV_Add("", ".write", "✍")
    LV_Add("", ".zahn", "🦷")
    LV_Add("", ".eyes", "👀")
    LV_Add("", ".zunge", "👅")
    LV_Add("", ".mund", "👄")
    LV_Add("", ".baby", "👶")
    LV_Add("", ".boy", "👦")
    LV_Add("", ".girl", "👧")
    LV_Add("", ".opa", "👨‍🦳")
    LV_Add("", ".oma", "👩‍🦳")
    LV_Add("", ".family", "👩‍🦳👨‍🦳👧👦👶👩")
    LV_Add("", ".frau", "👩")
    LV_Add("", ".mann", "👨")
    LV_Add("", ".police", "👮👮‍🕵🚓")
    LV_Add("", ".dance", "💃🕺")
    LV_Add("", ".foot", "👣")
    LV_Add("", ".dog", "🐕")
    LV_Add("", ".cat", "🐈")
    LV_Add("", ".prost", "🍺🥤🥂")
    LV_Add("", ".tank", "⛽")
    LV_Add("", ".ampel", "🚦🚥")
    LV_Add("", ".anker", "⚓")
    LV_Add("", ".mond", "🌙")
    LV_Add("", ".sonne", "☀")
    LV_Add("", ".saturn", "🪐")
    LV_Add("", ".wolke", "☁🌧🌦🌥🌤⛈🌨🌩")
    LV_Add("", ".game", "🎮")
    LV_Add("", ".save", "💾")
    LV_Add("", ".print", "🖨")
    LV_Add("", ".brief", "✉💌")
    LV_Add("", ".date", "📆")
    LV_Add("", ".open", "🔓")
    LV_Add("", ".klo", "🧻🚾")
    LV_Add("", ".smoke", "🚭🚬")
    LV_Add("", ".danger", "☢☣")
    LV_Add("", ".ziege", "🐐")
    LV_Add("", ".pig", "🐷")
    LV_Add("", ".rat", "🐀")
    LV_Add("", ".hase", "🐇")
    LV_Add("", ".maus", "🐁🐭🖱️")
    LV_Add("", ".bat", "🦇")
    LV_Add("", ".stink", "🦨")
    LV_Add("", ".huhn", "🐔🥚")
    LV_Add("", "..ei", "🥚")
    LV_Add("", ".pingu", "🐧")
    LV_Add("", ".taube", "🕊️")
    LV_Add("", ".swan", "🦢")
    LV_Add("", ".eule", "🦉")
    LV_Add("", ".snake", "🐍")
    LV_Add("", ".fisch", "🐟🐠🐡")
    LV_Add("", ".spinne", "🕸️🕷️")
    LV_Add("", ".mücke", "🦟")
    LV_Add("", ".virus", "🦠🧫🔬😷")
    LV_Add("", ".klee", "🍀")
    LV_Add("", ".ab18", "🔞")
    LV_Add("", ".grad", "° Celsius")
    LV_Add("", "ccm3", "ccm³")
    LV_Add("", ".neu", "Xelara_tb")
    LV_Add("", ".bw", "BaxterWorks")
    LV_Add("", ".tomde", "https://www.tombesch.de")
    LV_Add("", ".baxde", "http://www.baxterworks.de")
    LV_Add("", ".link", "html Link")
    LV_Add("", "fms", "Fibromyalgiesyndrom (FMS)")
    LV_Add("", ".logo", "html ")
    LV_Add("", ".ul", "html unsortierte Liste")
    LV_Add("", ".soft", "html Link BW Software")
    LV_Add("", ".help", "html Link BW Software Hilfe")
    LV_Add("", ".blog", "html Link zum Blog")
    LV_Add("", ".git", "html Link zu GitHub")
    LV_Add("", ".head", "html <head></head>")
    LV_Add("", ".pic", "html code für ein Bild")
    LV_Add("", ".form", "js <form> ergibt einen Button")
    LV_Add("", "...p", "html <p id=""></p>")
    LV_Add("", ".../", "js /* Text */")
    LV_Add("", ".pre", "html <pre></pre>")
    LV_Add("", ".button", "html <button></button>")
    LV_Add("", ".code", "html <code></code>")
    LV_Add("", ".script", "html <script></script>")
    LV_Add("", ".style", "html <style></style>")
    LV_Add("", ".main", "html <main></main>")
    LV_Add("", ".div", "html <div></div>")
    LV_Add("", ".html", "html Gerüst einer Seite")
    LV_Add("", ".body", "html <body></body>")
    LV_Add("", "(a)", "@")
    LV_Add("", "(t)", "†")
    LV_Add("", "(c)", "©")
    LV_Add("", "(tm)", "™")
    LV_Add("", "Bax_s)", "ahk Bax_Start")
    LV_Add("", "Bax_f", "ahk Bax_Flex")
    LV_Add("", "BaxN", "ahk BaxNutzerName")
    LV_Add("", "Bax_j", "ahk ahkBax_JobDir")
    LV_Add("", ".msg1", "ahk MessageBox 1")
    LV_Add("", ".msg2", "ahk MessageBox 2")
    LV_Add("", ".banner", "html Link zum Logo")
    LV_Add("", "mfg", "Mit freundlichen Grüßen`n")
    LV_Add("", "A_s", "ahk A_ScriptDir\")
    LV_Add("", "A_w", "ahk A_WorkingDir")
    LV_Add("", "A_p", "ahk A_ProgramData")
    LV_Add("", "A_u", "ahk A_UserName")
    LV_Add("", "A_c", "ahk A_ComputerName")
    LV_Add("", "txt_box1", "txt 1 Zeile mir Rahmen")
    LV_Add("", "txt_box2", "txt 8 Zeilen Kasten")
    LV_Add("", "txt_box3", "txt 16 Zeilen Box ")
    LV_Add("", "txt_port", "txt Schriftzug ")
    LV_Add("", "txt_pubbw", "txt neues Thema")
    LV_Add("", "txt_bw", "txt Headline")
    LV_Add("", "txt_dreadyt", "txt Schriftzug")
    LV_Add("", "txt_dread_de", "txt Schriftzug")
    LV_Add("", "txt_know", "txt Schrift Knowledge")
    LV_Add("", "txt_tb", "txt Schriftzug")
    LV_Add("", "txt_tab1", "txt Tabelle")
    LV_Add("", "txt_tab2", "txt Tabelle")
    LV_Add("", "txt_tjah", "txt Schriftzug")
    LV_Add("", "txt_todo", "txt Aufgabenzettel")
    ;LV_Add("", "", "")
Loop % LV_GetCount("Col")  ; Auto-size each column to fit its contents.
    LV_ModifyCol(1, "240")
    LV_ModifyCol(2, "AutoHdr")
    SB_SetText(LV_GetCount() . " BaxterWorks Hotstrings und 35 Hotkeys für deinen PC.")

Gui,Keys:Tab, 3
    Gui,Keys:Add, ListView, hWndhLVWindows x18 y44 w430 h430 +LV0x14000, Aktion|Taste
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

Gui,Keys:Add, Button, gKeysGuiClose xm Default, &tüss
Gui,Keys:Show, w490 h555, BaxterWorks HotKey Collection
	
Return

KeysGuiEscape:
KeysGuiClose:
WinClose
Gui, Keys:Destroy
Return
}
Return

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


