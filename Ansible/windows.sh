#!/bin/bash
#
# Windows shell provisioner for Ansible playbooks

ANSIBLE_PLAYBOOK=$1
ANSIBLE_VHOST=$2
ANSIBLE_IP=$3
ANSIBLE_MEMORY=$4

# Detect package management system.
YUM=$(which yum)
APT_GET=$(which apt-get)

# Make sure Ansible playbook exists.
if [ ! -f /vagrant/$ANSIBLE_PLAYBOOK ]; then
  echo "Cannot find Ansible playbook."
  exit 1
fi

# Remove old ansible
sudo yum erase ansible -y

# Install Ansible and its dependencies if it's not installed already.
if [ ! -f /usr/bin/ansible ]; then
  echo "Installing Ansible dependencies and Git."
  if [[ ! -z $YUM ]]; then
    yum install -y git gcc make python python-devel wget
  elif [[ ! -z $APT_GET ]]; then
    sudo apt-get update
    sudo apt-get install -y git gcc make python python-dev wget libssl-dev
  else
    echo "Neither yum nor apt-get are available."
    exit 1;
  fi

  echo "Installing pip via easy_install."
  sudo wget https://bootstrap.pypa.io/ez_setup.py -O - | python
  sudo easy_install pip
  # Make sure setuptools are installed crrectly.
  sudo pip install setuptools --no-use-wheel --upgrade

  echo "Installing required python modules."
  sudo pip install paramiko PyYAML Jinja2 markupsafe httplib2

  echo "Installing Ansible."
  sudo pip install ansible

  echo "UpgradingAnsible."
  sudo pip install ansible --upgrade
fi

# Install Ansible roles from requirements file, if available.
if [ -f /vagrant/requirements.txt ]; then
  sudo ansible-galaxy install -r /vagrant/requirements.txt
elif [ -f /vagrant/requirements.yml ]; then
  sudo ansible-galaxy install -r /vagrant/requirements.yml
fi

# Run the playbook.
echo "Running Ansible provisioner defined in Vagrantfile."
export PYTHONUNBUFFERED=1
export ANSIBLE_FORCE_COLOR=true
ansible-playbook -i 'localhost,' /vagrant/${ANSIBLE_PLAYBOOK} --extra-vars "{\"ansible\": {\"vmName\": \"$ANSIBLE_VHOST\", \"ip\": \"$ANSIBLE_IP\", \"memory\": \"$ANSIBLE_MEMORY\"}, \"isWindows\": true}" --connection=local
