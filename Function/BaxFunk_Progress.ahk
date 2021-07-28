
/*
 * BaxProgressBar
 * Copyright 2021 T-Jah Tom
 * All Rights Reserved.
 * Use, reproduction, distribution, and modification of this code is subject to the terms and
 * conditions of the MIT license, available at http://www.opensource.org/licenses/mit-license.php
 *
 * Author: T-Jah Tom
 * Project: https://github.com/T-Jah
 *
 * ┌────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
 * │   Skriptoptionen 	                       [Version 009]                                                    │
 * └────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 *
 *                         BaxterWorks Software:	http://www.baxterworks.de/software
 *			                 http://blog.baxterworks.de
 *                                       ^ STRG + Shift ! Alt # WIN
 * 
 */

; Script options
#SingleInstance ignore			; oder off
#NoEnv
SetWorkingDir %Bax_Start%\		; wichtig
SendMode Input


;---------------------------------------------------------------->
; BaxProgressBar Funktion
;---------------------------------------------------------------->

BaxProgressBar(MicroSeconds, Intervals)
{
   Increment = 1
   Sleep % MicroSeconds / Intervals
   Loop %Intervals%
   {
      Progress % Increment * 100 / Intervals
      Sleep % MicroSeconds  / Intervals
      ++Increment
   }
if (Intervals > 50)
break
}


; Aufruf: BaxProgressBar(9000, 100)
