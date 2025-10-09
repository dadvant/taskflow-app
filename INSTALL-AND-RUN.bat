@echo off
echo ========================================
echo   TaskFlow Enhanced - Windows Setup
echo ========================================
echo.
echo This will install TaskFlow on your Windows computer.
echo Please wait while we download and install everything...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js is not installed!
    echo Please install Node.js from https://nodejs.org first
    echo Then run this installer again.
    pause
    exit /b 1
)

echo ✓ Node.js is installed
echo.

REM Install dependencies
echo Installing TaskFlow dependencies...
npm install
if errorlevel 1 (
    echo ERROR: Failed to install dependencies
    pause
    exit /b 1
)

echo ✓ Dependencies installed
echo.

REM Create desktop shortcut
echo Creating desktop shortcut...
powershell -Command "& {$WshShell = New-Object -comObject WScript.Shell; $Shortcut = $WshShell.CreateShortcut('%USERPROFILE%\Desktop\TaskFlow Enhanced.lnk'); $Shortcut.TargetPath = '%CD%\node_modules\.bin\electron.cmd'; $Shortcut.Arguments = '.'; $Shortcut.WorkingDirectory = '%CD%'; $Shortcut.IconLocation = '%CD%\assets\icon.ico'; $Shortcut.Save()}"

echo ✓ Desktop shortcut created
echo.

echo ========================================
echo   Installation Complete!
echo ========================================
echo.
echo TaskFlow Enhanced is now installed.
echo Starting the application...
echo.

REM Start TaskFlow
npm start

pause
