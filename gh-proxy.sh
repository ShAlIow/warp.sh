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
    # 第1个参数是修改前的github脚本
    ghres=${1}
    
    # 第2个参数是github proxy
    ghproxy='https://github.crazypeace.workers.dev/'
    
    #
    perlcmdbegin=' | perl -pe "$(curl -L '
    perlcmdend=')"'
    
    # 第3个参数是perl规则文件
    perlrule='https://github.com/crazypeace/gh-proxy/raw/master/perl-pe-para'
    
    result=$(echo -n ${ghres} | sed -r "s#(bash.*curl.*)(https?:.*)(\).*)#\1${ghproxy}\2${perlcmdbegin}${ghproxy}${perlrule}${perlcmdend}\3#g")
    
    echo ${result}
    
else
    echo "用法"
    echo -e "gh-proxy.sh \"${yellow}你要处理的github脚本${none}\" | bash"
    echo -e "注意要用${red}双引号${none}包住${yellow}github${none}脚本"
    echo
    echo -e "教程 ${green}https://zelikk.blogspot.com/2023/02/vps-github-proxy.html${none}"
    echo
    echo "示例:"
    echo "修改前"
    echo -e "bash <(curl -L https://raw.githubusercontent.com/P3TERX/warp.sh/main/warp.sh) 4"
    echo "修改后"
    echo -e "${yellow}bash <(curl -L${none} ${green}https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh${none}${yellow}) 4${none}"
    echo "修改后"
    echo -e "${yellow}bash <(curl -L${none} ${cyan}https://github.crazypeace.workers.dev/${none}${green}https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh${none}${red} | perl -pe \"\$(curl -L${none} ${cyan}https://github.crazypeace.workers.dev/${none}${magenta}https://github.com/crazypeace/gh-proxy/raw/master/perl-pe-para${none}${red})\"${none}${yellow}) 4${none}"
fi
