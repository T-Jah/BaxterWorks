;
; ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
; │   BaxterWorks Software | T-Jah Tom | Funktionen | Aufruf mit: On Exit		   	               │
; └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
;     Version 004



#Persistent  ; Verhindert, dass sich das Skript automatisch beendet.
OnExit(ObjBindMethod(BaxFunk_Exit, "Beenden"))
class BaxFunk_Exit
{
    Beenden()
    {
        SplashTextOn, 450 fs18 zh0,  , BaxEx macht den immer knappen  Speicher wieder frei.


Sleep, 200
SoundBeep, 600, 100
SoundBeep, 500, 100
SoundBeep, 400, 200
SoundBeep, 600, 500
   Gui, Destroy			; gibt die Ressource frei
  CTLCOLORS.Free()		; wenn classCTLColours benutzt wurde
if FileExist("Files\*.htm")
FileDelete %Bax_Start%\Files\*.htm
;Testbox
;MsgBox, Sag wo: %A_ScriptDir%

SplashTextOff
ExitApp
	return
       
    }
}


; Version 004, BaxterWorks (T-Jah Tom)