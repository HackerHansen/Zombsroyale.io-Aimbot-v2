#NoEnv    
SendMode Input  
SetWorkingDir %A_ScriptDir%  
#SingleInstance, Force 
FirX := (A_ScreenWidth - A_ScreenWidth + 200) 
FirY := (A_ScreenHeight - A_ScreenHeight + 200)

MidX := A_ScreenWidth / 2 
MidY := A_ScreenHeight / 2 

;OPTIMIZATIONS START
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off
Process, Priority, , A
SetBatchLines, -1
SetKeyDelay, -1, -1
SetMouseDelay, -1
SetDefaultMouseSpeed, 0
SetWinDelay, -1
SetControlDelay, -1
;OPTIMIZATIONS END

CoordMode, Mouse, Screen 
CoordMode, Pixel, Screen 
MidX := A_ScreenWidth / 2 
MidY := A_ScreenHeight / 2 
;Triggerbot = 0 
;Sense = 3

aim := 0x5064FB

;GUI===============================
Gui, Show, x%FirX% y%FirY% w100 h100, Runtime Broker
Gui, -Caption 
Gui, Add, Text, x2 y2 gLeDrag, LeKrunk
Gui, Add, Text, x-1 y10, ----------------------------------------------------------------------------
Gui, Add, Checkbox, x2 y20 vAimSet gAimbot, Aimbot 
Gui, Add, Checkbox, x2 y35 gFovBox vFov, Fov Box (1080p) 
Gui, Add, Checkbox, x2 y50 vTriggerbot, Triggerbot 
Gui, Add, Text, x2 y65, Aim Smooth:
Gui, Add, Text, x65 y65 vSen w100, 3
Gui, Add, Slider, x-3 y80 w105 vSense gOui ToolTip Thick8 Range1-10 NoTicks, 3
Gui, Add, Button, x2 y100 w100 gCreds, CREDITS
return 

Aimbot: 
Gui, Submit, NoHide 
~RButton::
{
	While GetKeyState("RButton"){
PixelSearch, TargetX, TargetY, 840, 420, 1080, 660, aim, 20, Fast
If ErrorLevel = 0 
	Gui, Submit, NoHide 
	if (AimSet == 1) 
{ 
TargetX := TargetX + 42
TargetY := TargetY + 30
MoveX := ((TargetX - MidX) / Sense) 
MoveY := ((TargetY - MidY) / Sense) 
MouseMove, MoveX, %MoveY%,, R
if (TriggerBot = 1) 
{
Click, down 
}
}
else
Gui, Submit, NoHide 
if (Triggerbot = 1)
Click, up
}
}
return

~RButton up::
{
Gui, Submit, NoHide
if (Triggerbot = 1) 
Click, up
}
return 

Creds:
Msgbox, 0, LeKrunk, Made By: HackerHansen And Leplix! `nThis Is Our Free Version `nMake Sure To Check Out Paid! `nMore Features + Better


Oui:
Gui, Submit, NoHide 
GuiControl,,Sen, %Sense% 
return 


LeDrag:
PostMessage, 0xA1, 2,,, A
return 

FovBox:
Gui, Submit, NoHide 
if (Fov == 1) {
CreateBox("01FF01")
Box(840, 420, 240, 240, 1, 0)
}
else if (Fov == 0) {
	RemoveBox()
}
return 






return 

`::exitapp

; BOX FUNCTIONS, NOT WRITTEN BY ME. https://autohotkey.com/board/topic/54443-box-ie-draw-simple-gui-based-boxes-on-screen/

CreateBox(Color)
{
	Gui 81:color, %Color%
	Gui 81:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 82:color, %Color%
	Gui 82:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 83:color, %Color%
	Gui 83:+ToolWindow -SysMenu -Caption +AlwaysOnTop
	Gui 84:color, %Color%
	Gui 84:+ToolWindow -SysMenu -Caption +AlwaysOnTop
}

Box(XCor, YCor, Width, Height, Thickness, Offset)
{
	If InStr(Offset, "In")
	{
		StringTrimLeft, offset, offset, 2
		If not Offset
			Offset = 0
		Side = -1
	} Else {
		StringTrimLeft, offset, offset, 3
		If not Offset
			Offset = 0
		Side = 1
	}
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y := YCor - (Side + 1) / 2 * Thickness - Side * Offset
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 81:Show, x%x% y%y% w%w% h%h% NA
	x += Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 82:Show, x%x% y%y% w%w% h%h% NA
	x := x + w - Thickness
	y += Thickness
	h := Height + Side * Thickness + Side * Offset * 2
	w := Thickness
	Gui 83:Show, x%x% y%y% w%w% h%h% NA
	x := XCor - (Side + 1) / 2 * Thickness - Side * Offset
	y += h - Thickness
	w := Width + Side * Thickness + Side * Offset * 2
	h := Thickness
	Gui 84:Show, x%x% y%y% w%w% h%h% NA
}

RemoveBox()
{
	Gui 81:destroy
	Gui 82:destroy
	Gui 83:destroy
	Gui 84:destroy
}