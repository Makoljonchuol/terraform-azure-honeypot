#!/bin/bash
# Update and install dependencies
sudo apt update && sudo apt upgrade -y

# Download and run T-Pot installer
wget https://github.com/telekom-security/tpotce/raw/master/installer/install.sh
sudo bash install.sh
