#include <Array.au3>
#include <NomadMemory.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("PixelCoordMode", 0) ;0 = relative coords to the defined window(include blue menu bar on top)
AutoItSetOption("SendKeyDownDelay", 100)

HotKeySet("#g", "Terminate")
HotKeySet("#p", "TogglePause")
HotKeySet("^!k", "Fishing")
HotKeySet("^!i", "Press_2")
HotKeySet("^!o", "Press_3")
HotKeySet("^!p", "Press_4")
;HotKeySet("^!l", "Crafting")
HotKeySet("^!l", "Craft2")
HotKeySet("^!h", "KeepEntering")
HotKeySet("^!u", "KeepSelling")

Global $Paused = 0
Global $Start_Ptr = 0x212A7008
Global $End_Ptr = 0x212A7D5C
Global $Mem_Address = 0x0DABABA4
Global $Process = WinGetProcess("FINAL FANTASY XIV")
Global $Mem_Open = _MemoryOpen($Process)
Global $HWnd = WinGetHandle("FINAL FANTASY XIV")

While 1
	Sleep(1000000)
WEnd

; undyed cotton cloth (single craft)
Func Craft4()
	Dim Const $logout = True
	Dim Const $hq = False
	Dim Const $num_syn = 179
	Dim Const $num_hq_mats = 0
	Dim Const $hq_x = 722
	Dim Const $hq_y = 333
	Dim Const $syn_x = 800
	Dim Const $syn_y = 650
	Dim Const $logout_x = 900
	Dim Const $logout_y = 635
	AutoItSetOption("MouseClickDownDelay", 100)
	For $i = 0 to ($num_syn - 1)

		MouseClick("left", 110, 336, 1)
		Sleep(2000)
		MouseClick("left", 300, 280, 1)
		Sleep(2000)
		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^8")
		Sleep(Random(10000, 12000, 1))

		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^8")
		Sleep(Random(10000, 12000, 1))

		MouseClick("left", 300, 455, 1)
		Sleep(2000)
		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^8")
		Sleep(Random(10000, 12000, 1))
	Next
	Send("{ESC}")
	Sleep(5000)
	If $logout Then
		Send("^0")
		Sleep(5000)
		MouseClick("left", $logout_x, $logout_y, 1)
	EndIf
	Sleep(10000)
	AutoItSetOption("MouseClickDownDelay", 10)
	;Shutdown(1)
EndFunc

; duckbills?
Func Craft3()
	Dim Const $logout = True
	Dim Const $hq = False
	Dim Const $num_syn = 88
	Dim Const $num_hq_mats = 0
	Dim Const $hq_x = 722
	Dim Const $hq_y = 333
	Dim Const $syn_x = 800
	Dim Const $syn_y = 650
	Dim Const $logout_x = 900
	Dim Const $logout_y = 635
	AutoItSetOption("MouseClickDownDelay", 100)
	For $i = 0 to ($num_syn - 1)

		MouseClick("left", 104, 293, 1)
		Sleep(2000)
		MouseClick("left", 284, 246, 1)
		Sleep(2000)
		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^7")
		Sleep(Random(10000, 12000, 1))

		MouseClick("left", 134, 381, 1)
		Sleep(2000)
		MouseClick("left", 308, 205, 1)
		Sleep(2000)
		MouseClick("left", 612, 349, 1)
		Sleep(2000)
		MouseClick("left", 634, 359, 1)
		Sleep(2000)
		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^8")
		Sleep(Random(33000, 37000, 1))
		Send("^9")
		Sleep(Random(24000, 28000, 1))
	Next
	Send("{ESC}")
	Sleep(5000)
	If $logout Then
		Send("^0")
		Sleep(5000)
		MouseClick("left", $logout_x, $logout_y, 1)
	EndIf
	Sleep(10000)
	AutoItSetOption("MouseClickDownDelay", 10)
	;Shutdown(1)
EndFunc

Func Craft2()
	Dim Const $logout = False
	Dim Const $hq = False
	Dim Const $num_syn = 28
	Dim Const $num_hq_mats = 0
	Dim Const $hq_x = 722
	Dim Const $hq_y = 333
	Dim Const $syn_x = 800
	Dim Const $syn_y = 650
	Dim Const $logout_x = 900
	Dim Const $logout_y = 635
	AutoItSetOption("MouseClickDownDelay", 100)
	For $i = 0 to ($num_syn - 1)

		If $hq Then
			For $j = 0 to ($num_hq_mats - 1)
				MouseClick("left", $hq_x, $hq_y, 1)
				Sleep(2000)
			Next
		EndIf

		MouseClick("left", $syn_x, $syn_y, 1)
		Sleep(Random(8000, 10000, 1))
		Send("^8")
		;Sleep(Random(10000, 12000, 1))
		Sleep(Random(33000, 37000, 1))
		Send("^9")
		Sleep(Random(24000, 28000, 1))
	Next
	Send("{ESC}")
	Sleep(5000)
	If $logout Then
		Send("^0")
		Sleep(5000)
		MouseClick("left", $logout_x, $logout_y, 1)
	EndIf
	Sleep(10000)
	AutoItSetOption("MouseClickDownDelay", 10)
	Shutdown(1)
EndFunc

Func Press_2()
	AutoItSetOption("SendKeyDelay", 0)
	PixelSearch(885, 725, 895, 785, 0xFCA92B, 3, 1, $hWnd)
	While @error
		Sleep(10)
		PixelSearch(885, 725, 895, 785, 0xFCA92B, 3, 1, $hWnd)
	WEnd
	Send("{Enter}")
	AutoItSetOption("SendKeyDelay", 100)
EndFunc

Func Press_4()
	AutoItSetOption("SendKeyDelay", 0)
	PixelSearch(950, 725, 960, 785, 0xFCA92B, 3, 1, $hWnd)
	While @error
		Sleep(10)
		PixelSearch(950, 725, 960, 785, 0xFCA92B, 3, 1, $hWnd)
	WEnd
	Send("{Enter}")
	AutoItSetOption("SendKeyDelay", 100)
EndFunc


Func Press_3()
	Send("{Enter}")
	Send("{Enter}")
	Send("{Enter}")
EndFunc

Func Fishing()
	ConsoleWrite("Starting fishing" & @CRLF)
	Dim $State = 3;
	While True
		Dim $Messages = GetMessages()
		for $i = 0 to UBound($Messages) - 1
			Dim $Message = $Messages[$i]
			ConsoleWrite("Message: " & $Message & @CRLF)
			If StringStartsWith($Message, "You feel a nibble.") Then
				ConsoleWrite("	feel a nibble" & @CRLF)
				Sleep(1000)
				SendKey("{Enter}")
			ElseIf StringStartsWith($Message, "You feel a bite.") OR _
				StringStartsWith($Message, "Something big hits your line!") Then
				ConsoleWrite("	feel a bite" & @CRLF)
				$State = 3
				Sleep(2000)
				SendKey("{Down}")
				Sleep(1000)
				SendKey("{Enter}")
				Press_3()
			ElseIf StringStartsWith($Message, "You have hooked something but cannot reel it in.") Then
				ConsoleWrite("	first bite" & @CRLF)
				Sleep(2000)
				SendKey("{Enter}")
				$State = 2
				Sleep(200)
				Press_2()
			ElseIf StringStartsWith($Message, "The fish is taking line.") Then
				ConsoleWrite("	fish taking line" & @CRLF)
				Sleep(2000)
				SendKey("{Enter}")
				$State = 4
				Sleep(200)
				Press_4()
			ElseIf StringStartsWith($Message, "You take in some line.") Then
				ConsoleWrite("	you taking line" & @CRLF)
				Sleep(2000)
				SendKey("{Enter}")
				$State = 4
				Sleep(200)
				Press_4()
			ElseIf StringStartsWith($Message, "The fish has tired, but you still cannot reel it in.") Then
				ConsoleWrite("	tired " & $State & @CRLF)
				Sleep(2000)
				SendKey("{Enter}")
				If $State == 2 Then
					Press_2()
				ElseIf $State == 3 Then
					Press_3()
				ElseIf $State == 4 Then
					Press_4()
				EndIf
			ElseIf StringStartsWith($Message, "The fish got away.") OR _
				StringStartsWith($Message, "Nothing bites.") OR _
				StringStartsWith($Message, "You sense") OR _
				StringStartsWith($Message, "You reel in your catch!") Then

				ConsoleWrite("	reset" & @CRLF)

				PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0, 1, $hWnd)
				While @error
					Sleep(1000)
					PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0, 1, $hWnd)
				WEnd
				ConsoleWrite("	found" & @CRLF)
				;Sleep(2000)
				For $i = 1 to 5
					SendKey("{Enter}")
					Sleep(500)
				Next
			EndIf
		Next
	WEnd
EndFunc

Func GetString($Ptr, $Diff)
	return Stringreplace(BinaryToString(_MemoryRead($Ptr, $Mem_Open, "byte["&$Diff&"]")),chr(0),"",0,1)
EndFunc

Func GetMessages()
	Dim $Text
	Dim $Ptr1 = _MemoryRead($Mem_Address, $Mem_Open)
	Sleep(500)
	Dim $Ptr2 = _MemoryRead($Mem_Address, $Mem_Open)

	If $Ptr1 == $Ptr2 Then
		Return
	ElseIf $Ptr2 > $Ptr1 Then
		Dim $Diff = $Ptr2 - $Ptr1
		$Text = GetString($Ptr1, $Diff)
	Else
		Dim $Diff1 = $End_Ptr - $Ptr1
		Dim $EndText = GetString($Ptr1, $Diff1)

		Dim $TruncateEnd
		If StringCompare(StringLeft($EndText, 4), "0020") == 0 Then
			Dim $TruncateEndArr = StringRegExp($EndText, '(0020::.+?(\.|!))', 1)
			$TruncateEnd = $TruncateEndArr[0]
		Else
			$TruncateEnd = ""
		EndIf

		Dim $StartText
		Dim $Diff2 = $Ptr2 - $Start_Ptr
		If $Diff2 == 0 Then
			$StartText = ""
		Else
			$StartText = GetString($Start_Ptr, $Diff1)
		EndIf

		$Text = $TruncateEnd & $StartText
		ConsoleWrite("End(" & $Diff1 & ") " & "Start(" & $Diff2 & ")" &@CRLF)
		ConsoleWrite($EndText & @CRLF)
		ConsoleWrite($TruncateEnd & @CRLF)
		ConsoleWrite($StartText & @CRLF)
	EndIf

	ConsoleWrite("Original Text: " & $Text & @CRLF)
	Dim $asResult = StringRegExp($Text, '(?:0020::)(.+?)(?=00|$)', 3)

	If @error == 0 Then
		Return $asResult
	EndIf
	Return
EndFunc


Func Crafting()
	Sleep(1000)
	Dim $iterations = InputBox("Inputbox", "Enter number of times to craft(valid number please)")
	Dim $quit = InputBox("Inputbox", "Quit after completion")
	Sleep(1000)
	For $i = 1 to $iterations
		ConsoleWrite($i & "/" & $iterations & @CRLF)
		While Not IsRecipeSelected()
			SendKey("{Down}")
			Sleep(1000)
		WEnd
		While Not IsSynthesizing()
			SendKey("{Enter}")
			Sleep(1000)
		WEnd
		While IsSynthesizing()
			SendKey("{Enter}")
			Sleep(1000)
		WEnd
		While Not IsInCraftingMenu()
			Sleep(1000)
		WEnd
	Next
	Beep()
	If $quit == "y" Then
		Quit()
		Sleep(60000)
		Shutdown(25)
	EndIf
EndFunc

Func IsSynthesizing()
	PixelSearch(495, 801, 495, 805, 0x68803B, 0, 1, $HWnd)
	Dim $c1 = Not @error
	PixelSearch(495, 801, 495, 805, 0xF4EECB, 0, 1, $HWnd)
	Dim $c2 = Not @error
	PixelSearch(495, 801, 495, 805, 0xD4D678, 0, 1, $HWnd)
	Dim $c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsInCraftingMenu()
	PixelSearch(128, 107, 128, 107, 0xF2F2F2, 0, 1, $HWnd)
	Dim $c1 = Not @error
	PixelSearch(128, 108, 128, 108, 0xECECEC, 0, 1, $HWnd)
	Dim $c2 = Not @error
	PixelSearch(128, 109, 128, 109, 0xEAEAEA, 0, 1, $HWnd)
	Dim $c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsRecipeSelected()
	PixelSearch(128, 107, 128, 107, 0xF2F2F3, 0, 1, $HWnd)
	Dim $c1 = Not @error
	PixelSearch(128, 108, 128, 108, 0xEDEEF0, 0, 1, $HWnd)
	Dim $c2 = Not @error
	PixelSearch(128, 109, 128, 109, 0xECEDEF, 0, 1, $HWnd)
	Dim $c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func TogglePause()
	$Paused = ($Paused * -1) + 1
EndFunc

Func Terminate()
	_MemoryClose($Mem_Open)
	Exit
EndFunc

Func Display($str)
	MsgBox(1, "Msgbox", $str)
EndFunc

Func SendKey($key)
	ControlSend("FINAL FANTASY XIV: A Realm Reborn", "", "", $key)
EndFunc

Func SendClick($button, $x, $y, $clicks=1)
	ControlClick("FINAL FANTASY XIV: A Realm Reborn", "", "", $button, $clicks, $x, $y)
EndFunc

Func Quit()
	_MemoryClose($Mem_Open)
	Sleep(1000)
	Send("!{F4}")
	Sleep(1000)
	Send("{Enter}")
EndFunc

Func KeepSelling()
	Sleep(1000)
	Dim $iterations = InputBox("Inputbox", "Enter number of times to craft(valid number please)")
	Sleep(1000)
	For $i = 1 to $iterations
		ConsoleWrite($i & "/" & $iterations & @CRLF)
		SendKey("{Enter}")
		Sleep(2000)
		SendKey("{Left}")
		Sleep(2000)
		SendKey("{Enter}")
		Sleep(2000)
	Next
EndFunc

Func KeepEntering()
	Sleep(1000)
	While 1
		SendKey("{Enter}")
		Sleep(2000)
	Wend
EndFunc

Func StringStartsWith($str, $startsWith)
	Return StringCompare(StringLeft($str, StringLen($startsWith)), $startsWith) == 0
EndFunc

Func PixelTest($str)
	Dim $var1, $var2, $var3
	$var1 = PixelGetColor (495, 802) ;68803B
	$var2 = PixelGetColor (495, 803) ;F4EECB
	$var3 = PixelGetColor (495, 804) ;D4D678
	MsgBox(1, "Msgbox", Hex($var1, 6) & @CRLF & Hex($var2, 6) & @CRLF & Hex($var3, 6))
EndFunc