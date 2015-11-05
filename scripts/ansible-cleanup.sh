#!/bin/bash -eux

date > /etc/vagrant_box_build_time

# Enable memory cgroup and swap accounting for Docker.
# http://docs.docker.io/en/latest/installation/kernel/#memory-and-swap-accounting-on-debian-ubuntu
set -ex
sed -i 's/^GRUB_CMDLINE_LINUX=""$/GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"/' /etc/default/grub
update-grub

# Remove uneeded packages (by regex).
apt-get -y remove '.*-dev$'
# Uninstall Ansible and remove PPA.
apt-get -y remove --purge ansible
apt-add-repository -y --remove ppa:ansible/ansible
apt-get -y autoremove
apt-get -y clean
apt-get update

# Delete unneeded files.
rm -f /home/vagrant/*.sh
rm -f /home/vagrant/*.gz
rm -f /home/vagrant/*.iso
rm -f /home/vagrant/_*

# Clean up tmp
rm -rf /tmp/*

# Removing leftover leases and persistent rules
echo "cleaning up dhcp leases"
rm -f /var/lib/dhcp/*

# Make sure Udev doesn't block our network
# http://6.ptmc.org/?p=164
echo "cleaning up udev rules"
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
rm -f /lib/udev/rules.d/75-persistent-net-generator.rules

echo "Adding a 2 sec delay to the interface up, to make the dhclient happy"
echo "pre-up sleep 2" >> /etc/network/interfaces

# Zero out the rest of the free space using dd, then delete the written file.
dd if=/dev/zero of=/EMPTY bs=1M || true
rm -f /EMPTY
#dd if=/dev/zero of=/boot/EMPTY bs=1M || true
#rm -f /boot/EMPTY

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync
