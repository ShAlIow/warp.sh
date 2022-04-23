# Cut some part from https://github.com/fscarmen/warp

red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }

if [ $# -ge 1 ]; then
  case ${1} in
  4)
      priority=4
      ;;
  6)
      priority=6
      ;;    
  i)
      priority="i"
      ;;    
  *)
      echo -e "${red}Invalid Parameters: $*${none}"
      exit 1
      ;;
  esac
else
  # 选择优先使用 IPv4/IPv6 网络
  echo "Please choose the IPv4/IPv6 priority 请选择IPv4/IPv6优先级"
  read -p "$(echo -e "Input ${cyan}4${none} for IPv4, ${cyan}6${none} for IPv6, ${cyan}Press ENTER${none} for initial settings") " priority
fi

# IPv4, IPv6 优先
[[ -e /etc/gai.conf ]] && sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
case "$p" in
  4 )	echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf;;
  6 )	echo "label 2002::/16   2" >> /etc/gai.conf;;
  * )	;;
esac
