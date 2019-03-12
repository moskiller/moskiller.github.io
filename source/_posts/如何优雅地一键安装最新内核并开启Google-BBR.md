---
title: 如何优雅地一键安装最新内核并开启Google BBR
comments: true
date: 2019-02-25 15:06:32
updated:
description: 在Vultr的VPS服务器上自建了一个 SSR 后 ，发现速度并不是很理想，那么，Google BBR走起~~
categories: 优雅の分享
tags: VPS
---

&emsp;&emsp;最近，Google 开源了其 TCP BBR 拥塞控制算法，并提交到了 Linux 内核，从 4.9 开始，Linux 内核已经用上了该算法。根据以往的传统，Google 总是先在自家的生产环境上线运用后，才会将代码开源，此次也不例外。  
&emsp;&emsp;根据实地测试，在部署了最新版内核并开启了 TCP BBR 的机器上，网速甚至可以提升好几个数量级。于是就有大神根据目前三大发行版的最新内核，开发了一键安装最新内核并开启 TCP BBR 的脚本。

## 适用环境  
>**注意！作者网站 teddysun.com 需要科学上网才能访问**  
>  
>  本文转载自：[秋水逸冰 » 一键安装最新内核并开启 BBR 脚本](https://teddysun.com/489.html)  
>
> 系统支持：CentOS 6+，Debian 7+，Ubuntu 12+  
> 虚拟技术：OpenVZ 以外的，比如 KVM、Xen、VMware 等  
> 内存要求：≥128M  
> 日期　　：2018 年 12 月 14 日  

### 关于本脚本  
1. 本脚本已在 Vultr 上的 VPS 全部测试通过。  
2. 当脚本检测到 VPS 的虚拟方式为 OpenVZ 时，会提示错误，并自动退出安装。  
3. 脚本运行完重启发现开不了机的，打开 VPS 后台控制面板的 VNC, 开机卡在 grub 引导, 手动选择内核即可。  
4. 由于是使用最新版系统内核，最好请勿在生产环境安装，以免产生不可预测之后果。  
  

## 安装方法  

使用root用户登录，运行以下命令：
```
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh  
```
安装完成后，脚本会提示需要重启 VPS，输入 y 并回车后重启。  
至此，安装完成。

## 验证是否安装成功的方法  

&emsp;&emsp;重启完成后，进入 VPS，验证一下是否成功安装最新内核并开启 TCP BBR，输入以下命令：
```
uname -r
```
查看内核版本，显示为最新版就表示 OK 了
```
sysctl net.ipv4.tcp_available_congestion_control
```
 返回值一般为：
`net.ipv4.tcp_available_congestion_control = bbr cubic reno`  
或者为：  
`net.ipv4.tcp_available_congestion_control = reno cubic bbr`

```
sysctl net.ipv4.tcp_congestion_control
```
返回值一般为：  
`net.ipv4.tcp_congestion_control = bbr`  
```
sysctl net.core.default_qdisc
```
返回值一般为：
`net.core.default_qdisc = fq`  
```
lsmod | grep bbr
```
返回值有 tcp_bbr 模块即说明 bbr 已启动。**注意：并不是所有的 VPS 都会有此返回值，若没有也属正常。**