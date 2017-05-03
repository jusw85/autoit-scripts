#include <GUIConstants.au3>
#include <NomadMemory.au3> ;because you need this for _memread functions
GUICreate("My GUI Button")
$Button_1 = GUICtrlCreateButton ("Check Memory Address",  10, 30, 150)
$Label_1 = GUICtrlCreateLabel("(lvl)",20, 60)
GUISetState ()

$Mem_Address = 0x004EC1E8 ;the conquer memory address for current level
$Process1 = WinGetProcess("[Conquer2.0]") ;the window to get PID

While 1
    $msg = GUIGetMsg()
    Select
        Case $msg = $GUI_EVENT_CLOSE
            ExitLoop
        Case $msg = $Button_1
			$Mem_Open = _MemoryOpen($Process1) ;must open before you can read address
			$Mem_Read = _MemoryRead($Mem_Address, $Mem_Open) ;reads value at memory address
			_MemoryClose($Mem_Open) ;close it afterwards
			
			GUICtrlSetData($Label_1,$Mem_Read) ; sets label to value of read memory
    EndSelect
Wend

