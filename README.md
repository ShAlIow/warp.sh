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
proxy           Enable WARP Client Proxy Mode (default SOCKS5 port: 40000)
unproxy         Disable WARP Client Proxy Mode
wg4             Configuration WARP IPv4 Network interface (with WireGuard)
wg6             Configuration WARP IPv6 Network interface (with WireGuard)
wgd             Configuration WARP Dual Stack Network interface (with WireGuard)
rewg            Restart WARP WireGuard service
unwg            Disable WARP WireGuard service
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
