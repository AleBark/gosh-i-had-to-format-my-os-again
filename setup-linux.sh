#!/usr/bin/env bash

#Disabling erros from stopping the script
set -e

#Some folders that i like to remove/create
mkdir $HOME/Softwares
mkdir $HOME/Projects

rm -r $HOME/Public $HOME/Templates

dir_downloads=$HOME/Downloads
dir_softwares=$HOME/Softwares
dir_projects=$HOME/Projects

arr_snaps=(postman)
arr_snaps_classic=(slack skype)

arr_downloads=(
"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
)


cd $dir_softwares

echo 'Packages Update...this may take a while'
sudo apt update
sudo apt upgrade -y

# Starting to download development softwares packages
echo 'Nginx installation'
sudo apt install -y nginx

echo 'PHP 7.4 installation'
sudo add-apt-repository ppa:ondrej/php -y -u
sudo apt update
sudo apt-get install -y --no-install-recommends php7.4 php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,fpm}

echo 'NVM installation'
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install node -y
nvm install-latest-npm

echo 'PostgreSQL installation'
sudo apt install -y postgresql postgresql-contrib

echo 'Snaps installation'
snap install ${arr_snaps[@]}
snap install --classic ${arr_snaps_classic[@]}


wget -nv -c ${downloads[@]}
