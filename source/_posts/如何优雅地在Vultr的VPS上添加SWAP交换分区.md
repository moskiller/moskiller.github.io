---
title: 如何优雅地在Vultr的VPS上添加SWAP交换分区
comments: true
date: 2019-02-26 15:55:35
updated:
description: Vultr的VPS主机预设置是不会有swap交换分区，如何手动添加swap呢？Follow me~
categories: 优雅の分享
tags: VPS
---

> 首先，贴上[Vultr官方的设置方法](https://www.vultr.com/docs/setup-swap-file-on-linux)的地址，
> 英文好的童鞋直接照着操作就行了，毕竟官方嘛，你懂的。  
  
以下是官方原文:  
## Setup Swap File on Linux

There will be times where you need to increase the responsiveness of your server to prevent out of memory issues. Out of memory issues happen when an application running on your server starts consuming a large amount of memory. Swap is designed as virtual memory, which uses your harddrive to store data that cannot be held in RAM. This tutorial will show you how to create a swap file, which should work under Ubuntu, CentOS, and Debian. This tutorial is not meant for any Custom ISO, but it is possible to follow along.

**Step 1: Verify that swap does not exist**

To prevent any issues during this tutorial, you will need to run the following to verify that a swap space is currently not active:

`free -m`  

After running that command you should see something similar to this output:
```
total              used       free     shared    buffers     cached
Mem:               1840       1614     226       15          36       1340
-/+ buffers/cache:            238      1602
Swap:              0          0        0
```
If you see a value of 0 in the Swap section, then you can proceed to step 2.

Alternatively, you can run the following command to see if there is a configured swap file:

`swapon -s`

If you do not see any output from swapon, then proceed to step 2.

**Step 2: Create swap file**

You will need to choose a location for your file. In this tutorial, it will be stored at the root of the server. We will create a 2GB swap file by running the following command:  

`dd if=/dev/zero of=/swapfile count=2048 bs=1M`  

The dd command will produce output in a similar format to:
```
2048+0 records in
2048+0 records out
2147483648 bytes (2.1 GB) copied, 10.5356 s, 204 MB/s
```
Next, verify that the file is located at the root of your Vultr VPS by running:

`ls / | grep swapfile`

Proceed if you see the swapfile file.

**Step 3: Activate the swap file**

Swap files are not recognized automatically. We will need to tell the server how to format the file and enable it so it can be used as a valid swap file. As a security measure, update the swapfile permissions to only allow R/W for root and no other users. Run:

`chmod 600 /swapfile`

The permission change can be verified by running the following command:

`ls -lh /swapfile`

You will see a file display:
```
-rw------- 1 root root 2.0G Oct  2 18:47 /swapfile
```
Next, tell the server to setup the swap file by running:

`mkswap /swapfile`

After running it, you will see the following output:

Setting up swapspace version 1, size = 2097148 KiB
no label, UUID=ff3fc469-9c4b-4913-b653-ec53d6460d0e
If everything is shown as above, you are now ready to move on to the next step.

**Step 4: Turn swap on**

Once your file is ready to be used as swap, you need to enable it by running:

`swapon /swapfile`

You can verify that the swap file is active by running the free command again.

`free -m`
  
```
total       used       free     shared    buffers     cached
Mem:          1840       1754         86         16         23       1519
-/+ buffers/cache:        210       1630
Swap:         2047          0       2047
```

If Swap shows something other than 0, then you have successfully setup swap.

**Step 5: Enable swap on reboot**

By default, your server will not automatically enable this new swap file. To enable it on boot, you can update the /etc/fstab file. Any text editor will suffice. In this example, I will be using nano.

`nano /etc/fstab`

Add the following line at the end of the file:
```
/swapfile   none    swap    sw    0   0
```

Save and close when you are finished editing the file. We are all done!


## ~~以上的英文我都会，但是...~~ 请说人话！！！
emmm....其实也就是几句话，首先用root登陆你的VPS。然后按以下步骤操作：
1. 运行&emsp; `free -m` &emsp;或者&emsp; `swapon -s` &emsp;命令，随便一个都可以，检测是否已存在SWAP分区。
2. 如果无SWAP分区，那么就运行&emsp; `dd if=/dev/zero of=/swapfile count=2048 bs=1M` &emsp;这个命令来建立SWAP分区文件。**注意，Count=2048 这个参数**，这里的2048代表是2GB，如果你按这个命令输入的话，你将会创建一个2GB大小的SWAP分区，要是你想建立1GB的SWAP分区的话，将`2048`修改为`1024`即可。
3. 使用&emsp; `chmod 600 /swapfile` &emsp;命令赋予权限给SWAP文件。然后，使用`mkswap /swapfile` &emsp;命令来格式化SWAP文件。
4. 使用&emsp;`swapon /swapfile` &emsp;命令来激活SWAP文件。
5. 如果你要VPS主机重启的时候可以自动挂载Swap ，那么还需要修改fstab配置文件，用Vim或者Nano打开/etc/fstab文件，比如你使用的是nano，那么命令如下：&emsp; `nano /etc/fstab`，&emsp;然后在打开的文件最后面添加这一行字：&emsp; `/swapfile   none    swap    sw    0   0` &emsp; ，保存并关闭文件后，整个世界安静了！！！
