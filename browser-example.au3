#Region
#AutoIt3Wrapper_Outfile=script.run
#EndRegion

;~ ConsoleWrite("[+] Press any key to exit..." & @LF) ;Echo first line.

#include <IE.au3>
$oIE = _IE_Example ("basic")
$oDiv = _IEGetObjById ($oIE, "line1")
ConsoleWrite(_IEPropertyGet($oDiv, "innertext") & @CRLF)

