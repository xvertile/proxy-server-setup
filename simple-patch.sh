#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Stop and disable systemd-resolved
systemctl stop systemd-resolved
systemctl disable systemd-resolved

# Remove the symlink to /run/systemd/resolve/stub-resolv.conf
rm -f /etc/resolv.conf

# Create new resolv.conf with Cloudflare DNS (IPv4 and IPv6)
cat > /etc/resolv.conf <<EOL
# Cloudflare DNS resolvers
nameserver 1.1.1.1
nameserver 1.0.0.1
nameserver 2606:4700:4700::1111
nameserver 2606:4700:4700::1001
options edns0
EOL

# Make resolv.conf immutable to prevent system from modifying it
chattr +i /etc/resolv.conf

# Download the configuration file and place it in /etc/sysctl.d/
wget -O /etc/sysctl.d/99-custom.conf https://raw.githubusercontent.com/xvertile/proxy-server-setup/main/99-custom.conf

# Reload system-wide sysctl settings
sysctl --system

# Set ulimit to the maximum possible value and make it persistent
# Get the maximum allowed number of open file descriptors
MAX_ULIMIT=$(ulimit -Hn)

# Make the ulimit setting persistent across reboots by adding it to /etc/security/limits.conf
echo "* soft nofile $MAX_ULIMIT" >> /etc/security/limits.conf
echo "* hard nofile $MAX_ULIMIT" >> /etc/security/limits.conf

echo "Configuration complete. System modifications applied."
