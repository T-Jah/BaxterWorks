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
; Titel:   ......Name
; Licence: ......BaxterWorks Software is licensed under the MIT Licence

; Script options
#SingleInstance force 			; oder off
#NoEnv
SetWorkingDir %A_ScriptDir%		; wichtig
SendMode Input


:c*:.vfl::VfL Bochum 1848
:c*::)::😃
:c*:;)::😎
:c*::(::😥
:c*:..?::❔
:c*:.grad::° Celsius
:c*:.rec::🛑

:c*:.lol::😂
:c*:.kotz::🤮
:c*:.denk::🤔
:c*:.cool::😎
:c*:.schock::😳
:c*:.heul::😢
:c*:.groll::😠
:c*:.roll::🙄
:c*:.kill::💀
:c*:.gift::☠️
:c*:.shit::💩
:c*:.herz::❤️
:c*:.bombe::💣
:c*:.blase::🗨️
:c*:.zzz::💤
:c*:.boom::💥
:c*:.ball::⚽
:c*:.sieg::✌️
:c*:.gut::👍
:c*:.mies::👎
:c*:.stark::💪
:c*:.stern::🌟
:c*:.kalt::❄️
:c*:.schnee::⛄
:c*:.hot::🔥
:c*:.warm::🌡️
:c*:.kaffee::☕
:c*:.pilz::🍄
:c*:.schnecke::🐌
:c*:.frosch::🐸
:c*:.küken::🐥
:c*:.meld::🙋‍
:c*:.grrr::😬
:c*:.hmmm::😐
:c*:.kiss::😘
:c*:.love::😍
:c*:.lecker::😛

:*:ccm3::ccm³
:*:qm2::qm²
:c*:fms::Fibromyalgiesyndrom (FMS)
:*:(a)::@
:*:(c)::©
:*:(t)::†
:*:(tm)::™

:*:Faru::Frau
:*:Mashine::Machine
:*:Tunier::Turnier
:*:heir::hier
:*:Verküpfung::Verknüpfung

:c*:.bw::BaxterWorks
:c*:.top::Xelara_Top
:c*:.neu::Xelara_tb

:*:mfg::Mit freundlichen Grüßen`n



; AHK HotStrings

:*:A_S::%A_ScriptDir%\
:*:A_W::%A_WorkingDir%\
:*:A_P::%A_ProgramData%\
:*:A_U::%A_UserName%\
:*:A_C::%A_ComputerName%\

:*:Bax_S::%Bax_Start%\
:*:Bax_F::%Bax_Flex%\
:*:BaxN::%BaxNutzerName%\
:*:Bax_J::%Bax_JobDir%\

:*:.msg1::MsgBox, 4,BaxterWorks Software meldet , Du bist dran - triff eine Entscheidung, 5
:*:.msg2::MsgBox, 0,BaxterWorks Software informiert, 5 Sekunden zur Info, 5


; HTML Hotstrings, ganz kurze mit DREI Punkten

:*:.tb.de::https://www.tombesch.de
:*:.bw.de::http://www.baxterworks.de
:*:.banner::https://www.tombesch.de/pix/md_pix/bw_banner.png
:*:.logo::https://www.tombesch.de/pix/md_pix/bw_software2.png
:*:.soft::http://www.baxterworks.de/software
:*:.help::http://www.baxterworks.de/software/hilfe/help.htm
:*:.git::https://github.com/T-Jah
:*:.blog::http://blog.baxterworks.de
:*:...p::<p id="bax"></p>
:*:.script::<script></script>
:*:.div::<div class="frame2"></div>
:*:.pic::<img class="frame2_pix_r" src="fixpix/tb_kopf_c_kl.png">
:*:.link::<a href="https://www." title="Titel" class="basis" target="_new"></a>
:*:.html::<html><head><meta charset="utf-8"/><title>BaxterWorks Lernserver</title></head><body></body></html>
:*:.body::<body></body>
:*:.head::<head></head>
:*:...ul::<h5>Inhalt</h5><ul class=""><li class=""><a href="" class="">start</a></li></ul></div>
:*:.baxbox::<h5>Inhalt</h5><div class="baxbox"><div id="bax"><ul class="bax"><li class="bax"><a href="index.htm" class="bax">start</a></li></ul></div></div>
:*:.../::/*   BaxterWorks Software, © 1999-2021 T-Jah Tom, https://github.com/T-Jah   */
:*:.pre::<pre><code></code></pre>
:*:.code::<code></code>
:*:.style::<style></style>
:*:.form::<form><input type=button value="Fenster öffnen" onClick="fenster1()"></form>
:*:.button::<button></button>

; JavaScript Hotstrings

:*:doc.g::document.getElementById("bax").innerHTML = 
:*:doc.w::document.write
