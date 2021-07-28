^#F3::
:*:.dann::
  IniRead, OutputDays, %homeini%, DateCalc, SavedDay, 0
  if OutputDays is not digit
    OutputDays = 0
  InputBox, InputDays, Datum einfügen, Wieviele Tage sollen hinzuge-`nzählt oder abgezogen werden?,, 220, 140,,,,,%OutputDays%
  DateNow := A_Now
  DateNow += %InputDays%, days
  IniWrite, %InputDays%, %homeini%, DateCalc, SavedDay
  FormatTime, Date, %DateNow%, dd.MM.yyyy
  Send, %Date%

return