#!/bin/bash

# Determine the Linux distribution
if [ -f /etc/os-release ]; then
  source /etc/os-release
  os=$ID
elif [ -f /etc/redhat-release ]; then
  os="rhel"  # Red Hat-based
elif [ -f /etc/SuSE-release ]; then
  os="suse"  # openSUSE-based
else
  echo "Unsupported operating system"
  exit 1
fi

# Prompt user for action
read -p "Do you want to (I)nstall or (D)elete a Java version? Enter 'I' or 'D': " action

if [[ "$action" == "I" || "$action" == "i" ]]; then
  # Install Java

  # Prompt user for Java version
  read -p "Enter the Java version you want to install (e.g., 17): " java_version

  # Check if the desired version is already installed
  if type -p java | grep -q "java-$java_version"; then
    echo "Java $java_version is already installed."
    exit 0
  fi

  # Check if we are in a container environment
  if [ -f /.dockerenv ]; then
    # Install Java without sudo inside a container
    echo "Installing Java inside a container (no sudo required)."

    if [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
      apt-get update
      apt-get install -y openjdk-$java_version-jdk
    elif [[ "$os" == "rhel" || "$os" == "centos" || "$os" == "fedora" ]]; then
      yum install -y java-$java_version-openjdk-devel
    elif [[ "$os" == "suse" || "$os" == "opensuse" || "$os" == "sles" ]]; then
      zypper install -y java-$java_version-openjdk-devel
    else
      echo "Unsupported operating system: $os"
      exit 1
    fi
  else
    # Install Java with sudo on a regular system
    sudo apt-get update
    sudo apt-get install -y openjdk-$java_version-jdk
  fi

  # Display the installation path
  java_home_path=$(which java)
  echo "Java $java_version is installed at: $java_home_path"

elif [[ "$action" == "D" || "$action" == "d" ]]; then
  # Delete Java

  # Prompt user for Java version
  read -p "Enter the Java version you want to delete (e.g., 17): " java_version

  # Check if the desired version is installed
  if ! type -p java | grep -q "java-$java_version"; then
    echo "Java $java_version is not installed."
    exit 0
  fi

  # Check if we are in a container environment
  if [ -f /.dockerenv ]; then
    # Uninstall Java without sudo inside a container
    echo "Uninstalling Java inside a container (no sudo required)."

    if [[ "$os" == "debian" || "$os" == "ubuntu" ]]; then
      apt-get remove -y openjdk-$java_version-jdk
    elif [[ "$os" == "rhel" || "$os" == "centos" || "$os" == "fedora" ]]; then
      yum remove -y java-$java_version-openjdk-devel
    elif [[ "$os" == "suse" || "$os" == "opensuse" || "$os" == "sles" ]]; then
      zypper remove -y java-$java_version-openjdk-devel
    else
      echo "Unsupported operating system: $os"
      exit 1
    fi
  else
    # Uninstall Java with sudo on a regular system
    sudo apt-get remove -y openjdk-$java_version-jdk
  fi

  # Display the removal message
  echo "Java $java_version has been uninstalled."

else
  # Invalid action
  echo "Invalid action. Please choose 'I' to install or 'D' to delete."
  exit 1
fi

