@echo off

REM Check if Chocolatey is installed
choco -v >nul 2>&1
if %errorlevel% neq 0 (
  echo Chocolatey package manager is not installed.
  set /p install_choco=Do you want to install Chocolatey? Enter 'Y' to proceed or any other key to exit: 
  if /i "%install_choco%"=="Y" (
    REM Install Chocolatey
    powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))"
    echo Chocolatey has been installed.
  ) else (
    echo Exiting script.
    exit /b 0
  )
)

REM Prompt user for action
set /p action=Do you want to (I)nstall or (D)elete a Java version? Enter 'I' or 'D': 

if /i "%action%"=="I" (
  REM Install Java

  REM Prompt user for Java version
  set /p java_version=Enter the Java version you want to install (e.g., 17): 

  REM Check if the desired version is already installed
  java -version 2>nul | findstr /i "%java_version%" >nul
  if %errorlevel% equ 0 (
    echo Java %java_version% is already installed.
    exit /b 0
  )

  REM Download and install Java Development Kit (JDK)
  choco install -y openjdk --version %java_version%

  REM Display the installation path
  for /f "tokens=2*" %%A in ('reg query "HKLM\SOFTWARE\JavaSoft\Java Development Kit" /s /v "JavaHome" ^| findstr /i "JavaHome"') do (
    set "java_home_path=%%B"
  )
  echo Java %java_version% is installed at: %java_home_path%

) else if /i "%action%"=="D" (
  REM Delete Java

  REM Prompt user for Java version
  set /p java_version=Enter the Java version you want to delete (e.g., 17): 

  REM Check if the desired version is installed
  java -version 2>nul | findstr /i "%java_version%" >nul
  if %errorlevel% neq 0 (
    echo Java %java_version% is not installed.
    exit /b 0
  )

  REM Uninstall Java Development Kit (JDK)
  choco uninstall -y openjdk --version %java_version%

  REM Display the removal message
  echo Java %java_version% has been uninstalled.

) else (
  REM Invalid action
  echo Invalid action. Please choose 'I' to install or 'D' to delete.
  exit /b 1
)

