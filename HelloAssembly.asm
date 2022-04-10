;-----------------------------
; Hello, Windows! in x86 ASM
;-----------------------------

.386                                     ; Full 80386 instruction set and mode
.model flat, stdcall                     ; All 32-bit and later apps are flat. Used to include "tiny, etc"
option casemap:none

; Include files - headers and libs that we need for calling the system dlls like user32, gdi32, kernel32, etc

include \masm32\include\windows.inc      ; Main windows header file
include \masm32\include\user32.inc       ; Windows, controls, etc
include \masm32\include\kernel32.inc     ; Handles, modules, paths, 
include \masm32\include\gdi32.inc        ; Drawing into a device controls

; Libs - information needed to link binary to the system DLL calls

includelib \masm32\lib\kernel32.lib      ; Kernel32.dll
includelib \masm32\lib\user32.lib        ; User32.dll
includelib \masm32\lib\gdi32.lib         ; GDI32.dll

; Forward declarations - Our main entry point will call forward to WinMain, so we need to define it here, etc
WinMain proto :DWORD, :DWORD, :DWORD, :DWORD

; Constants and Datra



