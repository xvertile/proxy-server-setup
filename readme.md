# Proxy Server Setup Script

## Overview

This project provides a simple yet powerful script designed to prepare and patch an Ubuntu server for use as a proxy server. The script automates the configuration of system settings and network rules to optimize the server's performance and security for proxy server operations.

Key actions performed by the script include:
- Downloading and applying a custom sysctl configuration to optimize network performance.
- Setting the maximum number of open file descriptors to enhance the server's ability to handle a large number of concurrent connections.
- Blocking all mail ports to improve security and prevent misuse of the server for sending unsolicited emails.
- Installing `iptables-persistent` to ensure firewall rules persist across reboots.

### Installation

To apply the patch to your server, execute the following command in your terminal. This command downloads the script and executes it with root privileges. Ensure you have the necessary permissions to perform these actions on your server.

```bash
sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/xvertile/proxy-server-setup/main/patcher.sh)"
```

### Prerequisites

- An Ubuntu server (The script is designed with Ubuntu in mind, but it may work with slight modifications on other Linux distributions.)
- Root access to the server.
- `curl` installed on the server (for downloading the script).

