---
title: hexo-git-backup备份插件推送到github报错的问题和解决方法
comments: true
date: 2021-12-07 10:23:53
updated:
description: hexo-git-backup备份插件推送到github报错的问题和解决方法
categories: 优雅の分享
tags: Github Hexo
---



## 起因

  原来一直用着的[hexo-git-backup](https://github.com/coneycode/hexo-git-backup)备份插件，今天突然出错了，我在执行`hexo b`后，控制台显示如下：

```bash
vincent@iMac moskiller.github.io % hexo b
INFO  Validating config
INFO  Start backup: git
[Source 49694d1] Backup My Blog

fatal: 'github' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
INFO  Backup done: git
```

我的`_config.yml`配置是这样的
```bash
backup:
  type: git
  theme: hexo-theme-matery
  message: Backup My Blog
  repository:
    github: git@github.com:moskiller/moskiller.github.io.git,Source
```



## 检查过程

  上网查询无果后，我在`node_modules/hexo-git-backup/git.js` 文件中加入了一行代码以显示执行的命令 （76-77行之间）
即将这个
```javascript
    var run = function(command, args, callback){
      var cp = spawn(command, args, {cwd: deployDir});
```
修改为：
```javascript
  var run = function(command, args, callback){
    console.log(command, args);
    var cp = spawn(command, args, {cwd: deployDir});
```

然后，我再运行 `hexo b`，出现了以下提示

```bash
INFO  Validating config
INFO  Start backup: git
git [ 'add', '-A' ]
git [ 'commit', '-m', 'Backup My Blog' ]
nothing to commit, working tree clean
git [ 'push', '-u', 'github', 'master:Source', '--force' ]

fatal: 'github' does not appear to be a git repository
fatal: Could not read from remote repository.

Please make sure you have the correct access rights
and the repository exists.
INFO  Backup done: git
```

以上内容里的主要错误信息翻译过来就是：

> 致命：“origin”不是一个 git 存储库
> 致命：无法读取远程存储库

> 请确定你有正确的访问权力，并且 存储库存在 

问题原因找到了！



## 解决方法

参考网上资料，将`node_modules/hexo-git-backup/git.js` 的第135行：
`commands.push(['push', '-u', t, 'master:' + repo[t].branch, '--force']);`
改成
`commands.push(['push', '-u', t, 'Source:' + repo[t].branch, '--force']);`


然后再将`_config.yml`配置文件中`github:` 更改为`origin:`



最后测试结果：

```bash
vincent@iMac moskiller.github.io % hexo b
INFO  Validating config
INFO  Start backup: git
git [ 'add', '-A' ]
git [ 'commit', '-m', 'Backup My Blog' ]
[Source f59b8df] Backup My Blog
 1 file changed, 1 insertion(+), 1 deletion(-)
git [ 'push', '-u', 'origin', 'Source:Source', '--force' ]
Enter passphrase for key '/Users/vincent/.ssh/id_rsa': 
To github.com:moskiller/moskiller.github.io.git
   a7d2cfd..f59b8df  Source -> Source
Branch 'Source' set up to track remote branch 'Source' from 'origin'.
INFO  Backup done: git
```

问题解决了！
