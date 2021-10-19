;---------------------------------------------------------------->
; BaxProgressBar Funktion
;---------------------------------------------------------------->


BaxProgressBar(){
Wait(1000) 
WinClose
return
}
Wait(time){
	static MyProgress
	tick:=A_TickCount+time
	Gui,Baxprogress:New,hwndMyGui
	Gui,Baxprogress:-Caption +AlwaysOnTop
        Gui,Baxprogress:Margin,0,0
	Gui,Baxprogress:Add,Progress,w500 h40 Range%A_TickCount%-%tick% vMyProgress
	Gui,Baxprogress:Show,NA
	While A_TickCount<=tick {
		GuiControl,,MyProgress,% A_TickCount
		Sleep 5
	}
	Gui,Baxprogress:Destroy

}

