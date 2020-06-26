#!/bin/sh

rm -rf /var/run
mkdir -p /var/run/dbus

dbus-uuidgen --ensure
dbus-daemon --system

if [ "$WITH_AVAHI" = true ]; then
    echo '::[warn] : Running with Avahi enabled'
    avahi-daemon --daemonize --no-chroot
else
    echo '::[warn] : Running with Avahi disabled'
fi

shairport-sync -m avahi -a "$AIRPLAY_NAME" -- -d "$OUTPUT_DEVICE" "$@"
