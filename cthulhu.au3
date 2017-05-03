AutoItSetOption("PixelCoordMode", 0)
AutoItSetOption("SendKeyDelay", 100)
AutoItSetOption("SendKeyDownDelay", 100)

HotKeySet("^z", "Macro")
HotKeySet("^x", "Click")
HotKeySet("^c", "Click2")
HotKeySet("#g", "Terminate")

Global $HWnd = WinGetHandle("Cthulhu Saves The World")
Global $Down = False
Global $Down1 = False

While (true)
	Sleep(3600000)
WEnd

Func Click()
	MouseClick("left")
EndFunc

Func Click2()
	Send("{Altdown}")
	Sleep(100)
	For $i = 1 to 10 Step 1
		MouseClick("left")
	Next
	Sleep(100)
	Send("{Altup}")
EndFunc

Func Macro()
	Send("i")
	Send("s")
	Send("s")
	Send("j")
	Sleep(1700)
	Send("j")
	Send("j")

; fireball
;~ 	Send("s")
;~ 	Send("s")
;~ 	Send("j")
	Send("j")

;~ 	Send("s")
;~ 	Send("s")
;~ 	Send("j")
;~ 	Send("w")
;~ 	Send("w")
;~ 	Send("j")

;~ 	Send("s")
;~ 	Send("j")

;~ 	Send("s")
;~ 	Send("j")
;~ 	Send("w")
;~ 	Send("w")
;~ 	Send("w")
;~ 	Send("w")
;~ 	Send("j")

;~ 	Send("j")
;~ 	Send("j")

;~ 	Send("s")
;~ 	Send("s")
;~ 	Send("j")
;~ 	Send("w")
;~ 	Send("j")

	PixelSearch(610, 397, 610, 397, 0xBD1400, 0, 1, $HWnd)
	While @error
 		Send("j")
 		Sleep(10)
		PixelSearch(610, 397, 610, 397, 0xBD1400, 0, 1, $HWnd)
	WEnd
	ConsoleWrite("pixel found")
	Sleep(500)
	Macro();

;~ 	While ($i < 1000)
;~ 		Send("j")
;~ 		Sleep(10)
;~ 		$i += 10
;~ 	WEnd
;~ 	Macro();
EndFunc

Func Terminate()
	Exit
EndFunc

