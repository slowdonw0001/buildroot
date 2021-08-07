#!/bin/sh

mkdir -p /config/device-tree/overlays/$1
cat /boot/overlays/$1.dtbo > /config/device-tree/overlays/$1/dtbo
