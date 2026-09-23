@echo off

rem Start of Script
:BEGIN
CLS

rem Choices
ECHO 1. Windows XP-based Operating System
ECHO 2. Windows 7/Windows 10 and newer-based Operating Systems
ECHO.

CHOICE /N /C:12 /M "Choose your Operating System (1 or 2)"%1

IF ERRORLEVEL ==2 GOTO Win7-10
IF ERRORLEVEL ==1 GOTO WinXP
GOTO END
:Win7-10
ECHO YOU HAVE PRESSED Windows 7/10
GOTO END
:WinXP
ECHO YOU HAVE PRESSED Windows XP
:END
pause