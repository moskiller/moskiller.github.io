---
title: 分享一个VLESS VMess Trojan Trojan-Go 八合一脚本
comments: true
date: 2021-12-13 10:33:12
updated:
description:
categories: 优雅の分享
tags: 脚本
---



项目地址：[Github/mack-a](https://github.com/mack-a/v2ray-agent)
使用指南：[How To Use](https://github.com/mack-a/v2ray-agent/blob/master/documents/how_to_use.md)


### 安装方法
  在你的VPS终端中输入：
  `wget -P /root -N --no-check-certificate "https://raw.githubusercontent.com/mack-a/v2ray-agent/master/install.sh" && chmod 700 /root/install.sh && /root/install.sh`

### 支持的安装类型
  VLESS+TCP+TLS
  VLESS+TCP+xtls-rprx-direct【推荐】
  VLESS+gRPC+TLS【支持CDN、IPv6、延迟低】
  VLESS+WS+TLS【支持CDN、IPv6】
  Trojan+TCP+TLS【推荐】
  Trojan+TCP+xtls-rprx-direct【推荐】
  Trojan+gRPC+TLS【支持CDN、IPv6、延迟低】
  VMess+WS+TLS【支持CDN、IPv6】

### 组合推荐
  中转/gia —> VLESS+TCP+TLS/XTLS、Trojan【推荐使用XTLS的xtls-rprx-direct】
  移动宽带 —> VMESS+WS+TLS/VLESS+WS+TLS/VLESS+gRPC+TLS/Trojan+gRPC+TLS + Cloudflare
  cloudflare-> VLESS+gRPC+TLS/Trojan+gRPC+TLS[多路复用、延迟低]