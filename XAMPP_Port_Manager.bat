@echo off
REM ===================================================================
REM Dynamic XAMPP Apache Port Configuration Script
REM
REM This script allows the user to:
REM 1. Change the current Apache HTTP (default: 80) and HTTPS (default: 443) ports
REM 2. Revert these ports back to their default values or previously used values
REM
REM Prerequisites:
REM 1. The script must be run with administrator privileges.
REM 2. XAMPP should be installed in the default location (C:\xampp).
REM
REM Created by: Sayem Muhammad Nasratullah Sarkar
REM Date: 20 August 2024
REM ===================================================================

REM Ensure the script is executed with administrator privileges
NET SESSION >nul 2>&1
if %errorLevel% NEQ 0 (
    echo "This script requires administrator privileges to run."
    pause
    exit /b
)

REM Prompt user to choose between changing ports or reverting to defaults
echo Please select an option:
echo [1] Change Apache ports
echo [2] Revert to default or previous ports
set /p choice="Enter your choice (1 or 2): "

if "%choice%"=="1" goto change_ports
if "%choice%"=="2" goto revert_defaults
echo Invalid choice. Exiting...
pause
exit /b

:change_ports
REM Prompt for the current HTTP port (default: 80) and provide a fallback
set /p currentPort80="Enter the current HTTP port (default: 80): "
if "%currentPort80%"=="" set currentPort80=80

REM Prompt for the new HTTP port to replace the current one
set /p newPort80="Enter the new HTTP port (e.g., 8888): "
if "%newPort80%"=="" (
    echo "Error: You must specify a new HTTP port."
    pause
    exit /b
)

REM Prompt for the current HTTPS port (default: 443) and provide a fallback
set /p currentPort443="Enter the current HTTPS port (default: 443): "
if "%currentPort443%"=="" set currentPort443=443

REM Prompt for the new HTTPS port to replace the current one
set /p newPort443="Enter the new HTTPS port (e.g., 4444): "
if "%newPort443%"=="" (
    echo "Error: You must specify a new HTTPS port."
    pause
    exit /b
)

REM Proceed to update the configuration files with the provided ports
goto update_files

:revert_defaults
REM Prompt for the current HTTP port to revert
set /p currentPort80="Enter the current HTTP port to revert (e.g., 8888): "
if "%currentPort80%"=="" (
    echo "Error: You must specify the current HTTP port to revert."
    pause
    exit /b
)

REM Prompt for the current HTTPS port to revert
set /p currentPort443="Enter the current HTTPS port to revert (e.g., 4444): "
if "%currentPort443%"=="" (
    echo "Error: You must specify the current HTTPS port to revert."
    pause
    exit /b
)

REM Set default ports to revert back to
set newPort80=80
set newPort443=443

echo Reverting HTTP port %currentPort80% to the default port %newPort80%...
echo Reverting HTTPS port %currentPort443% to the default port %newPort443%...
goto update_files

:update_files
REM Navigate to the Apache configuration directory within XAMPP
cd /d C:\xampp\apache\conf

REM Verify the existence of httpd.conf before making changes
if not exist httpd.conf (
    echo "Error: httpd.conf not found in C:\xampp\apache\conf. Ensure XAMPP is installed correctly."
    pause
    exit /b
)

REM Modify the httpd.conf file to change the HTTP port
echo Updating httpd.conf to replace HTTP port %currentPort80% with %newPort80%...
powershell -Command "(Get-Content httpd.conf) -replace 'Listen %currentPort80%', 'Listen %newPort80%' | Set-Content httpd.conf"
powershell -Command "(Get-Content httpd.conf) -replace 'ServerName localhost:%currentPort80%', 'ServerName localhost:%newPort80%' | Set-Content httpd.conf"

REM Navigate to the extra configuration directory for SSL settings
cd extra

REM Verify the existence of httpd-ssl.conf before making changes
if not exist httpd-ssl.conf (
    echo "Error: httpd-ssl.conf not found in C:\xampp\apache\conf\extra. Ensure XAMPP is installed correctly."
    pause
    exit /b
)

REM Modify the httpd-ssl.conf file to change the HTTPS port
echo Updating httpd-ssl.conf to replace HTTPS port %currentPort443% with %newPort443%...
powershell -Command "(Get-Content httpd-ssl.conf) -replace 'Listen %currentPort443%', 'Listen %newPort443%' | Set-Content httpd-ssl.conf"
powershell -Command "(Get-Content httpd-ssl.conf) -replace '<VirtualHost _default_:%currentPort443%>', '<VirtualHost _default_:%newPort443%>' | Set-Content httpd-ssl.conf"
powershell -Command "(Get-Content httpd-ssl.conf) -replace 'ServerName www.example.com:%currentPort443%', 'ServerName www.example.com:%newPort443%' | Set-Content httpd-ssl.conf"

REM Return to the main XAMPP directory
cd /d C:\xampp

REM Attempt to start Apache with the new configuration
echo Starting Apache with the new configuration...
call xampp_start.exe

REM Pause to allow the user to see if Apache started successfully
pause
exit /b
