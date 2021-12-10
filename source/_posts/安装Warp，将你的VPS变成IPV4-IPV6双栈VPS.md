---
title: 安装Warp，将你的VPS变成IPV4/IPV6双栈VPS
comments: true
date: 2021-12-10 11:00:58
updated:
description: 
categories:  优雅の分享
tags: VPS
---

  在VPS套上WARP后，可以令你的单线纯ipv4或者纯ipv6的VPS变成ipv4/ipv6双杀的双栈VPS！换句简单的话来说，就是原来只能访问IPV6或者IPV4资源的VPS，在安装了Warp之后，就能同时访问IPV4和IPV6的网络资源！

  P.S. 如果您的VPS是OpenVZ的VPS，请自行在服务商的控制面板开启TUN模块后使用脚本开启Warp。


### 准备材料

- VPS 一台



### 部署步骤
本文基于Euserv VPS的Debian11系统的部署环境，如您的系统不是Debian 11的建议自行上网另找方法。

1. SSH登录VPS

2. 复制、粘贴并运行以下代码
`wget -N https://cdn.jsdelivr.net/gh/fscarmen/warp/menu.sh && bash menu.sh`

3. 选择1或2选项

![](https://s2.loli.net/2021/12/10/HrtZvJ1cwyYSKmI.png)

4. 输入Warp+的key，如没有按Enter键跳过，使用免费账号 (CloudFlare Warp+和免费账号的速度都差不多，没什么区别)

![](https://s2.loli.net/2021/12/10/LR5vTi6DzOdACfx.png)

5. 选择内核方案（按照脚本作者的介绍，BoringTun > Wireguard-GO）

![](https://s2.loli.net/2021/12/10/JirjzBFXNhmaQAe.png)

6. 等待安装依赖
![](https://s2.loli.net/2021/12/10/kMSKw4Z7pGrT9hA.png)


### 常见问题

1. 脚本提示获取WARP IP 失败？
    请重新运行脚本安装，OpenVZ的机器请检查自己的TUN模块是否开启

2. 为什么warp的ip地区和vps的地区不一样
    CloudFlare的一些玄学问题吧，具体不清楚

3. 为何我无法启用WARP？
    有可能你使用的是OpenVZ的VPS，请在其服务商官网打开TUN之后输入命令： `cat /dev/net/tun` 查看TUN模块是否启用。

返回结果： `cat: /dev/net/tun:  File descriptor in bad state`  即代表已经开启TUN模块

返回结果：`cat: /dev/net/tun:  Operation not permitted`  即代表TUN模块未开启