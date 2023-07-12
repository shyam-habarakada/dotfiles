#!/bin/bash

# silver-searcher
sudo yum -y install pkgconfig automake gcc zlib-devel pcre-devel xz-devel
cd /usr/local/src
sudo git clone https://github.com/ggreer/the_silver_searcher.git
cd the_silver_searcher
sudo ./build.sh
sudo make install

# nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
. ~/.nvm/nvm.sh
nvm install 16

# ctop

# awscli
# https://docs.aws.amazon.com/cli/latest/userguide/install-linux.html


