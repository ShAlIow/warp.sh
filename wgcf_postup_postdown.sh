wg-quick down wgcf

sed -i '/PostUp/d' /etc/wireguard/wgcf.conf
sed -i '/PostDown/d' /etc/wireguard/wgcf.conf
#sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
#sed -i "8 s/^/PostDown = ip -4 rule delete from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf

# IPv4
ipv4if=$(ip route get 1.1.1.1 | grep -oP 'src \K\S+')
if [[ -n $ipv4if ]]; then 
  sed -i "/\[Interface\]/ aPostDown = ip -4 rule delete from ${ipv4if} lookup main" /etc/wireguard/wgcf.conf
  sed -i "/\[Interface\]/ aPostUp = ip -4 rule add from ${ipv4if} lookup main" /etc/wireguard/wgcf.conf
fi

# IPv6
ipv6if=$(ip route get 2606:4700:4700::1111 | grep -oP 'src \K\S+')
if [[ -n $ipv6if ]]; then
  sed -i "/\[Interface\]/ aPostDown = ip -4 rule delete from ${ipv6if} lookup main" /etc/wireguard/wgcf.conf
  sed -i "/\[Interface\]/ aPostUp = ip -4 rule add from ${ipv6if} lookup main" /etc/wireguard/wgcf.conf
fi

wg-quick up wgcf
