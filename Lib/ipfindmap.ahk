; IPFindMap.ahk 
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         Jack Dunning (https://jacksautohotkeyblog.wordpress.com/about/contact-jack/)
;
; Script Function:
;	Find IP addresses in selected text and access the Web for geographic location. Hotkey CTRL+ALT+I
;
; March 3, 2019, Rewrote the script to use a more reliable Web page with better information.
; April 23, 2021, Fixed for changed Web page formatting. Added list to map. Converted to GUI.
; May 6, 2021, Switched to new source page since blocked by old source.
; May 10, 2021, Added maps from OpenStreetMap.com to GUI
; The following next Regular Expression is for complete validation within range of 0-255
; ^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$
; Reduced RegEx for a match only
; \b(\d{1,3}\.){3}\d{1,3}\b 


^i::
  OldClipboard:= ClipboardAll
  Clipboard:= ""
  Send, ^c ;copies selected text
  ClipWait 0
  If ErrorLevel
    {
      MsgBox, No Text Selected!
      Return
    }
CountIP := 1
Next := 1
Loop
{
  FoundPos := RegExMatch(Clipboard, "\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b" , ipaddress%CountIP%, Next)
  Next := FoundPos + StrLen(ipaddress%CountIP%)
  If FoundPos = 0
    Break
  CountIP++
}
Gui,97:+AlwaysOnTop
If IPAddress1
  {
    CountIP--
    Loop, %CountIP%
    {
       	CheckIP := ipaddress%A_Index%
       	WhereIs := GetLocation(CheckIP)

		WhereIs[1] := StrReplace(WhereIs[1],"Postal code","`rPostal code:`t")
		WhereIs[1] := StrReplace(WhereIs[1],"Region","`rRegion/State:")
		WhereIs[1] := StrReplace(WhereIs[1],"Country","`rCountry:`t`t")
		WhereIs[1] := StrReplace(WhereIs[1],"State:","State:`t")
		WhereIs[1] := StrReplace(WhereIs[1],"Continent","`rContinent:`t")
		WhereIs[1] := StrReplace(WhereIs[1],"Metro code","`rMetro code:`t")
		WhereIs[1] := StrReplace(WhereIs[1],"City","`rCity:`t`t")
		WhereIs[1] := StrReplace(WhereIs[1],"Coordinates","`rCordinates:`t")

		Gui,97:Add , Text, xm section, % CheckIP . WhereIs[1] 
		Gui,97:Add, ActiveX, ys w400 h400 vWB%A_Index%, Shell.Explorer
		WB%A_Index%.Navigate(WhereIs[3])
		Gui,97:Add , Link, xs yp+120, % "<a href=""https://tools.keycdn.com/geo?host=" . CheckIp . """>IP Data" . "</a>" 
		Gui,97:Add , Link, yp+15, % WhereIs[2] 
    }
}
Else
  WhereIs := "No IPs Found!"

Clipboard := OldClipboard

Gui,97:Add, Button,, Close
Gui,97:Show,,IP Locations

Return

GetLocation(findip)
{
UrlDownloadToFile, % "https://tools.keycdn.com/geo?host=" . findip, iplocate.txt
	IPsearch := "https://tools.keycdn.com/geo?host=" . findip
	whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	whr.Open("GET", IPsearch)
	whr.Send()
	  sleep 100
	version := whr.ResponseText
	RegExMatch(version, "s)Location</p>(.*?)Time</dt>", Location)
    FileRead, version2, iplocate.txt
	RegExMatch(version, "Coordinates</dt><dd class=""col-8 text-monospace"">(.*?) \(lat\) / (.*?)\(long\)", Map)
	Map := Map1 . "/" . Map2
	MapLink := "<a href=""https://www.openstreetmap.org/?mlat=" . map1 . "&mlon=" . map2 . "#map=5/" . Map . """>Map" . "</a>"
	MapGet := "https://www.openstreetmap.org/?mlat=" . map1 . "&mlon=" . map2 . "#map=5/" . Map1 . "/" . Map2
	Location := RegExReplace(Location1,"<.+?>")
	Return [Location,MapLink,MapGet]
}

97ButtonClose:

if FileExist("iplocate.txt")
FileDelete iplocate.txt
		SoundBeep, 750, 500

WinClose
Return

97GuiClose:

if FileExist("iplocate.txt")
FileDelete iplocate.txt
		SoundBeep, 750, 500

Gui,97:Destroy
return