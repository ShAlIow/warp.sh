update on 2022-8-4
---
在Hax/Woiden的VPS上还是有可能会遇到如下报错。需要使用本脚本搭建wgcf模式的WARP
```
Failed to connect to api.github.com port 443: Connection timed out
```
在Woiden上面用wgcf模式搭了IPv4的WARP之后，就不能通过共享IPv4的SSH端口登录了，需要执行：
```
wg-quick down wgcf
sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
sed -i "8 s/^/PostDown = ip -4 rule delete from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
wg-quick up wgcf
```

也可以使用这个
```
bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/wgcf_postup_postdown.sh)
```
综合成一行脚本就是
```
bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/warp.sh) 4 && bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/wgcf_postup_postdown.sh)
```
对，这是一行命令，非常长。


update on 2022-7-7
---
git.io 和 raw.githubusercontent.com 可以在IPv6环境下访问了。

You can access git.io and raw.githubusercontent.com in only IPv6 environment.


# for IPv6 only VPS which can not access github.com, api.github.com, git.io
```
bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/warp.sh) [SUBCOMMAND]
```
For example, setup IPv4 outbound on IPv6 only VPS
```
bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/warp.sh) 4
```
Sometimes, when you access some domain, your vps try to get through IPv6 but failed or jammed.
Please try to switch to 'prefer IPv4'
```
sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf
```
You can also use my script to switch to 'prefer IPv4'
```
bash <(curl -L https://raw.githubusercontents.com/crazypeace/warp.sh/main/ipv4v6.sh) 4
```
# 对比原版修改说明
- 把脚本中所有 git.io 和 raw.githubusercontent.com 都改成 raw.githubusercontents.com 的形式

- 修改脚本用到的 wgcf.sh 和 wireguard-go.sh 并上传至本 repo

- 其中访问 api.github.com 获得链接的部分改为写死的，并将 wireguard-go 和 wgcf 发布包上传至本 repo

## 用你的STAR告诉我这个Repo对你有用 Welcome STARs! :)

---

**English** | [中文](https://p3terx.com/archives/cloudflare-warp-configuration-script.html)

# Cloudflare WARP configuration script

Quickly configure and use Cloudflare WARP on your Linux Server, which works with the latest major Linux distributions.

## Features

- Automatically install CloudFlare WARP Official Linux Client
- Quickly enable WARP Proxy Mode, access WARP network with SOCKS5
- Automatically install WireGuard related components
- Configuration WARP IPv4 Network interface (with WireGuard)
- Configuration WARP IPv6 Network interface (with WireGuard)
- Configuration WARP Dual Stack Network interface (with WireGuard)
- ...

## Usage

```bash
bash <(curl -fsSL git.io/warp.sh) [SUBCOMMAND]
```

### Subcommands

```
install         Install Cloudflare WARP Official Linux Client
uninstall       uninstall Cloudflare WARP Official Linux Client
restart         Restart Cloudflare WARP Official Linux Client
proxy           Enable WARP Client Proxy Mode (default SOCKS5 port: 40000)
unproxy         Disable WARP Client Proxy Mode
wg              Install WireGuard and related components
wg4             Configuration WARP IPv4 Global Network (with WireGuard), all IPv4 outbound data over the WARP network
wg6             Configuration WARP IPv6 Global Network (with WireGuard), all IPv6 outbound data over the WARP network
wgd             Configuration WARP Dual Stack Global Network (with WireGuard), all outbound data over the WARP network
wgx             Configuration WARP Non-Global Network (with WireGuard), set fwmark or interface IP Address to use the WARP network
rwg             Restart WARP WireGuard service
dwg             Disable WARP WireGuard service
status          Prints status information
version         Prints version information
help            Prints this message or the help of the given subcommand(s)
menu            Chinese special features menu
```

## Credits

- [Cloudflare WARP](https://1.1.1.1/)
- [WireGuard](https://www.wireguard.com/)
- [ViRb3/wgcf](https://github.com/ViRb3/wgcf)

## License

[MIT](https://github.com/P3TERX/warp.sh/blob/main/LICENSE) © **[P3TERX](https://p3terx.com/)**
