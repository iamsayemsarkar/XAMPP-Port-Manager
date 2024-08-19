# XAMPP Port Manager

## Overview

**XAMPP Port Manager** is a powerful and easy-to-use batch script designed to help you manage Apache's HTTP and HTTPS ports within the XAMPP environment. Whether you need to change the default ports to avoid conflicts or revert to previous settings, this tool provides a seamless experience, ensuring your local development environment runs smoothly.

## Features

- **Dynamic Port Configuration**: Easily change Apache's default HTTP (80) and HTTPS (443) ports to custom values.
- **Revert to Default Ports**: Revert to the default or previously used ports when needed.
- **User-Friendly Interface**: Simple and intuitive prompts guide you through the process.
- **Error Handling**: Ensures only valid inputs are accepted, preventing misconfigurations.
- **PowerShell Integration**: Uses PowerShell for reliable and precise configuration file updates.
- **Administrator Privileges Check**: Verifies the script is executed with the necessary permissions.

## Prerequisites

- **Administrator Privileges**: The script requires admin rights to modify system files.
- **XAMPP Installation**: XAMPP should be installed in the default directory (`C:\xampp`).
- **Windows Operating System**: This script is designed for Windows environments.

## Installation

1. **Download the Script**: Download the `XAMPP_Port_Manager.bat` file from this repository.
2. **Place in XAMPP Directory**: Move the script to the root of your XAMPP directory (`C:\xampp`).
3. **Run as Administrator**: Right-click the `XAMPP_Port_Manager.bat` file and select "Run as administrator" to ensure it has the necessary permissions.

## Usage

### 1. Changing Apache Ports

1. Run the script by double-clicking it or executing it from the command line.
2. Choose the option to change Apache ports.
3. Enter the current HTTP port (default is 80) and the new HTTP port you want to use.
4. Enter the current HTTPS port (default is 443) and the new HTTPS port you want to use.
5. The script will update the configuration files and restart Apache with the new settings.

### 2. Reverting to Default Ports

1. Run the script as described above.
2. Choose the option to revert to default or previous ports.
3. Enter the current custom ports you are using.
4. The script will revert to the default ports (80 for HTTP and 443 for HTTPS) and restart Apache with the reverted settings.

## Example

To change the HTTP port from 80 to 8080 and the HTTPS port from 443 to 8443:

```bash
Enter the current HTTP port (default: 80): 80
Enter the new HTTP port (e.g., 8080): 8080
Enter the current HTTPS port (default: 443): 443
Enter the new HTTPS port (e.g., 8443): 8443
