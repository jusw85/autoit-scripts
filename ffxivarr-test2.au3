#include <Array.au3>
#include <NomadMemory.au3>

;AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("PixelCoordMode", 0) ;0 = relative coords to the defined window(include blue menu bar on top)
AutoItSetOption("SendKeyDelay", 100)
AutoItSetOption("SendKeyDownDelay", 100)

HotKeySet("#g", "Terminate")
HotKeySet("#p", "TogglePause")
HotKeySet("^!k", "Fishing")
HotKeySet("^!i", "Press_2")
HotKeySet("^!o", "Press_3")
HotKeySet("^!p", "Press_4")
HotKeySet("^!l", "Crafting2")
HotKeySet("^!h", "Test")

Global $Paused = 0
Global $Start_Ptr = 0x0D015F20
Global $End_Ptr = 0x0D017FB6
Global $Mem_Address = 0x0EA686F4
Global $Process1 = WinGetProcess("FINAL FANTASY XIV")
Global $Mem_Open = _MemoryOpen($Process1)


;$TruncateEnd = StringRegExp("0020::dfdf.dfdf", '(?:0020::)(.+?(\.|!))', 1)
;ConsoleWrite("HAI" & @CRLF)
;ConsoleWrite($TruncateEnd[0] & @CRLF)

Func Test()
Dim $hWnd = WinGetHandle("FINAL FANTASY XIV")
ConsoleWrite($hWnd)

$xx  = PixelGetColor(929, 788, $hWnd) ;F89C42
ConsoleWrite(Hex($xx) & @CRLF)
;PixelSearch(927, 789, 927, 789, 0x634322, 0)
EndFunc


While 1
;Dim $hWnd = WinGetHandle("FINAL FANTASY XIV")
;ConsoleWrite($hWnd)


#comments-start
	Dim $asResult = _
	StringRegExp("0020::You sense box turtles below where you are fishing.0020::Your line sinks to the desired depth.0020::You wait for a fish to bite.", _
	'(?:0020::)(.+?\.)(?=00|$)', 3)
	Dim $i
	If @error == 0 Then
		for $i = 0 to UBound($asResult) - 1
			ConsoleWrite($asResult[$i] & @CRLF)
		Next

	EndIf
#comments-end

	Sleep(1000000)
WEnd

Func Press_2()
	AutoItSetOption("SendKeyDelay", 0)
	PixelSearch(885, 725, 895, 785, 0xFCA92B, 3)
	While @error
		Sleep(10)
		PixelSearch(885, 725, 895, 785, 0xFCA92B, 3)
	WEnd
	Send("{Enter}")
	AutoItSetOption("SendKeyDelay", 100)
EndFunc

Func Press_4()
	AutoItSetOption("SendKeyDelay", 0)
	PixelSearch(950, 725, 960, 785, 0xFCA92B, 3)
	While @error
		Sleep(10)
		PixelSearch(950, 725, 960, 785, 0xFCA92B, 3)
	WEnd
	Send("{Enter}")
	AutoItSetOption("SendKeyDelay", 100)
EndFunc


Func Press_3()
	AutoItSetOption("SendKeyDelay", 0)
	Send("{Enter}")
	Send("{Enter}")
	Send("{Enter}")
	#comments-start
	PixelSearch(920, 725, 922, 785, 0xFCA92B, 3)
	While @error
		Sleep(10)
		PixelSearch(920, 725, 922, 785, 0xFCA92B, 3)
	WEnd
	Send("{Enter}")
	#comments-end
	AutoItSetOption("SendKeyDelay", 100)
EndFunc
#comments-start
Func Press_3()
	AutoItSetOption("SendKeyDelay", 0)
	;AutoItSetOption("SendKeyDownDelay", 40)
	PixelSearch(919, 726, 927, 736, 0xFCA92B, 0)
	While @error
		Sleep(1)
		PixelSearch(919, 726, 927, 736, 0xFCA92B, 0)
	WEnd
	Send("{Enter}")
	ConsoleWrite("SEND!")
	AutoItSetOption("SendKeyDelay", 100)
	;AutoItSetOption("SendKeyDownDelay", 100)
EndFunc
#comments-end

Func Fishing()
	ConsoleWrite("Starting fishing" & @CRLF)
	Dim $State = 3;
	While True
		Dim $Messages = GetMessages()
		for $i = 0 to UBound($Messages) - 1
			Dim $Message = $Messages[$i]
			ConsoleWrite("Message: " & $Message & @CRLF)
			If StringCompare(StringLeft($Message, 18), "You feel a nibble.") == 0 Then
				ConsoleWrite("	feel a nibble" & @CRLF)
				Sleep(1000)
				Send("{Enter}")
			ElseIf StringCompare(StringLeft($Message, 16), "You feel a bite.") == 0 Then
				ConsoleWrite("	feel a bite" & @CRLF)
				$State = 3
				Sleep(2000)
				Send("{Down}")
				Sleep(1000)
				Send("{Enter}")
				;Sleep(500)
				Press_3()
			ElseIf StringCompare(StringLeft($Message, 48), "You have hooked something but cannot reel it in.") == 0 Then
				ConsoleWrite("	first bite" & @CRLF)
				Sleep(2000)
				Send("{Enter}")
				$State = 2
				Sleep(200)
				Press_2()
			ElseIf StringCompare(StringLeft($Message, 24), "The fish is taking line.") == 0 Then
				ConsoleWrite("	fish taking line" & @CRLF)
				Sleep(2000)
				Send("{Enter}")
				$State = 4
				Sleep(200)
				Press_4()
			ElseIf StringCompare(StringLeft($Message, 22), "You take in some line.") == 0 Then
				ConsoleWrite("	you taking line" & @CRLF)
				Sleep(2000)
				Send("{Enter}")
				$State = 4
				Sleep(200)
				Press_4()
			ElseIf StringCompare(StringLeft($Message, 52), "The fish has tired, but you still cannot reel it in.") == 0 Then
				ConsoleWrite("	tired " & $State & @CRLF)
				Sleep(2000)
				Send("{Enter}")
				If $State == 2 Then
					Press_2()
				ElseIf $State == 3 Then
					Press_3()
				ElseIf $State == 4 Then
					Press_4()
				EndIf
			ElseIf StringCompare(StringLeft($Message, 18), "The fish got away.") == 0 OR _
				StringCompare(StringLeft($Message, 14), "Nothing bites.") == 0  OR _
				StringCompare(StringLeft($Message, 9), "You sense") == 0 OR _
				StringCompare(StringLeft($Message, 23), "You reel in your catch!") == 0 Then

				ConsoleWrite("	reset" & @CRLF)

				PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0)
				While @error
					Sleep(1000)
					PixelSearch(924, 801, 924, 801, 0xFFFEFB, 0)
				WEnd
				ConsoleWrite("	found" & @CRLF)
				Sleep(2000)
				For $i = 1 to 5
					Send("{Enter}")
					Sleep(500)
				Next

				;Sleep(15000)
				;Send("{Enter}")
				;Sleep(500)
				;Send("{Enter}")
				;Sleep(500)
				;Send("{Enter}")
				;Sleep(500)
				;Send("{Enter}")
			EndIf
		Next
	WEnd
EndFunc

Func GetString($Ptr, $Diff)
	return Stringreplace(BinaryToString(_MemoryRead($Ptr, $Mem_Open, "byte["&$Diff&"]")),chr(0),"",0,1)
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
		Dim $EndText = Stringreplace(BinaryToString(_MemoryRead($Ptr1, $Mem_Open, "byte["&$Diff1&"]")),chr(0),"",0,1)

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
			$StartText = Stringreplace(BinaryToString(_MemoryRead($Start_Ptr, $Mem_Open, "byte["&$Diff2&"]")),chr(0),"",0,1)
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

Func PixelTest($str)
	Dim $var1, $var2, $var3
	$var1 = PixelGetColor (495, 802) ;68803B
	$var2 = PixelGetColor (495, 803) ;F4EECB
	$var3 = PixelGetColor (495, 804) ;D4D678
	MsgBox(1, "Msgbox", Hex($var1, 6) & @CRLF & Hex($var2, 6) & @CRLF & Hex($var3, 6))
EndFunc

Func Crafting1()
	Sleep(1000)
	For $i = 1 to 5
		Send("{Down}")
		Sleep(500)
		For $j = 1 to 17
			Send("{Enter}")
			Sleep(5000)
		Next
		Send("{Escape}")
		Sleep(2000)
	Next
EndFunc

Func Crafting2()
	Sleep(1000)
	Dim $iterations = InputBox("Inputbox", "Enter number of times to craft(valid number please)")
	Sleep(1000)
	For $i = 1 to $iterations
		ConsoleWrite($i & "/" & $iterations & @CRLF)

		Send("{Down}")

		Sleep(1000);
		Send("{Enter}") ;enter recipe screen
		Sleep(3000)
		Send("{Enter}") ;select recipe
		Sleep(4000)
		Send("{Enter}") ;select mainhand
		Sleep(4000)
		Send("{Enter}") ;select confirmation
		Sleep(6000) ;preparing to craft

		#comments-start

		PixelSearch(495, 801, 495, 805, 0xF4EECB)
		While @error
			Send("{Enter}")
			Sleep(1000)
			PixelSearch(495, 801, 495, 805, 0xF4EECB)
		WEnd




		#comments-end
		PixelSearch(495, 801, 495, 805, 0xF4EECB)
		While Not @error
			Send("{Enter}")
			Sleep(1000)
			PixelSearch(495, 801, 495, 805, 0xF4EECB)
		WEnd

		;Display("done!")
		Sleep(6000)
	Next
	Beep()
	Quit()
	Sleep(60000)
	;Shutdown(9)
	Shutdown(25)
EndFunc

Func IsSynthesizing()
EndFunc

Func Quit()
	_MemoryClose($Mem_Open)
	Sleep(1000)
	Send("!{F4}")
	Sleep(1000)
	Send("{Enter}")
EndFunc

