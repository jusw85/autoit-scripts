#include-once
#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include <Misc.au3>


; #FUNCTION# ;===============================================================================
;
; Name...........: _WinSelect
; Description ...: Returns the Handle of selected window
; Syntax.........: _WinSelect([$bShowHelp = False[, $iBorderColor = 0xff0000[, $iTitleColor = 0xff0000[, $iTitleBackgoundColor = 0xABCDEF[, $iTitleFontSize = 12[, $iTitleFontWeight = 800[, $hWndFontName = "Tahoma"[,$sSelectKey1 = "11"[,$sSelectKey2 = "12"[,$sCancelKey = "1B"]]]]]]]]]])
; Parameters ....: $bShowHelp - displayes <<$sSelectKey1 + $sSelectKey2 to select or $sCancelKey to cancel>> next to window title if true
;                  $iBorderColor - Sets color of border aroud active window
;                  $iTitleColor - Color for window title inside rectangle (border)
;                  $iTitleBackgoundColor - Background color for title
;                  $iTitleFontSize - Title font size
;                  $iTitleFontWeight - Title Font weight
;                  $hWndFontName - Titlefont name
;                  $sSelectKey1 - Hotkey used to select window
;                  $sSelectKey2 - 2nd hotkey for selecting window
;                                 If this parameter is "" pressing only $sSelectKey1 is enough
;                                 If this parameter has other value both keys must be pushed at same time
;                  $sCancelKey - Specifies key to cancel
; Return values .: Success - Handle of selected window
;                  Failure - False
; Author ........: E1M1 (Rain Oksvort)
; Modified.......:
; Remarks .......: You can look up keys from _IsPressed's help topic
; Related .......:
; Link ..........;
; Example .......; Yes
;
; ;==========================================================================================

Func _WinSelect($bShowHelp = False, $iBorderColor = 0xff0000, $iTitleColor = 0xff0000, $iTitleBackgoundColor = 0xABCDEF, $iTitleFontSize = 12, $iTitleFontWeight = 800, $hWndFontName = "Tahoma", $sSelectKey1 = "11", $sSelectKey2 = "12", $sCancelKey = "1B")
	$KeyList = StringSplit("Left mouse button|Right mouse button|Middle mouse button (three-button mouse)|Windows 2000/XP: X1 mouse button|Windows 2000/XP: X2 mouse button|BACKSPACE |TAB |CLEAR |ENTER |SHIFT |CTRL |ALT |PAUSE |CAPS LOCK |ESC |SPACEBAR|PAGE UP |PAGE DOWN |END |HOME |LEFT ARROW |UP ARROW |RIGHT ARROW |DOWN ARROW |SELECT |PRINT |EXECUTE |PRINT SCREEN |INS |DEL |0 |1 |2 |3 |4 |5 |6 |7 |8 |9 |A |B |C |D |E |F |G |H |I |J |K |L |M |N |O |P |Q |R |S |T |U |V |W |X |Y |Z |Left Windows |Right Windows |Numeric pad 0 |Numeric pad 1 |Numeric pad 2 |Numeric pad 3 |Numeric pad 4 |Numeric pad 5 |Numeric pad 6 |Numeric pad 7 |Numeric pad 8 |Numeric pad 9 |Multiply |Add |Separator |Subtract |Decimal |Divide |F1 |F2 |F3 |F4 |F5 |F6 |F7 |F8 |F9 |F10 |F11 |F12 |F13 |F14|F15|F16|F17 |F18|F19|F20|F21|F22|F23|F24|NUM LOCK |SCROLL LOCK |Left SHIFT |Right SHIFT |Left CONTROL |Right CONTROL |Left MENU |Right MENU |;|=|,|-|.|/|`|[", "|")
	$KeyListMatchList = StringSplit("01|02|04|05|06|08|09|0C|0D|10|11|12|13|14|1B|20|21|22|23|24|25|26|27|28|29|2A|2B|2C|2D|2E|30|31|32|33|34|35|36|37|38|39|41|42|43|44|45|46|47|48|49|4A|4B|4C|4D|4E|4F|50|51|52|53|54|55|56|57|58|59|5A|5B|5C|60|61|62|63|64|65|66|67|68|69|6A|6B|6C|6D|6E|6F|70|71|72|73|74|75|76|77|78|79|7A|7B|7C|7D|7E|7F|80|81|82|83|84|85|86|87|90|91|A0|A1|A2|A3|A4|A5|BA|BB|BC|BD|BE|BF|C0|DB|DC|DD|", "|")

	$hDll = DllOpen("user32.dll")
	$Key1String = $KeyList[_ArrayFind($KeyListMatchList, $sSelectKey1)]
	If $sSelectKey2 <> "" Then $Key2String = $KeyList[_ArrayFind($KeyListMatchList, $sSelectKey2)]
	$CancelString = $KeyList[_ArrayFind($KeyListMatchList, $sCancelKey)]
	If $sSelectKey2 = "" Then
		$sHelpStr = " <<" & $Key1String & " to select or " & $CancelString & " to cancel>>"
	Else
		$sHelpStr = " <<" & $Key1String & " + " & $Key2String & " to select or " & $CancelString & " to cancel>>"
	EndIf
	$hWindowSelectorGUI = GUICreate("Window selector", @DesktopWidth, @DesktopHeight, 0, 0, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_LAYERED, $WS_EX_TOOLWINDOW))
	$title = GUICtrlCreateLabel("", 0, 0, 100, 16)
	GUICtrlSetFont(-1, $iTitleFontSize, $iTitleFontWeight)
	GUICtrlSetColor(-1, $iTitleColor)
	GUICtrlSetBkColor(-1, $iTitleBackgoundColor)

	GUISetBkColor(0xABCDEF) ; make gui bk color transparant
	_WinAPI_SetLayeredWindowAttributes($hWindowSelectorGUI, 0xABCDEF, 255) ; set transparancy
	_WinAPI_SetWindowLong($hWindowSelectorGUI, -20, BitOR(_WinAPI_GetWindowLong($hWindowSelectorGUI, -20), 0x00000020)) ; disable user intput
	$TopLabel = GUICtrlCreateLabel("", 0, 0, 0, 0)
	GUICtrlSetBkColor(-1, $iBorderColor)
	$BottomLabel = GUICtrlCreateLabel("", 0, 0, 0, 0)
	GUICtrlSetBkColor(-1, $iBorderColor)
	$LeftLabel = GUICtrlCreateLabel("", 0, 0, 0, 0)
	GUICtrlSetBkColor(-1, $iBorderColor)
	$RightLabel = GUICtrlCreateLabel("", 0, 0, 0, 0)
	GUICtrlSetBkColor(-1, $iBorderColor)
	GUISetState()
	WinSetOnTop($hWindowSelectorGUI, "", 1)

	Dim $aOldPos[4]
	$OldTitle = ""
	While 1
		$aPos = WinGetPos("[Active]")
		If $aPos[0] <> $aOldPos[0] Or $aPos[1] <> $aOldPos[1] Or $aPos[2] <> $aOldPos[2] Or $aPos[3] <> $aOldPos[3] Then
			$hWnd = WinGetHandle("[Active]")
			ControlMove($hWindowSelectorGUI, "", $TopLabel, $aPos[0], $aPos[1], $aPos[2], 3)
			ControlMove($hWindowSelectorGUI, "", $LeftLabel, $aPos[0], $aPos[1], 3, $aPos[3])
			ControlMove($hWindowSelectorGUI, "", $RightLabel, $aPos[0] + $aPos[2], $aPos[1], 3, $aPos[3])
			ControlMove($hWindowSelectorGUI, "", $BottomLabel, $aPos[0], $aPos[1] + $aPos[3], $aPos[2] + 3, 3)
			If $bShowHelp Then
				;$sTitleString = $hWnd & " - " & WinGetTitle($hWnd) & $sHelpStr
				;$sTitleString = WinGetTitle($hWnd) & $sHelpStr
				$sTitleString = $sHelpStr
			Else
				;$sTitleString = $hWnd & " - " & WinGetTitle($hWnd)
				;$sTitleString = WinGetTitle($hWnd)
				$sTitleString = ""
			EndIf
			ControlMove($hWindowSelectorGUI, "", $title, $aPos[0], $aPos[1], StringLen($sTitleString) * $iTitleFontSize)
			GUICtrlSetData($title, $sTitleString)
			$aOldPos = $aPos
		EndIf

		If _IsPressed($sSelectKey1, $hDll) Then
			If $sSelectKey2 = "" Then
				DllClose($hDll)
				GUIDelete()
				Return WinGetHandle("[Active]")
			EndIf
			If _IsPressed($sSelectKey2, $hDll) Then
				DllClose($hDll)
				GUIDelete()
				Return WinGetHandle("[Active]")
			EndIf
		EndIf

		If _IsPressed($sCancelKey, $hDll) Then
			GUIDelete($hWindowSelectorGUI)
			DllClose($hDll)
			Return False

		EndIf

	WEnd
EndFunc   ;==>_WinSelect

Func _ArrayFind($Array, $Val)
	For $i = 1 To $Array[0]
		If $Array[$i] = $Val Then Return $i
	Next
EndFunc   ;==>_ArrayFind
