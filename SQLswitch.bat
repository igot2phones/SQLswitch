@echo off
net session >nul 2>&1
if %errorlevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Failure: This script must be run as an Administrator!
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