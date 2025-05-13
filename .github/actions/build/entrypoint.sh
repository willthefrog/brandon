#!/bin/sh -l

set -e

pacman -Syu --noconfirm base-devel sudo

useradd -Ums /bin/bash arch
cat > /etc/sudoers.d/passwd <<__EOF__
ALL ALL = (ALL) NOPASSWD: ALL
__EOF__

sed -i 's/pkg.tar.xz/pkg.tar.zst/g' /etc/makepkg.conf

chmod 777 -R .
for pkg in $1; do
    IFS=, read dir install <<< "${pkg}"
    pushd $dir
    if [ "${install}" == 'y' ]; then
        sudo -u arch makepkg -rsifA --noconfirm
    else
        sudo -u arch makepkg -rsfA --noconfirm
    fi
    popd
done
