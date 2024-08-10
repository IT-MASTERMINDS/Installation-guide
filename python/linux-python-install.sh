#!/bin/bash

# Function to display available Python versions
list_available_versions() {
  echo "Available Python versions:"
  echo "1. 3.9.0"
  echo "2. 3.9.13"
  echo "3. 3.9.16" 
  echo "if you now valid version pass that too"# Add other versions as needed
}

# Prompt user for desired Python version
echo "Select the Python version you want to install:"
list_available_versions
read -p "Enter the version number (e.g., 3.9.0): " version


# Set download URL and file names
base_url="https://www.python.org/ftp/python"
file_name="Python-${version}.tgz"
download_url="${base_url}/${version}/${file_name}"

# Download Python source
echo "Downloading Python ${version} from ${download_url}..."
wget $download_url -O $file_name

# Extract the downloaded file
echo "Extracting ${file_name}..."
tar -xzf $file_name

# Change to the Python source directory
cd "Python-${version}"

# Configure, build, and install Python
echo "Configuring Python ${version}..."
./configure --enable-optimizations

echo "Building Python ${version}..."
make -j $(nproc)

echo "Installing Python ${version}..."
sudo make altinstall

# Verify installation
echo "Python ${version} installation complete."
python3.9 --version

# Cleanup
echo "Cleaning up..."
cd ..
rm -rf "Python-${version}" $file_name

echo "Done."
