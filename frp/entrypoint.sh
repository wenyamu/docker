#!/bin/sh

FILENAME="/usr/bin/frps"

if [ -f "$FILENAME" ]; then
    frps -c /etc/frp/frps.toml
else
    frpc -c /etc/frp/frpc.toml
fi
