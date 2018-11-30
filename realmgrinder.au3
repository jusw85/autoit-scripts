AutoItSetOption("MustDeclareVars", 1)
AutoItSetOption("SendKeyDelay", 100)
AutoItSetOption("SendKeyDownDelay", 100)
;~ AutoItSetOption("SendKeyDelay", 10)
;~ AutoItSetOption("SendKeyDownDelay", 10)

HotKeySet("+!c", "CastSpells")
HotKeySet("+!f", "Terminate")

Global Const $FairyCosts = [200, 400, 900, 1000, 1000]
Global Const $FairySpells = [5, 4, 3, 2, 1, 1]
;~ Global Const $FairySpells = [5]
Global Const $ElfCosts = [200, 400, 900, 700, 1000]
Global Const $ElfSpells = [4, 5]
Global Const $AngelCosts = [100, 300, 800, 800, 900]
Global Const $AngelSpells = [5, 4, 2,  1,1,1,1,1,  1,1,1,1,1,1,  1,1,1,1,1,  1,1]

Global Const $GoblinCosts = [200, 400, 600, 650, 800]
;~ Global Const $GoblinSpells = [4, 2, 1, 1]
Global Const $GoblinSpells = [5]

Global Const $TitanCosts = [200, 400, 1000, 900]
Global Const $TitanSpells = [4]
Global Const $DruidCosts = [200, 400, 1000, 800]
Global Const $DruidSpells = [4, 3, 2, 1, 1, 1, 1, 1, 1, 1]

Global Const $DefaultDelay = 50

Global Const $ManaRegen = 13.63
Global Const $MaxMana = 3665
Global Const $Costs = $FairyCosts
Global Const $Spells = $FairySpells
;~ Global Const $Costs = $ElfCosts
;~ Global Const $Spells = $ElfSpells
;~ Global Const $Costs = $AngelCosts
;~ Global Const $Spells = $AngelSpells

;~ Global Const $Costs = $GoblinCosts
;~ Global Const $Spells = $GoblinSpells

;~ Global Const $Costs = $TitanCosts
;~ Global Const $Spells = $TitanSpells
;~ Global Const $Costs = $DruidCosts
;~ Global Const $Spells = $DruidSpells

While (True)
	Sleep(3600000)
WEnd

Func CastSpells()
	Sleep(2000)
	Local $mana
	While (True)
		$mana = $MaxMana
		For $i = 0 To (UBound($Spells) - 1)
			Local $key = $Spells[$i]
			Local $cost = $Costs[$key - 1]
			If $cost > $mana Then
				RegenMana($cost, $mana)
				$mana = $cost
			EndIf
			Send($key)
;~ 			ConsoleWrite($key & @CRLF)
			$mana = $mana - $cost
;~ 			ConsoleWrite($mana & @CRLF)
		Next
		RegenMana($MaxMana, $mana)
		$mana = $MaxMana
	WEnd
EndFunc   ;==>CastSpells

Func RegenMana($to, $from, $delay = $DefaultDelay)
	Local $numSeconds = ($to - $from) / $ManaRegen
	Sleep(($numSeconds * 1000) + $delay)
EndFunc   ;==>RegenMana

Func Terminate()
	Exit
EndFunc   ;==>Terminate
