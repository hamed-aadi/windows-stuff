
;; functions =================================

los_firefox() {
	if !WinExist("ahk_class MozillaWindowClass") {
		Run "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
	}
	else {
		if WinActive("ahk_class MozillaWindowClass"){
		send ^{Tab}
		}
		else {
			WinActivate, ahk_class MozillaWindowClass
		}
	}
	Return
}

los_emacs() {
	if !WinExist("ahk_class Emacs") {
		Run C:\emacs\bin\runemacs.exe
	}
	else {
		if WinActive("ahk_class Emacs"){
			WinGetClass, ActiveClass, A
			WinActivateBottom, ahk_class %ActiveClass%
		}
		else {
			WinActivate, ahk_class Emacs
		}
	}
	Return
}

$RALT:: ; Move bottom window to top
#RALT:: ; Move top window to bottom
win := []
WinGet, wins, List
Loop, %wins% {
	WinGetTitle, ttitle, % winTitle := "ahk_id " wins%A_Index%
	WinGet, proc, ProcessName, %winTitle%
	SplitPath, proc,,,, proc
	WinGetClass, class, %winTitle%
	If (ttitle > "" && (ttitle != "Program Manager" || proc != "Explorer") && class != "#32770")
		If proc not in Firefox,Emacs.exe,emacs
				win.Push(wins%A_Index%)
}
If (A_ThisHotkey = "#RALT") {
	WinSet, Bottom,  , % "ahk_id " win.1
	WinActivate      , % "ahk_id " win.2
} Else WinActivate, % "ahk_id " win[win.Count()]
Return


marks(){
	SetWorkingDir, D:\Proj\bookmark-alpha\
	run, pythonw.exe -OO main.pyw
}
marks()

;;keys  ====================================
; $RAlt::
$XButton2::Send {MButton}

F1::los_firefox()
F2::los_emacs()
; $F12::marks()
F12::!F12
