#include <Misc.au3>
#include <GUIConstantsEx.au3>
#include <WinSelect.au3>

; Scripted window interactions for testing

Opt("GUIOnEventMode", 1)

;HotKeySet("#j", "_Func")
HotKeySet("#g", "Quit")

Global $hWnd = 0
Global $tag = "date"
Global $label_tag

Global $gHnd = GUICreate("Tagger", 400, 200, -1, -1, $WS_EX_TOPMOST)
WinSetOnTop($gHnd, "", 1)

GUISetOnEvent($GUI_EVENT_CLOSE, "Quit")
$button_exit = GUICtrlCreateButton("exit", 300, 150)
GUICtrlSetOnEvent($button_exit, "Quit")

$button_window_select = GUICtrlCreateButton("Select Window", 10, 10)
GUICtrlSetOnEvent($button_window_select, "WindowSelect")

$button_tag_text = GUICtrlCreateButton("Tag", 10, 40)
GUICtrlSetOnEvent($button_tag_text, "Tag")

$button_change_label = GUICtrlCreateButton("Change label", 10, 70)
GUICtrlSetOnEvent($button_change_label, "ChangeLabel")

$label_tag = GUICtrlCreateLabel($tag, 10, 100)

GUISetState(@SW_SHOW)
While (1)
	Sleep(100000)
WEnd

Func ChangeLabel()
	$tag = InputBox("Change Label", "Change label", $tag, "", 200, 100, Default, Default, -1, $gHnd)
	GUICtrlSetData($label_tag, $tag)
EndFunc   ;==>ChangeLabel

Func WindowSelect()
	$hWnd = _WinSelect(True, 0xff0000, 0xff0000, 0xffffff, 12, 800, "Tahoma", "11", "12", "1B")
EndFunc   ;==>WindowSelect

Func Tag()
	If ($hWnd == 0) Then
		Return
	EndIf
	WinActivate($hWnd)

	$clipboard = ClipGet()
	ClipPut("")
	Send("^{Insert}")
	$text = ClipGet()

	If Not ($text == "") Then
		$tagged_text = "<" & $tag & ">" & $text & "</" & $tag & ">"
		ClipPut($tagged_text)
		Send("+{Insert}")
	EndIf

	ClipPut($clipboard)
EndFunc   ;==>Tag

Func Quit()
	Exit (0)
EndFunc   ;==>Quit

Func _Func()
	While _IsPressed("10") _; Shift
			Or _IsPressed("11") _; Ctrl
			Or _IsPressed("12") _; Alt
			Or _IsPressed("5B") ; LWindow
		Sleep(10)
	WEnd
	Select
		Case @HotKeyPressed = "#j"
			Tag()
	EndSelect
EndFunc   ;==>_Func

