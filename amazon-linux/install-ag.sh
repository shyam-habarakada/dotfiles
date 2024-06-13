sudo yum groupinstall "Development tools" -y
sudo yum -y install pcre-devel xz-devel zlib-devel

cd /opt/apps
sudo git clone https://github.com/ggreer/the_silver_searcher.git

cd the_silver_searcher
sudo ./build.sh
sudo make install

