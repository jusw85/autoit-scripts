AutoItSetOption("MouseClickDelay", 500)
AutoItSetOption("PixelCoordMode", 1)
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

;~ _WinWaitActivate("Play War of Omens, a free online game on Kongregate - Mozilla Firefox","")
;~ $hwnd = WinGetHandle("Play War of Omens");
;~ ConsoleWrite(@error & @CRLF);
;~ ConsoleWrite($hwnd & @CRLF);
;~ $color = PixelGetColor(614, 884);
;~ ConsoleWrite(Hex($color) & @CRLF);
;~ Exit(0)

$k = 0
$hwnd = WinGetHandle("Play War of Omens");
;~ While (@HOUR <> 4)
While (True)
	_WinWaitActivate("Play War of Omens, a free online game on Kongregate - Mozilla Firefox","")
;~ Local $color = PixelGetColor(615, 843)
;~ MsgBox(0, "", "The color at the current cursor position is " & Hex($color))
;~ Exit

	MouseClick("left",380,375,1) 		; skirmish
	Sleep(1500)
;~ 	MouseClick("left",380,680,1) 		; grandmaster
;~ 	If (Random(0,2,1)) Then
		MouseClick("left",380,495,1) 		; journeyman
;~ 	Else
;~ 		MouseClick("left",380,445,1) 		; apprentice
;~ 	EndIf
	Sleep(8000)

	MouseClick("left",380,430,1) 		; click to continue

	PixelSearch(581, 845, 581, 845, 0xFFFFFF, 0, 1, $hwnd)
	While @error
		For $j = 1 to 6
			MouseClick("left",580,750,1) 		; coin
		Next
		;MouseClick("left",220,510,1) 		; bank1
		;MouseClick("left",220,610,1) 		; bank2
		;MouseClick("left",220,710,1) 		; bank3
		For $j = 1 to 4
			MouseClick("left",120,800,1) 		; bank4
		Next
		Sleep(100)
		For $j = 1 to 2
			MouseClick("left",580,750,1) 		; possible reherd
		Next
		Sleep(100)
		MouseClick("left",600,870,1)		; end

		Sleep(6000)

		PixelSearch(581, 845, 581, 845, 0xFFFFFF, 0, 1, $hwnd)
	WEnd

	Sleep(1000)
	MouseClick("left",560,840,1) 		; endgame continue
	Sleep(2000)

	$k = $k + 1
	If ($k = 35) Then
		$k = 0
		MouseClick("left",1000,60,1)	; reload
		Sleep(600000)
;~ 		Sleep(30000000)
	EndIf

WEnd
#endregion --- Au3Recorder generated code End ---
