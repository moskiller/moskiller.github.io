---
title: 如何优雅地保存你在Github上的Hexo源代码
comments: true
date: 2019-09-29 17:34:46
updated:
description: 如果换了电脑或者重装系统后，怎样才以继续更新博客？
categories: 优雅の分享
tags: Github Hexo
---

  今天重新回到博客的大家庭里，却发现很多东西，比如hexo配置、markdown标记命令等都忘记了，为了以后不再出现此情况，特此记下这些流程：

------

### 一、搭建博客的动作

1. 这里我假定你已经注册了[Github](https://github.com) ，登录github后，新建一个仓库(Repository)，Repository name就填xxxxx.github.io，xxxxx是你的用户名，比如我这里填写的是： [moskiller.github.io](https://moskiller.github.io) 。
2. 然后，在这个Repository 里创建两个分支：Master 与 Source。
3. 设置 Source 为默认分支（因为我们只需要管理这个分支上的Hexo源文件）。
4. 使用git clone git@github.com:moskiller/moskiller.github.io.git拷贝仓库，请将moskiller更换为你的用户名。
5. 安装 Hexo 前，请先确认你是否已安装[Node.js](http://nodejs.org/) 和 [Git](http://git-scm.com/) ，(MacOS系统自带旧版本git，无需安装了，当然你也可以升级安装更新的版本)。如果您的电脑中已经安装上述必备程序，那么恭喜您！接下来只需要使用 npm 即可完成 Hexo 的安装。
6. 在本地的 `你的用户名.github.io` 文件夹下通过终端或者bash依次运行以下命令：
```bash
npm install -g hexo-cli
hexo init
npm install
npm install hexo-deployer-git（此时当前分支应显示为 Source ）
```
6. hexo安装好后，修改根目录中的_config.yml中的deploy参数，这里的分支应填写为 **Master**，保存并关闭文件。

7. 然后就是你日常写作等那些命令了，比如 hexo new "hello world"等，不再详解，你可到 [Hexo.io](https://hexo.io/zh-cn/)官网这里查看。

    

### 二、日常发表博文的动作

1. 在本地对博客添加新博文、修改等等后，推荐通过下面的命令进行管理。

2. 首先在终端里依次执行:
```bash
git add .
git commit -m “…”
git push origin Source
```
3. 然后才执行 **`hexo clean && hexo g -d `**发布文章到 master 的分支上。

**当然，如果你认为不需要备份内容的话，你可以直接输入第３步的命令(即 hexo clean && hexo -g d, 或者直接 hexo -g d )进行上传。但作为曾经的受害者，我敬告你尽量按照以上命令进行发布，否则当某一天你的电脑硬盘坏了、系统重装等悲催的情况出现时，那就呵呵了**

  

### 三、硬盘损坏、系统重装等本地资料丢失后的动作

当你真的不幸碰到以上我所说的系统重装、硬盘损坏等情况后，又或者你突然间想在其他电脑上发布或修改博客文章时，如果你严格按照上一项中建议的命令进行发布的话，那么恭喜你，你可以使用下面的动作进行操作了，**如果你并没有按照操作的话..... 呵呵...**

1. 使用命令 `git clone git@github.com:moskiller/moskiller.github.io.git` 拷贝仓库（请将 moskiller 修改为你的用户名）。
2. 在本地新拷贝的 `你的用户名.github.io` 文件夹下通过终端或者 bash依次执行下列命令就OK了：
```bash
npm install -g hexo-cli
npm install
npm install hexo-deployer-git 

**（切记！不要输入　hexo init　这条命令，这是新建初始化的命令！！！）**
**（切记！不要输入　hexo init　这条命令，这是新建初始化的命令！！！）**
**（切记！不要输入　hexo init　这条命令，这是新建初始化的命令！！！）**
```



### <u>9.30日更新</u>

今天修改了一下文件，在执行 `git push` 命令推送的时候，报如下错误：
```bash
![rejected]  master->master(fetch first)  
error:failed to push some refs to 'https://github.com/xxx/xxx.git'
```
查了一下google，发现出错的原因是因为我刚才在github网站上手动修改了 CNAME 文件。
解决的办法就是先更新服务器上的变化到本地，然后才能提交。

输入 `git pull`，然后再执行 `git push` 就可以了。



 



