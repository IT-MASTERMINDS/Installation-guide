@echo off
setlocal enabledelayedexpansion

REM Check if Chocolatey is installed
choco -v >nul 2>&1
if %errorlevel% neq 0 (
  echo Chocolatey package manager is not installed.
  echo Do you want to install Chocolatey? Enter 'Y' to proceed or any other key to exit.
  set /p "install_choco="
  if /i "!install_choco!"=="Y" (
    REM Install Chocolatey
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    echo Chocolatey has been installed.
  ) else (
    echo Exiting script.
    echo.
    pause
    exit /b 1
  )
) else (
  echo Chocolatey is already installed.
)

:menu
cls
echo Choose an action:
echo 1. Install Java
echo 2. Delete Java
echo 3. Exit

set /p "choice="
if "%choice%"=="1" (
  REM Install Java

  REM Prompt user to enter Java version using set /p
  set /p "java_version=Enter the Java version you want to install (e.g., 17): "

  REM Check if the desired version is already installed
  set "java_version_installed="
  for /f "tokens=*" %%A in ('choco list --local-only openjdk') do (
    echo %%A | findstr /i "!java_version!" >nul
    if !errorlevel! equ 0 (
      set "java_version_installed=1"
    )
  )

  if defined java_version_installed (
    echo Java !java_version! is already installed.
    pause
    goto menu
  )

  REM Download and install Java Development Kit (JDK)
  choco install -y openjdk --version !java_version!

  REM Display the installation path
  for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\JavaSoft\Java Development Kit" /s /v "JavaHome" ^| findstr /i "JavaHome"') do (
    set "java_home_path=%%B"
  )
  echo Java !java_version! is installed at: !java_home_path!
  pause
  goto menu
) else if "%choice%"=="2" (
  REM Delete Java

  REM Prompt user to enter Java version using set /p
  set /p "java_version=Enter the Java version you want to delete (e.g., 17): "

  REM Check if the desired version is installed
  set "java_version_installed="
  for /f "tokens=*" %%A in ('reg query "HKLM\SOFTWARE\JavaSoft\Java Development Kit" /s /v "CurrentVersion" ^| findstr /i "!java_version!"') do (
    set "java_version_installed=1"
  )

  if not defined java_version_installed (
    echo Java !java_version! is not installed.
    pause
    goto menu
  )

  REM Uninstall Java Development Kit (JDK)
  choco uninstall -y openjdk --version !java_version!

  REM Display the removal message
  echo Java !java_version! has been uninstalled.
  pause
  goto menu
) else if "%choice%"=="3" (
  REM Exit
  echo Exiting script.
  pause
  exit /b 0
) else (
  echo Invalid choice. Please enter a valid option.
  pause
  goto menu
)

REM Rest of your script goes here...
