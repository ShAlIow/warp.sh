wg-quick down wgcf
sed -i '/PostUp/d' /etc/wireguard/wgcf.conf
sed -i '/PostDown/d' /etc/wireguard/wgcf.conf
sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
sed -i "8 s/^/PostDown = ip -4 rule delete from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
wg-quick up wgcf
