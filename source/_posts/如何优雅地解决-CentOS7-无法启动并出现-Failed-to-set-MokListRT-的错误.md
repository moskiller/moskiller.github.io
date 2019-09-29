---
title: 如何优雅地解决 CentOS7 无法启动并出现 Failed to set MokListRT 的错误
comments: true
date: 2019-03-08 10:53:01
updated:
description: 今天重装CentOS7(1810)的时候，在系统安装完成并重启的时候，出现了 Failed to set MokListRT 的错误提示后系统自动关机了，无法正常启动，于是到谷歌找了一下资料，按照大神的提示操作后系统终于可以正常启动了，特此记录下来。
categories: 优雅の分享
tags: CentOS
---

## 问题描述

&emsp;&emsp;今天突然心血来潮，将我的 Ubuntu 18.04 系统给干掉了，在 [CentOS Project](https://www.centos.org) 里下了一个最新版的 [CentOS7 X86_64 1801](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso) ISO刻录光碟后进行 CentOS 系统的安装，安装完成重启后却发现开不了机，报错内容如下：
```
Failed to set MokListRT: Invalid Parameter
Something as gone seriously wrong: import_mok_state() failed:
Invalid Parameter
```

## 错误原因
&emsp;&emsp; 有问题，上 Google ，查了一下发现错误原因主要是由于 `shim` 和 `mokutil` 两个软件包升级到高版本后，不支持我这台破机的配置，所以解决方法就是对这两个版本进行一些优雅的小操作。  

## 解决方法
1. 使用 CentOS7 的启动盘启动你的电脑后，选择点第三项 `Troubleshooting` 并回车，然后按照下面的顺序操作：`Troubleshooting` -> `Rescue media` -> `输入 1` 后继续以下的操作。

2. 在当前出现的终端下输入下面命令，命令完成后电脑会重启：
```
chroot /mnt/sysimage
cd /boot/efi/EFI/centos
cp grubx64.efi shimx64.efi
exit
reboot
```

3. 在完成上面的命令后，你应该就可以正常进入系统了。

4. 之后，我们还需要使用用管理员权限运行terminal终端,将  `shim` 和 `mokutil` 的两个包进行升级排除，免得以后一不小心升级了又要重新操作一番 ;)
```
echo 'exclude=shim*_,_mokutil*' >> /etc/yum.conf
yum update
```
这样，以后你使用 `yum update` 命令进行升级也不会升级这两个包了。


最后，附上参考文章的地址 [CentOS 7: Failed to set MokListRT: Invalid Parameter](https://angrysysadmins.tech/index.php/2018/12/grassyloki/centos-7-failed-set-moklistrt/)

  

