#!/bin/sh -l

useradd -Ums /bin/bash arch
cat > /etc/sudoers.d/passwd <<__EOF__
ALL ALL = (ALL) NOPASSWD: ALL
__EOF__

pacman -Syu --noconfirm

chmod 777 -R .
for dir in $1; do
    pushd $dir
    sudo -u arch makepkg -rsif --noconfirm
    popd
done
