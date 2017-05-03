#include <Array.au3>
#include <NomadMemory.au3>

AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("PixelCoordMode", 0) ;0 = relative coords to the defined window(include blue menu bar on top)
AutoItSetOption("SendKeyDownDelay", 100)

HotKeySet("#g", "Terminate")
HotKeySet("#p", "TogglePause")
HotKeySet("^!k", "Fishing")
#comments-start
813 855
EDE8D3
F1EABB
EADD91
    855
813 875
814
815
#comments-end
;HotKeySet("^!i", "Press_2")
;HotKeySet("^!o", "Press_3")
;HotKeySet("^!p", "Press_4")
HotKeySet("^!l", "Crafting")
HotKeySet("^!h", "KeepEntering")
HotKeySet("^!u", "KeepSelling")

Global $Paused = 0
Global $Start_Ptr = 0x0335B6C0
Global $End_Ptr = 0x0CF8F02C
Global $Mem_Address = 0x0E218824
Global $Msg_Ptr = 0

Global $Process = WinGetProcess("FINAL FANTASY XIV")
Global $Mem_Open = _MemoryOpen($Process)
Global $HWnd = WinGetHandle("FINAL FANTASY XIV")

While 1
	Sleep(1000000)
WEnd
;FDBC2E
;890 730
;900 740
Func Press_2b()
	PixelSearch(893, 730, 903, 740, 0xFDBC2E, 0, 1, $HWnd)
	While @error
		Sleep(1)
		PixelSearch(893, 730, 903, 740, 0xFDBC2E, 0, 1, $HWnd)
	WEnd
	SendKey("{Enter}")
EndFunc
Func Press_2()
	PixelSearch(885, 725, 895, 785, 0xFCA92B, 3, 1, $HWnd)
	While @error
		Sleep(10)
		PixelSearch(885, 725, 895, 785, 0xFCA92B, 3, 1, $HWnd)
	WEnd
	SendKey("{Enter}")
	SendKey("{Enter}")
EndFunc

Func Press_4()
	PixelSearch(950, 725, 960, 785, 0xFCA92B, 3, 1, $HWnd)
	While @error
		Sleep(10)
		PixelSearch(950, 725, 960, 785, 0xFCA92B, 3, 1, $HWnd)
	WEnd
	SendKey("{Enter}")
	SendKey("{Enter}")
EndFunc


Func Press_3()
	SendKey("{Enter}")
	SendKey("{Enter}")
	SendKey("{Enter}")
	SendKey("{Enter}")
	SendKey("{Enter}")
EndFunc

Func Fishing()
	ConsoleWrite("Starting fishing" & @CRLF)
	Dim $State = 3
	Dim $Nibble = 0
	MsgPtrInit()
	While True
		Sleep(200)
		Dim $Messages = MsgDiff()
		for $i = 0 to UBound($Messages) - 1
			Dim $Message = $Messages[$i]
			ConsoleWrite("Message: " & $Message & @CRLF)
			If StringStartsWith($Message, "You feel a nibble.") Then
				ConsoleWrite("	feel a nibble" & @CRLF)
				Sleep(1000)
				$Nibble = $Nibble + 1
				If $Nibble >= 3 Then
					$State = 3
					Sleep(2000)
					SendKey("{Down}")
					Sleep(1000)
					SendKey("{Enter}")
					Press_3()
				EndIf
				While IsWaitWhite()
					SendKey("{Enter}")
					Sleep(1000)
				WEnd
				;SendKey("{Enter}")
				;SendKey("{Enter}")
			ElseIf StringStartsWith($Message, "You feel a bite.") OR _
				StringStartsWith($Message, "Something big hits your line!") Then
				ConsoleWrite("	feel a bite" & @CRLF)
				$State = 3
				Sleep(2000)
				#comments-start
				While Not IsSecondOptionSelected()
					SendKey("{Down}")
					Sleep(1000)
				WEnd

				While IsJigWhite2()
					Sleep(1000)
					SendKey("{Enter}")
				WEnd
				#comments-end
				SendKey("{Down}")
				SendKey("{Enter}")
				Press_3()
			ElseIf StringStartsWith($Message, "You have hooked something but cannot reel it in.") Then
				ConsoleWrite("	first bite" & @CRLF)
				Sleep(2000)
				While IsJigWhite1()
					SendKey("{Enter}")
					Sleep(100)
				WEnd
				;SendKey("{Enter}")
				$State = 2
				Press_2()
			ElseIf StringStartsWith($Message, "The fish is taking line.") Then
				ConsoleWrite("	fish taking line" & @CRLF)
				Sleep(2000)
				While IsJigWhite1()
					SendKey("{Enter}")
					Sleep(100)
				WEnd
				;ConsoleWrite("	found!" & @CRLF)
				;SendKey("{Enter}")
				$State = 4
				Press_4()
			ElseIf StringStartsWith($Message, "You take in some line.") Then
				ConsoleWrite("	you taking line" & @CRLF)
				Sleep(2000)
				While IsJigWhite1()
					SendKey("{Enter}")
					Sleep(100)
				WEnd
				$State = 4
				Press_4()
			ElseIf StringStartsWith($Message, "The fish has tired, but you still cannot reel it in.") Then
				ConsoleWrite("	tired " & $State & @CRLF)
				Sleep(2000)
				If $State == 3 Then
					Press_3()
				Else
					While IsJigWhite1()
						SendKey("{Enter}")
						Sleep(100)
					WEnd
					If $State == 2 Then
						Press_2()
					ElseIf $State == 4 Then
						Press_4()
					EndIf
				EndIf
			ElseIf StringStartsWith($Message, "The fish got away.") OR _
				StringStartsWith($Message, "Nothing bites.") OR _
				StringStartsWith($Message, "You sense") Then
				$Nibble = 0;
				ConsoleWrite("	reset" & @CRLF)

				PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0, 1, $HWnd)
				While @error
					Sleep(1000)
					PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0, 1, $HWnd)
				WEnd
				ConsoleWrite("	found" & @CRLF)
				While IsWaitWhite()
					SendKey("{Enter}")
					Sleep(1000)
				WEnd
				#comments-start
				Sleep(2000)
				For $i = 1 to 5
					SendKey("{Enter}")
					Sleep(500)
				Next
				#comments-end
			EndIf
		Next
	WEnd
EndFunc

Func GetString($Ptr, $Diff)
	return Stringreplace(BinaryToString(_MemoryRead($Ptr, $Mem_Open, "byte["&$Diff&"]")),chr(0),"",0,1)
EndFunc

Func MsgPtrInit()
	$Msg_Ptr = _MemoryRead($Mem_Address, $Mem_Open)
EndFunc

Func MsgDiff()
	Dim $i
	Dim $Text
	Dim $Ptr1 = $Msg_Ptr
	Dim $Ptr2 = _MemoryRead($Mem_Address, $Mem_Open)

	If $Ptr1 == $Ptr2 Then
		Return
	ElseIf $Ptr2 > $Ptr1 Then
		Dim $Diff = $Ptr2 - $Ptr1
		$Text = GetString($Ptr1, $Diff)
		$Msg_Ptr = $Ptr2
	Else
		Dim $EndText = GetString($Ptr1, 256)
		Dim $TruncateEnd
		If StringStartsWith($EndText, "0020") Then
			Dim $TruncateEndArr = StringRegExp($EndText, '(0020::.+?(\.|!))', 1)
			$TruncateEnd = $TruncateEndArr[0]
		Else
			$TruncateEnd = ""
		EndIf

		Dim $Diff = $Ptr2 - $Start_Ptr
		Dim $StartText
		If $Diff == 0 Then
			$StartText = ""
		Else
			$StartText = GetString($Start_Ptr, $Diff)
		EndIf

		$Msg_Ptr = $Ptr2
		$Text = $TruncateEnd & $StartText
		ConsoleWrite("Wrapped Ptr" &@CRLF)
		ConsoleWrite($EndText & @CRLF)
		ConsoleWrite($TruncateEnd & @CRLF)
		ConsoleWrite($StartText & @CRLF)
	EndIf

	ConsoleWrite("Original Text: " & $Text & @CRLF)
	Dim $asResult = StringRegExp($Text, '(?:0020::)(.+?)(?=00|$)', 3)

	If @error == 0 Then
		Return $asResult
	EndIf
EndFunc

Func GetMessages()
	Dim $i
	Dim $Text
	Dim $Ptr1 = _MemoryRead($Mem_Address, $Mem_Open)
	;ConsoleWrite(Hex($Ptr1) & " - ")
	Sleep(500)
	Dim $Ptr2 = _MemoryRead($Mem_Address, $Mem_Open)
	;ConsoleWrite(Hex($Ptr2) & @CRLF)

	If $Ptr1 == $Ptr2 Then
		;ConsoleWrite("No data"  & @CRLF)
		Return
	ElseIf $Ptr2 > $Ptr1 Then
		;ConsoleWrite(Hex($Ptr1) & " - ")
		;ConsoleWrite(Hex($Ptr2) & @CRLF)
		;ConsoleWrite("Normal ptr" & @CRLF)
		Dim $Diff = $Ptr2 - $Ptr1
		;$Text = Stringreplace(BinaryToString(_MemoryRead($Ptr1, $Mem_Open, "byte["&$Diff&"]")),chr(0),"",0,1)
		$Text = GetString($Ptr1, $Diff)
		;ConsoleWrite("(" & $Diff & ") ")
	Else
		;ConsoleWrite(Hex($Ptr1) & " - ")
		;ConsoleWrite(Hex($Ptr2) & @CRLF)
		;ConsoleWrite("Wrapped Ptr" & @CRLF)
		Dim $Diff1 = $End_Ptr - $Ptr1
		;Dim $EndText = _MemoryRead($Ptr1, $Mem_Open, "char["&$Diff1&"]")
		Dim $EndText = GetString($Ptr1, $Diff1)
		;Stringreplace(BinaryToString(_MemoryRead($Ptr1, $Mem_Open, "byte["&$Diff1&"]")),chr(0),"",0,1)

		Dim $TruncateEnd
		If StringCompare(StringLeft($EndText, 4), "0020") == 0 Then
			Dim $TruncateEndArr = StringRegExp($EndText, '(0020::.+?(\.|!))', 1)
			$TruncateEnd = $TruncateEndArr[0]
		Else
			$TruncateEnd = ""
		EndIf
		;$EndText=Stringreplace($EndText,chr(0),"",0,1)
		;$EndText = StringLeft($EndText, 9)

		Dim $Diff2 = $Ptr2 - $Start_Ptr
		Dim $StartText
		If $Diff2 == 0 Then
			$StartText = ""
		Else
			;$StartText = Stringreplace(BinaryToString(_MemoryRead($Start_Ptr, $Mem_Open, "byte["&$Diff2&"]")),chr(0),"",0,1)
			$StartText = GetString($Start_Ptr, $Diff2)
		EndIf

		$Text = $TruncateEnd & $StartText
		ConsoleWrite("End(" & $Diff1 & ") " & "Start(" & $Diff2 & ")" &@CRLF)
		ConsoleWrite($EndText & @CRLF)
		ConsoleWrite($TruncateEnd & @CRLF)
		ConsoleWrite($StartText & @CRLF)
	EndIf

	;$TextReplace=Stringreplace($Text,chr(0),"",0,1)
	ConsoleWrite("Original Text: " & $Text & @CRLF)
	Dim $asResult = StringRegExp($Text, '(?:0020::)(.+?)(?=00|$)', 3)

	If @error == 0 Then
		Return $asResult
	EndIf
	Return
EndFunc


Func Crafting()
	Sleep(1000)
	Dim $begin
	Dim $dif
	Dim $iterations = InputBox("Inputbox", "Enter number of times to craft(valid number please)")
	Dim $quit = InputBox("Inputbox", "Quit after completion")
	Sleep(1000)
	For $i = 1 to $iterations
		ConsoleWrite($i & "/" & $iterations & @CRLF)
		$begin = TimerInit()
		While Not IsRecipeSelected()
			SendKey("{Down}")
			Sleep(1000)
			$dif = TimerDiff($begin)
			If $dif >= 300000  And $quit == "y" Then
				Quit()
				Sleep(60000)
				Shutdown(25)
			EndIf
		WEnd
		$begin = TimerInit()
		While Not IsSynthesizing()
			SendKey("{Enter}")
			Sleep(1000)
			$dif = TimerDiff($begin)
			If $dif >= 300000  And $quit == "y" Then
				Quit()
				Sleep(60000)
				Shutdown(25)
			EndIf
		WEnd
		$begin = TimerInit()
		While IsSynthesizing()
			SendKey("{Enter}")
			Sleep(1000)
			$dif = TimerDiff($begin)
			If $dif >= 300000  And $quit == "y" Then
				Quit()
				Sleep(60000)
				Shutdown(25)
			EndIf
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
	Dim $c1, $c2, $c3
	PixelSearch(495, 801, 495, 805, 0x68803B, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(495, 801, 495, 805, 0xF4EECB, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(495, 801, 495, 805, 0xD4D678, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsInCraftingMenu()
	Dim $c1, $c2, $c3
	PixelSearch(128, 107, 128, 107, 0xF2F2F2, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(128, 108, 128, 108, 0xECECEC, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(128, 109, 128, 109, 0xEAEAEA, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsRecipeSelected()
	Dim $c1, $c2, $c3
	PixelSearch(128, 107, 128, 107, 0xF2F2F3, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(128, 108, 128, 108, 0xEDEEF0, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(128, 109, 128, 109, 0xECEDEF, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsWaitWhite()
	Dim $c1, $c2, $c3
	PixelSearch(879, 854, 879, 854, 0xEFEFEF, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(879, 855, 879, 855, 0xE7E7E7, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(879, 853, 879, 853, 0xC7C7C7, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsJigWhite1()
	Dim $c1, $c2, $c3
	PixelSearch(854, 853, 854, 853, 0xF1F1F1, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(854, 852, 854, 852, 0xE3E3E3, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(854, 854, 854, 854, 0xEEEEEE, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsJigWhite2()
	Dim $c1, $c2, $c3
	PixelSearch(854, 873, 854, 873, 0xF1F1F1, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(854, 872, 854, 872, 0xE3E3E3, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(854, 874, 854, 874, 0xEEEEEE, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2 And $c3
EndFunc

Func IsJigHighlighted()
	Dim $c1, $c2, $c3
	PixelSearch(859, 872, 859, 872, 0xB8B9B9, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(859, 871, 859, 871, 0xB7B9BD, 0, 1, $HWnd)
	$c2 = Not @error
	return $c1 And $c2
EndFunc

Func IsFirstOptionSelected()
	;813 855  EDE8D3
	;814 855  F1EABB
	;815 855  EADD91
	Dim $c1, $c2, $c3
	PixelSearch(813, 855, 813, 855, 0xEDE8D3, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(814, 855, 814, 855, 0xF1EABB, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(815, 855, 815, 855, 0xEADD91, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2
EndFunc

Func IsSecondOptionSelected()
	;813 855  EDE8D3
	;814 855  F1EABB
	;815 855  EADD91
	Dim $c1, $c2, $c3
	PixelSearch(813, 875, 813, 875, 0xEDE8D3, 0, 1, $HWnd)
	$c1 = Not @error
	PixelSearch(814, 875, 814, 875, 0xF1EABB, 0, 1, $HWnd)
	$c2 = Not @error
	PixelSearch(815, 85, 815, 875, 0xEADD91, 0, 1, $HWnd)
	$c3 = Not @error
	return $c1 And $c2
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
	ControlSend("FINAL FANTASY XIV", "", "", $key)
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
		If Not $Paused Then
			SendKey("{Enter}")
			;SendKey("1")
		EndIf

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