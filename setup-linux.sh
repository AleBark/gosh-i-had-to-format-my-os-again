#!/usr/bin/env bash

#Disabling erros from stopping the script
set -e

#Some folders that i like to remove/create
arr_dirs_to_create=($HOME/Fonts $HOME/Softwares $HOME/Projects)
arr_dirs_to_remove=($HOME/Public $HOME/Templates)

for dir in ${arr_dirs_to_create[@]}; do
  if [ ! -d "$dir" ]; then
    mkdir $dir
  fi
done;

for dir in ${arr_dirs_to_remove[@]}; do
  if [ -d "$dir" ]; then
    rmdir $dir
  fi
done;


downloads_dir=$HOME/Downloads
softwares_dir=$HOME/Softwares
projects_dir=$HOME/Projects
fonts_dir=$HOME/Fonts

snaps_arr=(postman)
classic_snaps_arr=(slack skype vscode flutter)

cd $softwares_dir

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
#nvm install node -y
#nvm install-latest-npm

echo 'PostgreSQL installation'
sudo apt install -y postgresql postgresql-contrib

echo 'Snaps installation'
snap install ${snaps_arr[@]}
snap install --classic ${classic_snaps_arr[@]}

echo 'Firefox Developer Edition installation'
sh -c "$(wget "https://download.mozilla.org/?product=firefox-devedition-latest-ssl&os=linux64&lang=pt-BR" -O firefox-developer.tar.bz2)"
tar -jxvf  firefox-developer.tar.bz2 -C $softwares_dir
mv $softwares_dir/firefox $softwares_dir/firefox-developer/
sudo ln -sf $softwares_dir/firefox-developer/firefox /usr/bin/firefox-developer
echo -e '[Desktop Entry]\n Version=59.0.3\n Encoding=UTF-8\n Name=Mozilla Firefox\n Comment=Navegador Web\n Exec='{$softwares_dir}/'firefox-developer/firefox\n Icon='{$softwares_dir}/'firefox-developer/browser/chrome/icons/default/default128.png\n Type=Application\n Categories=Network' | sudo tee /usr/share/applications/firefox-developer.desktop
sudo chmod +x /usr/share/applications/firefox-developer.desktop

echo 'Zsh && Oh My Zsh installation'
sudo apt install -y zsh
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
chsh -s $(which zsh)

echo 'PowerLevel10k (Oh My Zsh theme)'

cd $fonts_dir;
sh -c "$(wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O MesloLGS_NF_Regular.ttf) | cp MesloLGS_NF_Regular.ttf usr/share/fonts/"
sh -c "$(wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O MesloLGS_NF_Bold.ttf)"
sh -c "$(wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O MesloLGS_NF_Italic.ttf)"
sh -c "$(wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf -O MesloLGS_NF_Bold_Italic.ttf)"
sudo cp MesloLGS* /usr/share/fonts/

cd $softwares_dir;
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
new_theme="powerlevel10k/powerlevel10k"
sed -i.bak 's~\(ZSH_THEME="\)[^"]*\(".*\)~\1'${new_theme}'\2~' ~/.zshrc