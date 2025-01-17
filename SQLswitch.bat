@echo off

 call :isAdmin

 if %errorlevel% == 0 (
    goto :run
 ) else (
    echo Requesting administrative privileges...
    goto :UACPrompt
 )

 exit /b

 :isAdmin
    fsutil dirty query %systemdrive% >nul
 exit /b

 :run
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Failure: This script must be run as an Administrator Please !
    pause >nul
    exit /b
)
sc query "MySQL80" | find "RUNNING"
if %errorlevel% == 0 (
    net stop "MySQL80"
    echo MySQL80 stopped.
) else (
    net start "MySQL80"
    echo MySQL80 started.
)
 exit /b

 :UACPrompt
   echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
   echo UAC.ShellExecute "cmd.exe", "/c %~s0 %~1", "", "runas", 1 >> "%temp%\getadmin.vbs"

   "%temp%\getadmin.vbs"
   del "%temp%\getadmin.vbs"
  exit /B`