;AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("SendKeyDelay", 10)
AutoItSetOption("SendKeyDownDelay", 10)

HotKeySet("#c", "Input")
HotKeySet("#g", "Terminate")

Global $Down = False
Global $Down1 = False

While (true)
	Sleep(1000)
	If WinExists("Deploy Application to Google") Then
		ConsoleWrite("Sending!")
		ControlSend ("Deploy Application to Google", "", "Edit1", "email")
		ControlSend ("Deploy Application to Google", "", "Edit2", "password")
		ControlClick ( "Deploy Application to Google", "", "Button2")
	EndIf
WEnd

Func Input()
	Send("email")
	Send("{Tab}")
	Send("password")
EndFunc

Func Terminate()
	Exit
EndFunc

