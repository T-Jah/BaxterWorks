;------------------------------------------------------------------------------------->
; AHK AutoHotKey Skript. Handbuch und HP: https://ahkde.github.io/
; (c) 2021 T-Jah Tom
; https://github.com/T-Jah					   05/2021 Version 008
;------------------------------------------------------------------------------------->
; Skript besteht überwiegend aus Schnippseln aus dem Handbuch und der Community.
;
; BaxterWorks Software:	http://www.baxterworks.de/software
;			http://blog.baxterworks.de
;                       ^ STRG + Shift ! Alt # WIN
;------------------------------------------------------------------------------------->
; More:    ......https://github.com/T-Jah
; Licence: ......BaxterWorks Software is licensed under the MIT Licence

; Script options
#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input




; # HTML Vorlagen --------------------------------------------------------------------->



;--------------------------------------------------;

:*:mail_leer::
SendInput {Raw}
( 
<!DOCTYPE html><html>
  <head>
    <meta http-equiv="content-type" content="text/html; charset=">
    <meta charset="utf-8"/>
  </head>
  <body>
    <blockquote>
      <h3>Überschrift</h3>
      Text<br>
    </blockquote>
  </body>
</html>
)
return

;--------------------------------------------------;

