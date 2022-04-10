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

WindowsWidth   equ   640                 ; How big we'd like our main window
WindowsHeight  equ   480

.DATA

ClassName      db   "MyWinClass", 0      ; The name of our Window class
AppName        db   "Tiny App", 0        ; The name of our main window

.DATA?

hInstance     HINSTANCE ?                ; Instance handle (like the process id) of our application
CommandLine   LPSTR     ?                ; Pointer to the command line text we were lanuched WindowsWidth

;-------------------------------------
.CODE
;-------------------------------------

MainEntry:
    push NULL
    call GetModuleHandle
    mov hInstance, eax

    call GetCommandLine
    move CommandLine, eax

    ; Call our WinMain and then wxit the process with whatever comes back from it

    push SW_SHOWDEFAULT
    lea   eax, CommandLine
    push eax
    push NULL
    push hInstance
    call WinMain

    push eax
    call ExitProcess


;
; WinMain - The traditional signature for the main entry point of a Windows programa

WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
    LOCAL   wc:WNDCLASSEX            ; Create these vars on the stack, hence LOCAL
    LOCAL   msg:MSG
    LOCAL   hwnd:HWND


    mov wc.cvSize, SIZEOF WNDCLASSEX           ; Fill in the values in the members of our windowclass
    mov wc.style, CS_HREDRAW or CS_VREDRAW     ; Redraw if resized in either dimension
    mov wc.lpfnWndProc, OFFSET WndProc         ; Our callback function to handle window messages tc
    mov wc.cbClsExtra, 0                       ; No extra class data
    mov wc.cbWndExtra, 0                       ; No extra window data

    mov eax, hInstance
    mov wc.hInstance, eax
    mov wc.hbrBackground, COLOR_3DSHADOW+1
    mov wc.lpszMenuName, NULL                  ; No app menu
    mov wc.lpszClassName, OFFSET ClassName     ; The window's class name

    push IDI_APPLICATION                       ; Use the default application icon
    push NULL
    call LoadIcon
    mov wc.hIcon, eax
    mov wc.hIconSm, eax

    

