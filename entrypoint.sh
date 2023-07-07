#!/bin/bash
echo "root:${ROOT_PASSWORD}" | chpasswd
echo "root password is: ${ROOT_PASSWORD}"
exec /usr/sbin/sshd -D
