---
title: 修复DSDT时常用错误的处理办法
comments: true
date: 2019-10-14 09:28:29
updated:
description: 对于黑苹果电脑来说，DSDT和SSDT修复是必备技能之一。这里是DSDT修复中常用的几个错误的修复办法。
categories: 优雅の分享
tags: DSDT 黑苹果
---

### 前言

​    对于Hackinto电脑来说，正确的clover、config.plist和kext只能确保大部分电脑可以正常安装MacOS，但并不一定能保证能正常使用。在启动时，电脑会去读取ACPI的配置，不当的DSDT和SSDT有可能会导致出现系统启动失败、无法休眠、电池电量无法显示等很多奇奇怪怪的问题。很多人都知道使用DSDT补丁可以开双核，但DSDT的功能不仅仅如此，还可以修复显卡、声卡、网卡、电池、休眠等问题。

这里是你在MacOS中修复DSDT时需要用到的软件：[MaciASL](https://bitbucket.org/RehabMan/os-x-maciasl-patchmatic/downloads/RehabMan-MaciASL-2018-0507.zip) (RehabMan 2018-0507版)

以下例子是我在修复DSDT中常见的问题，如果以后有新的问题会继续更新。

### 修复例子

1. **switch变量未设置为Integer整数时的错误提示：**

```auto
Switch expression is not a static Integer/Buffer/String data type, default to integer
```

**例子:**

```assembly
 Method (WMBC, 3, Serialized)
            {
                Store (0x01, Local0)
                Switch (Arg1)
                {
                    Case (0x43455053)
```

**修复方法:**

```assembly
 Method (WMBC, 3, Serialized)
            {
                Store (0x01, Local0)
                Switch (ToInteger (Arg1))
                {
                    Case (0x43455﻿053)
```


​    
​    
​    
2. **定义了一个局部变量，但是Method方法没有用到这个变量时的错误提示：(注：如果这个是Warnings警告的话，可以不管它，但如果是Errors错误的话，必须修复。)**

```auto
Method Local is set, but never used (Local 0)
```

**例子:**

```assembly
 Store (0x03, OSVR)
        If (CondRefOf (\_OSI, Local0))
        {
           If (_OSI ("Windows 2001"))
```

或者

```assembly
Store (RGE3, PMFG)
                            Store (RGE3, Local0)
                            And (RGE0, 0x9F, RGE0)
```

**修复方法** **(** And(Local0, Ones, Local0) ==> Local 0 set to 0x11111111 ﻿**)**:

```assembly
 Store (0x03, OSVR)
        If (CondRefOf (\_OSI, Local0))
        {
           And(Local0, Ones, Local0)
           If (_OSI ("Windows 2001"))
```

或者

```assembly
Store (RGE3, PMFG)
                            Store (RGE3, Local0)
                            And(Local0, Ones, Local0)
                            And (RGE0, 0x9F, RGE0)
```


​    
​    
​    
3. **当含有不正确或未使用的方法名时的错误提示：**

```auto
   Invalid object type for reserved name (_OSC: found Integer, Buffer Required)
   
```

**例子**:

```assembly
 Method (_OSC, 4, Serialized)  // _OSC: Operating System Capabilities
      {
```

**修复方法** **(** 删除下划线，或者将其重命名，本例子中将重名为 "XOSC" **)**:

```assembly
Method (XOSC, 4, Serialized)  // _OSC: Operating System Capabilities
      {
```


​    
​    
​    
4. **方法/函数具有IF语句，如果为false时，则不会返回任何内容：**

```auto
   Not all control paths return a value (_OSC/O1EX/TINI/TWAK...etc)
   Reserved Method must return a value (Buffer required for _OSC)
```

**例子**:

```assembly
    Method (_TINI, 0, NotSerialized)
         {            
             If (LEqual (Arg0, ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
             {
                 (bunch of code here that'll get executed if the above IF statement returns true)
             }
         }
```

**修复方法 (** 在方法关闭之前添加 Return (Zero) **)**:

```assembly
Method (TINI, 4, Serialize﻿d)
         {            
             If (LEqual (Arg0, ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */))
             {
                 (bunch of code here that'll get executed if the above IF statement returns true)
             }
             Return (Zero)﻿
         }
```


​    
