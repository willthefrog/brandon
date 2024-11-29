#!/bin/sh -l

set -e

pacman -Syu --noconfirm base-devel sudo

useradd -Ums /bin/bash arch
cat > /etc/sudoers.d/passwd <<__EOF__
ALL ALL = (ALL) NOPASSWD: ALL
__EOF__

chmod 777 -R .
for pkg in $1; do
    IFS=, read dir install <<< "${pkg}"
    pushd $dir
    sudo -u arch makepkg -rsf --noconfirm
    popd
done
