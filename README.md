# Packer Example - Ubuntu 14.04 minimal Vagrant Box

**Current Ubuntu Version Used**: 14.04.3

This example build configuration installs and configures Ubuntu 14.04 x86_64 minimal using Ansible, and then generates two Vagrant box files, for:

  - VirtualBox

The example can be modified to use more Ansible roles, plays, and included playbooks to fully configure (or partially) configure a box file suitable for deployment for development environments.

## Requirements

The following software must be installed/present on your local machine before you can use Packer to build the Vagrant box file:

  - [Packer](http://www.packer.io/)
  - [Vagrant](http://vagrantup.com/)
  - [VirtualBox](https://www.virtualbox.org/) (if you want to build the VirtualBox box)
  - [Ansible](http://docs.ansible.com/intro_installation.html)

You will also need some Ansible roles installed so they can be used in the building of the VM. To install the roles:

  1. Run `$ ansible-galaxy install -r requirements.txt` in this directory.
  2. If your local Ansible roles path is not the default (`/etc/ansible/roles`), update the `role_paths` inside `ubuntu1404.json` to match your custom location.

## Usage

Make sure all the required software (listed above) is installed, then cd to the directory containing this README.md file, and run:

    $ packer build ubuntu1404.json

After a few minutes, Packer should tell you the box was generated successfully.
