---
title: 如何优雅地在您的VPS上一键安装 Shadowsocks（四合一版）
comments: true
date: 2019-02-25 11:35:27
updated:
description: 用了一段时间的免费SS、SSR后，感觉还是不爽，于是决定自己入手了一台 Vultr 的VPS服务器，自己搭建SSR来玩。
categories: 优雅の分享
tags: VPS
---
> **注意！作者网站 teddysun.com 需要科学上网才能访问**  
>  
>  本文转载自：[h秋水逸冰 » Shadowsocks 一键安装脚本（四合一）](https://teddysun.com/486.html)  
> 
> 本脚本适用环境  
> 系统支持：CentOS 6+，Debian 7+，Ubuntu 12+  
> 内存要求：≥128M  
> 日期　　：2019 年 01 月 11 日  

## 关于脚本
1. 一键安装 Shadowsocks-Python， ShadowsocksR， Shadowsocks-Go， Shadowsocks-libev 版（四选一）服务端；
2. 各版本的启动脚本及配置文件名不再重合；
3. 每次运行可安装一种版本；
4. 支持以多次运行来安装多个版本，且各个版本可以共存（注意端口号需设成不同）；
5. 若已安装多个版本，则卸载时也需多次运行（每次卸载一种）；
6. 友情提示：如果你有问题，请先阅读这篇[《Shadowsocks Troubleshooting》](https://teddysun.com/399.html)之后再询问。

#### 脚本的默认配置

* 服务器端口：自己设定（如不设定，默认从 9000-19999 之间随机生成）
* 密码：自己设定（如不设定，默认为 teddysun.com）
* 加密方式：自己设定（如不设定，Python 和 libev 版默认为 aes-256-gcm，R 和 Go 版默认为 aes-256-cfb）
* 协议（protocol）：自己设定（如不设定，默认为 origin）（仅限 ShadowsocksR 版）
* 混淆（obfs）：自己设定（如不设定，默认为 plain）（仅限 ShadowsocksR 版）
* 备注：脚本默认创建单用户配置文件，如需配置多用户，请手动修改相应的配置文件后重启即可。

#### 客户端下载

* 常规版 Windows 客户端  
https://github.com/shadowsocks/shadowsocks-windows/releases

* ShadowsocksR 版 Windows 客户端  
https://github.com/shadowsocksrr/shadowsocksr-csharp/releases


## 安装方法

使用root用户登录，运行以下命令：

```
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh  

chmod +x shadowsocks-all.sh  

./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

安装完成后，脚本提示如下
```
Congratulations, your_shadowsocks_version install completed!
Your Server IP        :your_server_ip
Your Server Port      :your_server_port
Your Password         :your_password
Your Encryption Method:your_encryption_method

Your QR Code: (For Shadowsocks Windows, OSX, Android and iOS clients)
 ss://your_encryption_method:your_password@your_server_ip:your_server_port
Your QR Code has been saved as a PNG file path:
 your_path.png

Welcome to visit:https://teddysun.com/486.html
Enjoy it!
```
到此安装完成，就是这样简单，现在，拿出您的小火箭，Go Go Go!  


## 卸载方法

若已安装多个版本，则卸载时也需多次运行（每次卸载一种）

使用root用户登录，运行以下命令：

```
./shadowsocks-all.sh uninstall
```


## 启动脚本
启动脚本后面的参数含义，从左至右依次为：启动，停止，重启，查看状态。
```
Shadowsocks-Python 版：
/etc/init.d/shadowsocks-python start | stop | restart | status
  
ShadowsocksR 版：
/etc/init.d/shadowsocks-r start | stop | restart | status
  
Shadowsocks-Go 版：
/etc/init.d/shadowsocks-go start | stop | restart | status
  
Shadowsocks-libev 版：
/etc/init.d/shadowsocks-libev start | stop | restart | status
```
  

### 各版本默认配置文件
```
Shadowsocks-Python 版：
/etc/shadowsocks-python/config.json
  
ShadowsocksR 版：
/etc/shadowsocks-r/config.json
  
Shadowsocks-Go 版：
/etc/shadowsocks-go/config.json
  
Shadowsocks-libev 版：
/etc/shadowsocks-libev/config.json
```


### 更新日志
* 2019 年 01 月 11 日：  
1、升级：libsodium 到最新版本 1.0.17；  
2、升级：mbedtls 到最新版本 2.16.0；  

* 2018 年 11 月 05 日：  
1、升级：使用 Github 上最新代码编译出 Go 版二进制可执行文件，版本号 1.2.2。  
 
* 2018 年 06 月 01 日：  
1、修正：在启用了插件 simple-obfs 的情况下，libev 版启动失败的问题；  
2、修正：在使用 /etc/init.d/shadowsocks-libev restart 命令重启 libev 版服务端时，偶尔出现的 “bind: Address already in use” 问题；  
3、修正：移除 libev 版配置文件中的 local_address 字段；  
4、修改：不再默认使用 root 用户启动，改为使用 nobody 用户启动 libev 版服务端 ss-server；  
5、升级：mbedtls 到版本 2.9.0；  
6、修改：libev 版启动脚本中的 -u 参数（即同时启用 TCP 和 UDP 模式），改到配置文件里配置为 “mode”: “tcp_and_udp”；  
7、修改：libev 版配置文件的内置 NameServers 为 8.8.8.8，默认是从 /etc/resolv.conf 中取得。  

* 以下省略......

## 更多单版本 Shadowsocks 服务端一键安装脚本

* [Shadowsocks Python 版一键安装脚本（CentOS，Debian，Ubuntu）](https://teddysun.com/342.html)  
* [ShadowsocksR 版一键安装脚本（CentOS，Debian，Ubuntu）](https://shadowsocks.be/9.html)  
* [CentOS 下 Shadowsocks-libev 一键安装脚本](https://teddysun.com/357.html)  
* [Debian 下 Shadowsocks-libev 一键安装脚本](https://teddysun.com/358.html)  
* [Shadowsocks-go 一键安装脚本（CentOS，Debian，Ubuntu）](https://teddysun.com/392.html)  

**注意：以上单版本不可与该四合一版本混用。**


