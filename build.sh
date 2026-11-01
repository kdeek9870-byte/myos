#!/bin/bash
set -euo pipefail
ROOT="$(cd "$(dirname "$0")" && pwd)"
case "${1:-}" in
  live)
    mkarchiso -v -w "$ROOT/work" -o "$ROOT/out" "$ROOT/profile"
    ;;
  install)
    # Same profile; install.sh is already inside airootfs/root/
    mkarchiso -v -w "$ROOT/work" -o "$ROOT/out" "$ROOT/profile"
    ;;
  rootfs)
    # Build a bare rootfs without ISO (for chroot testing)
    pacstrap -K -C /etc/pacman.conf /mnt/myos \
      $(grep -v '^#' "$ROOT/profile/packages.x86_64" | grep -v '^$')
    cp -a "$ROOT/overlay/." /mnt/myos/
    echo "Rootfs at /mnt/myos — arch-chroot into it to finish setup."
    ;;
  *)
    echo "usage: $0 {live|install|rootfs}"; exit 1;;
esac
