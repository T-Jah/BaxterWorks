/*
 *
 * AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
 * (c) 2021 T-Jah Tom
 * http://www.baxterworks.de/software
 * ----------------------------------------------------------------
 * entstanden aus dem Beispiel im Handbuch
 *
*/


#Persistent
return

OnClipboardChange:
if FileExist("C:\WINDOWS\system32\ntimage.gif")
    SplashImage, %A_WinDir%\system32\ntimage.gif, A,,, Installation
Loop, %A_ScriptDir%\..\TomOnly\Media\*.*
{
    Progress, %A_Index%, %A_LoopFileName%, Scanne System ..., BaxterWorks prüft das System
    Sleep, 50
    if (A_Index = 100)
        break
	
}
Progress, Off
SplashImage, Off
ToolTip Datentyp der Zwischenablage: %A_EventInfo%`n%A_Index%
Sleep 2000
ToolTip  ; Schaltet das ToolTip aus.
return


