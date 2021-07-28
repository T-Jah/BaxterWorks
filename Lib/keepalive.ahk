; Das folgende DllCall ist optional: es teilt dem OS mit, dass dieses Skript zuerst beendet werden soll (bevor alle anderen Anwendungen beendet werden).
DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
OnMessage(0x0011, "WM_QUERYENDSESSION")
return

WM_QUERYENDSESSION(wParam, lParam)
{
    ENDSESSION_LOGOFF := 0x80000000
    if (lParam & ENDSESSION_LOGOFF)  ; Benutzer meldet sich ab.
        Ereignis := "Abmelden"
    else  ; System wird entweder heruntergefahren oder neu gestartet.
        Ereignis := "Herunterfahren"
    try
    {
        ; Bestimmt einen Anzeigetext für die OS-Herunterfahren-UI. Wir
        ; zeigen keine eigene Sicherheitsabfrage an, da wir nur 5 Sekunden
        ; haben, bevor das OS von sich aus die Herunterfahren-UI anzeigt.  
        ; Außerdem kann ein Programm ohne sichtbares Fenster das
        ; Herunterfahren nur blockieren, wenn ein Grund angegeben ist.
        BlockiereHerunterfahren("Es wird versucht, " Ereignis " zu verhindern.")
        return false
    }
    catch
    {
        ; ShutdownBlockReasonCreate ist nicht verfügbar, demzufolge läuft
        ; vermutlich Windows XP, 2003 oder 2000, wo wir tatsächlich
        ; das Herunterfahren verhindern können.
        MsgBox, 4,, %Ereignis% im Gange.  Erlauben?
        IfMsgBox Yes
            return true  ; Erlaubt dem OS das Herunterfahren/Abmelden.
        else
            return false  ; Verbietet dem OS das Herunterfahren/Abmelden.
    }
}

BlockiereHerunterfahren(Grund)
{
    ; Wenn Ihr Skript eine sichtbare GUI hat, nutzen Sie diese anstelle
    ; von A_ScriptHwnd.
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Grund)
    OnExit("StoppeBlockenHerunterfahren")
}

StoppeBlockenHerunterfahren()
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}