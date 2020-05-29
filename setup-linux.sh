#!/usr/bin/env bash

#Tratando possíveis erros
set -e

mkdir $HOME/Softwares
rm -r $HOME/Public $HOME/Templates

dir_downloads=$HOME/Downloads
dir_softwares=$HOME/Softwares

arr_snaps=(postman)
arr_snaps_classic=(slack skype)

arr_downloads=(
"https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
)


cd $dir_softwares

echo 'Atualizando pacotes...'
sudo apt update
sudo apt upgrade -y

# Iniciando download dos pacotes para setup de desenvolvimento
echo 'Instalando Nginx'
sudo apt install -y nginx

echo 'Instalando PHP 7.4'
sudo add-apt-repository ppa:ondrej/php -y -u
sudo apt update
sudo apt-get install -y --no-install-recommends php7.4 php7.4-{bcmath,bz2,intl,gd,mbstring,mysql,zip,fpm}

echo 'Instalando NVM'
wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
nvm install node -y
nvm install-latest-npm

echo 'Instalando PostgreSQL'
sudo apt install -y postgresql postgresql-contrib

echo 'Instalando SNAPS'
snap install ${arr_snaps[@]}
snap install --classic ${arr_snaps_classic[@]}
