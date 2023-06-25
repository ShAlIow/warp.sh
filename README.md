如果能使用 `bash <(curl -fsSL git.io/warp.sh)` 就不需要使用我这个脚本
---

在某些IPV6的VPS上(包括但不限于Hax/Woiden)有可能用不了，遇到如下报错。
```
Failed to connect to api.github.com port 443: Connection timed out
```
需要使用本脚本搭建wgcf模式的WARP
```
bash <(curl -L https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh) 4 
```
这个命令本身也是一个github脚本, 如果执行报错. 那么可以带上github proxy去访问github资源. 如下:
```
bash <(curl -L https://ghproxy.crazypeace.workers.dev/https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh) 4
```
对, 这行命令就是这么长, 这么奇怪, 你全部复制一次粘贴执行就好.

---

在Woiden上面用wgcf模式搭了IPv4的WARP之后，就不能通过共享IPv4的SSH端口登录了，需要执行：
```
wg-quick down wgcf
sed -i "7 s/^/PostUp = ip -4 rule add from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
sed -i "8 s/^/PostDown = ip -4 rule delete from $(ip route get 1.1.1.1 | grep -oP 'src \K\S+') lookup main\n/" /etc/wireguard/wgcf.conf
wg-quick up wgcf
```
也可以使用这个综合在一起了的脚本
```
bash <(curl -L https://raw.githubusercontent.com/crazypeace/warp.sh/main/wgcf_postup_postdown.sh)
```

---

有时，访问某些域名时，你的VPS会使用IPv6而不是IPv4，于是遇到问题。这时你可以设置IPv4优先
```
bash <(curl -L https://raw.githubusercontent.com/crazypeace/warp.sh/main/ipv4v6.sh) 4
```

# for IPv6 only VPS which can not access github.com, api.github.com, git.io
```
bash <(curl -L https://ghproxy.crazypeace.workers.dev/https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh) [SUBCOMMAND]
```
Don't worry, the `https://ghproxy.crazypeace.workers.dev/` is a github proxy.

For example, setup IPv4 outbound on IPv6 only VPS
```
bash <(curl -L https://ghproxy.crazypeace.workers.dev/https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh) 4
```
Sometimes, when you access some domain, your vps try to get through IPv6 but failed or jammed.
Please try to switch to 'IPv4 priority'
```
sed -i '/^precedence \:\:ffff\:0\:0/d;/^label 2002\:\:\/16/d' /etc/gai.conf
echo "precedence ::ffff:0:0/96  100" >> /etc/gai.conf
```
You can also use my script to switch to 'IPv4 priority'
```
bash <(curl -L https://raw.githubusercontent.com/crazypeace/warp.sh/main/ipv4v6.sh) 4
```



# 对比原版修改说明
- 脚本中写了一个默认的 gh-proxy https://ghproxy.crazypeace.workers.dev/
- 可以带参数使用自定义的 gh-proxy
- 修改脚本用到的 wgcf.sh 和 wireguard-go.sh 使其可以传入 gh-proxy 参数并上传至本 repo 
- wgcf.sh 和 wireguard-go.sh其中访问 api.github.com 获得链接的部分改为写死的，并将 wireguard-go 和 wgcf 发布包上传至本 repo

## 用你的STAR告诉我这个Repo对你有用 Welcome STARs! :)
[![Stargazers over time](https://starchart.cc/crazypeace/warp.sh.svg)](https://starchart.cc/crazypeace/warp.sh)

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
bash <(curl -L https://raw.githubusercontent.com/crazypeace/warp.sh/main/warp.sh) [SUBCOMMAND]
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
