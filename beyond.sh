THIS_DIR=$(cd $(dirname $0); pwd)
cd $THIS_DIR

# echo the color
gray() {
  printf '\e[1;30m%s\n\e[0;39;49m' "$@"
}
red() {
  printf '\e[1;31m%s\n\e[0;39;49m' "$@"
}
green() {
  printf '\e[1;32m%s\n\e[0;39;49m' "$@"
}
brown() {
  printf '\e[1;33m%s\n\e[0;39;49m' "$@"
}
blue() {
  printf '\e[1;34m%s\n\e[0;39;49m' "$@"
}
pink() {
  printf '\e[1;35m%s\n\e[0;39;49m' "$@"
}
paleblue() {
  printf '\e[1;36m%s\n\e[0;39;49m' "$@"
}
white() {
  printf '\e[1;37m%s\n\e[0;39;49m' "$@"
}

function logo() {
green "          ____  ____     _____"
green "         |  _ )|  _ \   |_   _|___ ____   __  __"
white "         |  _ \| |_) )    | |/ .__|  _ \_|  \/  |"
red   "         |____/|____/     |_|\____/\_____|_/\/\_|"
}
function logo1() {
green "     >>>>                       We Are Not Attacker                             "
green "     >>>>                       We Are Not Alliance                             "
white "     >>>>                       We Are Family                                   "
red   "     >>>>                       We Are The Best :-)                             "
red   "     >>>>                       @BeyondTeam                                     "
}
update() {
  git pull
  install 
}

tgcli_config() {
  mkdir -p "$THIS_DIR"/tg/telegram-cli
  printf '%s\n' "
default_profile = \"default\";

default = {
  config_directory = \"$THIS_DIR/tg/telegram-cli\";
  auth_file = \"$THIS_DIR/tg/telegram-cli/auth\";
  test = false;
  msg_num = true;
  log_level = 2;
};
" > "$THIS_DIR"/tg/tg-cli.config
}

install() {
green 'Do you want me to install? (Yy/Nn): '
  read -rp ' ' install
  case "$install" in
    Y|y)
      echo 'Installing update and updating'
      sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
		sudo apt-get install g++-4.7 -y c++-4.7 -y
		sudo apt-get update
		sudo apt-get upgrade
		sudo apt-get install libreadline-dev -y libconfig-dev -y libssl-dev -y lua5.2 -y liblua5.2-dev -y lua-socket -y lua-sec -y lua-expat -y libevent-dev -y make unzip git redis-server autoconf g++ -y libjansson-dev -y libpython-dev -y expat libexpat1-dev -y
		sudo apt-get install screen -y
		sudo apt-get install tmux -y
		sudo apt-get install libstdc++6 -y
		sudo apt-get install lua-lgi -y
		sudo apt-get install libnotify-dev -y
		sudo service redis-server restart
      echo ''
  esac
}

telegram-cli() {
red 'Do you want me to install the telegram-cli? (Yy/Nn): '
  read -rp ' ' install
  case "$install" in
    Y|y)
 echo "telegram-cli-1222 has been downloading..."
 tgcli_config
 cd tg
 wget "https://valtman.name/files/telegram-cli-1222"
 mv telegram-cli-1222 tgcli
 echo "Chmoded tgcli"
 sudo chmod +x tgcli
 cd ..
 esac
}

commands() {
  cat <<EOF

  Usage: $0 [options]

    Options:
      install           Install ${0##*/}
      update            Update ${0##*/}
      start             Start ${0##*/}
	  on                Dont off your bot

EOF
}

if [ "$1" = "install" ]; then
logo
logo1
install
telegram-cli
tgcli_config
elif [ "$1" = "update" ]; then
logo
logo1
update
tgcli_config
elif [[ "$1" = "on" ]]; then
if [ ! -f ./tg/tgcli ]; then
echo "tg not found"
echo "Run $0 install"
exit 1
fi
logo
logo1
tgcli_config
while true; do
screen ./tg/tgcli -WRs ./bot/bot.lua -c ./tg/tg-cli.config -p default "$@"
done
elif [[ "$1" = "start" ]]; then
if [ ! -f ./tg/tgcli ]; then
echo "tg not found"
echo "Run $0 install"
exit 1
fi
logo
logo1
tgcli_config
./tg/tgcli -WRs ./bot/bot.lua -c ./tg/tg-cli.config -p default "$@"
else
logo
logo1
commands
fi