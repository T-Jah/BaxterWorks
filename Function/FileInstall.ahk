/**
 * Muster
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	                       [Version 010]                                                    │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 **/
; Script options
	#NoTrayIcon				; Menu Tray, Icon, %A_ScriptDir%\..\Grafix\cool2.ico
	#SingleInstance force 			; oder off
	#NoEnv
	SetWorkingDir %Bax_Start%		; wichtig
	SendMode Input
	FileEncoding UTF-8
try
{
InstallBax:
; FileInstall
;------------------------------------- Icons
	FileInstall, Grafix\ahk.ico, Grafix\ahk.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\akten.ico, Grafix\akten.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\appbar.ico, Grafix\appbar.ico, 1			; 1 = überschreiben
	FileInstall, Grafix\AutoGUI.icl, Grafix\AutoGUI.icl, 0			; 1 = überschreiben
	FileInstall, Grafix\autotext.ico, Grafix\autotext.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\bax.ico, Grafix\bax.ico, 1				; 1 = überschreiben
	FileInstall, Grafix\box.ico, Grafix\box.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\BW_Software.ico, Grafix\BW_Software.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\bw_2win.ico, Grafix\bw_2win.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\clan.ico, Grafix\clan.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\cool.ico, Grafix\cool.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\cool1.ico, Grafix\cool1.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\cool2.ico, Grafix\cool2.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\dateien.ico, Grafix\dateien.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\favicon.ico, Grafix\favicon.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\fledermond2.ico, Grafix\fledermond2.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\github1.ico, Grafix\github1.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\gta_moped2.ico, Grafix\gta_moped2.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\info.ico, Grafix\info.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\karton.ico, Grafix\karton.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\keyboard.ico, Grafix\keyboard.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\kapuze2.ico, Grafix\kapuze2.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\killerbax.ico, Grafix\killerbax.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\klee.ico, Grafix\klee.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\linux.ico, Grafix\linux.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\logo.ico, Grafix\logo.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\logo_bw2.ico, Grafix\logo_bw2.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\logo_dread.ico, Grafix\logo_dread.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\logo_tb.ico, Grafix\logo_tb.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\logo_tb2.ico, Grafix\logo_tb2.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\logo_tjah.ico, Grafix\logo_tjah.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\logo_tjah2.ico, Grafix\logo_tjah2.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\logo1.ico, Grafix\logo1.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\lupe.ico, Grafix\lupe.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\menuico.ico, Grafix\menuico.ico, 1			; 1 = überschreiben
	FileInstall, Grafix\monitor.ico, Grafix\monitor.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\mucke.ico, Grafix\mucke.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\news.ico, Grafix\news.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\npz.ico, Grafix\npz.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\ordner3.ico, Grafix\ordner3.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\pic.ico, Grafix\pic.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\pin.ico, Grafix\pin.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\radierer.ico, Grafix\radierer.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\runaway.ico, Grafix\runaway.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\schere.ico, Grafix\schere.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\service.ico, Grafix\service.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\skull.ico, Grafix\skull.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\talk.ico, Grafix\talk.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\tb_berlin.ico, Grafix\tb_berlin.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\tb_comic.ico, Grafix\tb_comic.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\tb_painfighter.ico, Grafix\tb_painfighter.ico, 0	; 1 = überschreiben
	FileInstall, Grafix\tb_social.ico, Grafix\tb_social.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\telegram.ico, Grafix\telegram.ico, 0		; 1 = überschreiben
	FileInstall, Grafix\uhr3.ico, Grafix\uhr3.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\Uhrbax.ico, Grafix\Uhrbax.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\verbot2.ico, Grafix\verbot2.ico, 0			; 1 = überschreiben
	FileInstall, Grafix\vfl.ico, Grafix\vfl.ico, 0				; 1 = überschreiben
	FileInstall, Grafix\welt.ico, Grafix\welt.ico, 0			; 1 = überschreiben

;------------------------------------- Grafiken

	FileInstall, Grafix\ahk.png, Grafix\ahk.png, 0				; 1 = überschreiben
	FileInstall, Grafix\bar.png, Grafix\bar.png, 0				; 1 = überschreiben
	FileInstall, Grafix\bw_banner.png, Grafix\bw_banner.png, 0		; 1 = überschreiben
	FileInstall, Grafix\bw_software.png, Grafix\bw_software.png, 0		; 1 = überschreiben
	FileInstall, Grafix\bw_software2.png, Grafix\bw_software2.png, 0	; 1 = überschreiben
	FileInstall, Grafix\close.png, Grafix\close.png, 0			; 1 = überschreiben
	FileInstall, Grafix\kapuze2.png, Grafix\kapuze2.png, 0			; 1 = überschreiben
	FileInstall, Grafix\logo.png, Grafix\logo.png, 0			; 1 = überschreiben
	FileInstall, Grafix\pic.png, Grafix\pic.png, 0				; 1 = überschreiben
	FileInstall, Grafix\tjah_banner_tr.png, Grafix\tjah_banner_tr.png, 0		; 1 = überschreiben
	FileInstall, Grafix\tjah_banner_weiss.png, Grafix\tjah_banner_weiss.png, 0	; 1 = überschreiben
	FileInstall, Grafix\tjah_banner_tr_600.png, Grafix\tjah_banner_tr_600.png, 0	; 1 = überschreiben


;------------------------------------- Dateien

	FileInstall, Files\credits.md, Files\credits.md, 0			; 1 = überschreiben
	FileInstall, Files\help.md, Files\help.md, 0				; 1 = überschreiben
	FileInstall, Files\Licence, Files\Licence, 0				; 1 = überschreiben

	
;------------------------------------- Apps

		FileInstall, Apps\BWAppBar\BWAppBar.exe, Apps\BWAppBar\BWAppBar.exe, 0			; 1 = überschreiben
		FileInstall, Apps\BWAppBar\00AppBar.exe, Apps\BWAppBar\00AppBar.exe, 0			; 1 = überschreiben
		FileInstall, Apps\GetReadyBax\GetReadyBax.exe, Apps\GetReadyBax\GetReadyBax.exe, 0	; 1 = überschreiben
		FileInstall, Apps\Emoji\EmojiMenu.exe, Apps\Emoji\EmojiMenu.exe, 0			; 1 = überschreiben
		FileInstall, Apps\FavFolder\FavoriteFolders.exe, Apps\FavFolder\FavoriteFolders.exe, 0	; 1 = überschreiben

}
catch
{
    MsgBox, 16,, Es trat ein Fehler beim Absichern der Dateien auf!
    ExitApp
}

MsgBox, Alles installiert