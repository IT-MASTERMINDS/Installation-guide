#!/bin/bash

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    echo "Homebrew not found. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install tools using Homebrew
brew install aircrack-ng
brew install amap
brew install apktool
brew install arp-scan
brew install binwalk
brew install capstone
brew install cmu-sphinxbase
brew install cowpatty
brew install crunch
brew install dc3dd
brew install ddrescue
brew install dex2jar
brew install dns2tcp
brew install dnsmap
brew install dnstracer
brew install dos2unix
brew install ettercap
brew install fcrackzip
brew install foremost
brew install fragroute
brew install hping
brew install httptunnel
brew install hydra
brew install john-jumbo
brew install libbtbb
brew install libewf
brew install libfreefare
brew install libmicrohttpd
brew install libnfc
brew install lynis
brew install masscan
brew install mfcuk
brew install mitmproxy
brew install msgpack
brew install ncrack
brew install nikto
brew install nmap
brew install p0f
brew install pixz
brew install proxychains-ng
brew install pwnat
brew install qemu
brew install reaver
brew install rtl-sdr
brew install rtpbreak
brew install sipp
brew install skipfish
brew install sleuthkit
brew install slowhttptest
brew install smali
brew install sqlmap
brew install ssdeep
brew install sslscan
brew install thc-pptp-bruter
brew install theharvester
brew install truecrack
brew install valgrind
brew install volatility
brew install wine
brew install winexe
brew install wireshark
brew install yara

echo "All tools installed successfully!"
