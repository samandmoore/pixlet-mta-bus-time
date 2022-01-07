#!/bin/bash

set -e

cat <<EOT > /etc/apt/sources.list
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal main restricted
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal-updates main restricted
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal universe
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal-updates universe
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal multiverse
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal-updates multiverse
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ focal-backports main restricted universe multiverse
deb [arch=amd64] http://security.ubuntu.com/ubuntu/ focal-security main restricted
deb [arch=amd64] http://security.ubuntu.com/ubuntu/ focal-security universe
deb [arch=amd64] http://security.ubuntu.com/ubuntu/ focal-security multiverse
EOT

apt-get update
apt-get install -y \
    libwebp-dev