#!/bin/bash

# Check if the script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Install necessary packages for package management
apt-get update
apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common

# Install Docker if not already installed
if ! [ -x "$(command -v docker)" ]; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    apt-get update
    apt-get install -y docker-ce docker-ce-cli containerd.io
    systemctl enable docker
    systemctl start docker
fi

# Install Git if not already installed
if ! [ -x "$(command -v git)" ]; then
    apt-get install -y git
fi

# Install Terraform if not already installed
if ! [ -x "$(command -v terraform)" ]; then
    wget https://releases.hashicorp.com/terraform/1.0.8/terraform_1.0.8_linux_amd64.zip
    unzip terraform_1.0.8_linux_amd64.zip
    mv terraform /usr/local/bin/
fi

# Install Ansible if not already installed
if ! [ -x "$(command -v ansible)" ]; then
    apt-get install -y ansible
fi

# Install wget if not already installed
if ! [ -x "$(command -v wget)" ]; then
    apt-get install -y wget
fi

# Install curl if not already installed
if ! [ -x "$(command -v curl)" ]; then
    apt-get install -y curl
fi

# Install Maven if not already installed
if ! [ -x "$(command -v mvn)" ]; then
    apt-get install -y maven
fi

# Install Docker Compose if not already installed
if ! [ -x "$(command -v docker-compose)" ]; then
    curl -sSL https://github.com/docker/compose/releases/download/1.29.2/docker-compose-Linux-x86_64 -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi

# Install OpenJDK 11 for Java if not already installed
if ! [ -x "$(command -v java)" ]; then
    apt-get install -y openjdk-11-jdk
fi

# Install Node.js for JavaScripting if not already installed
if ! [ -x "$(command -v node)" ]; then
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    apt-get install -y nodejs
fi

# Upgrade all installed packages and remove outdated packages
apt-get update
apt-get upgrade -y
apt-get autoremove -y

# Clear the package cache
apt-get clean

