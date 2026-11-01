#!/bin/bash
set -e

# Live user
if ! id live &>/dev/null; then
    useradd -m -G wheel,audio,video,input -s /bin/bash live
    getent group seat >/dev/null && usermod -aG seat live
    passwd -d live
fi

# systemd targets and services
systemctl enable NetworkManager sddm tlp
systemctl set-default graphical.target

# max98090 audio fix for CELES
ln -sf sof-cht-max98090.tplg /usr/lib/firmware/sof-byt-max98090.tplg
