;AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("SendKeyDelay", 100)
AutoItSetOption("SendKeyDownDelay", 100)

;HotKeySet("h", "Mining")
HotKeySet("h", "Fighting")
HotKeySet("#g", "Terminate")

Global $Down = False
Global $Down1 = False

While (true)
	Sleep(3600000)
WEnd

Func Mining()
	$Down = Not $Down
	If $Down Then
		MouseDown("left")
	Else
		MouseUp("left")
	EndIf
EndFunc

Func Fighting()
	$Down1 = Not $Down1
	While ($Down1)
		MouseClick("left")
		Sleep(50)
	WEnd
EndFunc

Func Terminate()
	Exit
EndFunc

