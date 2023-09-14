#!/bin/bash

# Prompt user for action
read -p "Do you want to (I)nstall or (D)elete a Java version? Enter 'I' or 'D': " action

if [[ "$action" == "I" || "$action" == "i" ]]; then
  # Install Java

  # Detect the user's shell
  shell=$(basename "$SHELL")

  # Prompt user for Java version
  read -p "Enter the Java version you want to install (e.g., 17): " java_version

  # Check if the desired version is already installed
  if brew list --versions openjdk@$java_version >/dev/null; then
    echo "Java $java_version is already installed."
    exit 0
  fi

  # Install Java using Homebrew
  brew install openjdk@$java_version

  # Set JAVA_HOME environment variable
  java_home_path=$(brew --prefix openjdk@$java_version)

  if [[ "$shell" == "bash" ]]; then
    # Update ~/.bash_profile for Bash
    echo "export JAVA_HOME=$java_home_path" >> ~/.bash_profile
    source ~/.bash_profile
  elif [[ "$shell" == "zsh" ]]; then
    # Update ~/.zshrc for Zsh
    echo "export JAVA_HOME=$java_home_path" >> ~/.zshrc
    source ~/.zshrc
  else
    echo "Unsupported shell: $shell"
    exit 1
  fi

  # Display the installation path
  echo "Java $java_version is installed at: $java_home_path"

elif [[ "$action" == "D" || "$action" == "d" ]]; then
  # Delete Java

  # Prompt user for Java version
  read -p "Enter the Java version you want to delete (e.g., 17): " java_version

  # Check if the desired version is installed
  if brew list --versions openjdk@$java_version >/dev/null; then
    # Uninstall Java using Homebrew
    brew uninstall openjdk@$java_version

    # Display the removal message
    echo "Java $java_version has been uninstalled."
  else
    echo "Java $java_version is not installed."
    exit 0
  fi

else
  # Invalid action
  echo "Invalid action. Please choose 'I' to install or 'D' to delete."
  exit 1
fi
