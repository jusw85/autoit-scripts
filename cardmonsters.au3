HotKeySet("#g", "Terminate")
Func Terminate()
	Exit
EndFunc

#region ---Au3Recorder generated code Start (v3.3.7.0)  ---

#region --- Internal functions Au3Recorder Start ---
Func _Au3RecordSetup()
Opt('WinWaitDelay',100)
Opt('WinDetectHiddenText',1)
Opt('MouseCoordMode',0)
EndFunc

Func _WinWaitActivate($title,$text,$timeout=0)
	WinWait($title,$text,$timeout)
	If Not WinActive($title,$text) Then WinActivate($title,$text)
	WinWaitActive($title,$text,$timeout)
EndFunc


_AU3RecordSetup()
#endregion --- Internal functions Au3Recorder End ---

While (true)
	_WinWaitActivate("Play Card Monsters, a free online game on Kongregate - Mozilla Firefox","")
	;MouseClick("left",910,60,1) 		; refresh
	MouseClick("left",1200,150,1) 		; refresh
	Sleep(500)
	Send("^r")
	Sleep(20000)
	MouseClick("left",490,840,1) 		; play
	Sleep(5000)
	MouseClick("left",480,570,1) 		; level select
	Sleep(500)

	For $i = 1 To 10
		MouseClick("left",330,550,1) 		; stage select
		Sleep(500)
		MouseClick("left",490,780,1) 		; play
		Sleep(8000)
		MouseClick("left",530,620,1) 		; cancel insufficient light

		For $j = 1 To 10
			MouseClick("left",80,600,1)		; card select
			MouseClick("left",580,600,1)	; card play
			Sleep(3000)
			MouseClick("left",490,830,1) 	; round start
			Sleep(5000)
		Next
		MouseClick("left",950,400,1)		; cancel round window
		Sleep(7000)
	Next

WEnd
#endregion --- Au3Recorder generated code End ---
