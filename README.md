# DockerVM

[![Build Status](https://travis-ci.org/egobude/DockerVM.svg?branch=master)](https://travis-ci.org/egobude/DockerVM)

> **Notice:** This setup is currently only for mac users!

## Requirements

* Homebrew - [https://brew.sh/index_de.html](https://brew.sh/index_de.html)
* Vagrant - [https://www.vagrantup.com](https://www.vagrantup.com/)
* Virtualbox - [https://www.virtualbox.org](https://www.virtualbox.org/)
* Ansible - [https://www.ansible.com](https://www.ansible.com/)

## Install dependencies

    $ brew install ansible
    $ brew cask install virtualbox
    $ brew cask install vagrant

## Usage

### Clone the repository

    $ git clone https://github.com/egobude/DockerVM.git
    $ cd DockerVM

### Adjust VM settings in vagrant.rb

```ruby
module ProjectVars
  # vhost
  VHOST = "docker.vm"

  # IP Address
  IP = "10.0.1.10"

  # VM Settings
  CPUS = "2"
  MEMORY = "2048"
  VM_NAME = "DockerVM"
end
```

### Start the machine

    $ vagrant up

### Edit your local /etc/hosts

    $ 10.0.1.10 docker.vm

### Create Mountpoint on your machine

    $ mkdir data
    $ mount_smbfs -N //guest@10.0.1.10/docker ./data

### To unmount, using the following command

    $ umount ./data

### Login into the docker vm

    $ vagrant ssh
