AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("SendKeyDelay", 100)
AutoItSetOption("SendKeyDownDelay", 100)

HotKeySet("+!x", "DoMouseMove")
HotKeySet("+!g", "Terminate")

Global $isMouseMoving = False

While (True)
	Sleep(3600000)
WEnd

Func DoMouseMove()
	$isMouseMoving = Not $isMouseMoving
	While ($isMouseMoving)
		MouseMove(600, 780)
		Sleep(50)
		MouseMove(600, 800)
		Sleep(50)
	WEnd
EndFunc   ;==>DoMouseMove

Func Terminate()
	Exit
EndFunc   ;==>Terminate
