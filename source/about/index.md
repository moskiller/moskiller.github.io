---
title: about
date: 2019-01-30 15:42:51
type: "about"
comments: false
---

# 0x00 关于 Blog
&ensp;&ensp;本博客自`2018年8月28日16时08分`开通至今<span id="days"></span>，框架程序使用 Hexo，主题使用 NexT，原托管在腾讯云开发者平台上，现托管于 Github，由CloudXNS 提供 DNS 解析服务。
旧博客地址：<https://moskiller.coding.me>

# 0x01、关于我

&ensp;&ensp;本人八〇后，性别男，爱好女。非典型Coding爱好者一枚，热爱玩游戏、编程，不修边幅，腹肌0~8块，自带文（zhuang）青（bi）气质。
**从1997年开始至今的曼联球迷**
有时文艺，有时严肃，有时逗比。喜欢折腾一些东西，不擅长与人交流。初中开始接触电脑以及编程，自称中级电脑高手高高手。
不喜欢泛娱乐化与历史虚无主义，有时候会回忆起过去的事物。对未来感到彷徨但并不会惧怕。
  

你可以使用下面的方式找到我：  

邮箱： <span class="heimu" title="你知道的太多了，哼哼哼"> admin$vincent.ga  //请自行将 $ 符号换回 @ 符号 </span>
  
  

 


# 0x02 版权声明

&emsp;本博客内的所有原创内容（包括但不限于文章、图像等）除特别声明外均采用知识共享署名-非商业性使用-相同方式共享 4.0 国际 (CC BY-NC-SA 4.0) 许可协议，任何人都可以自由传播，但不得用于商用且必须署名并以相同方式分享。

&emsp;本站部分内容转载于网络Network，有出处的已在文中署名作者并附加原文链接，出处已不可寻的皆已标注来源于网络。若您认为本博客有部分内容侵犯了您的权益，请在评论区留言或电邮告知，我将认真处理。
  
<script>
function show_date_time(){
window.setTimeout("show_date_time()", 1000);
BirthDay=new Date("08/28/2018 16:08:00");
today=new Date();
timeold=(today.getTime()-BirthDay.getTime());
sectimeold=timeold/1000
secondsold=Math.floor(sectimeold);
msPerDay=24*60*60*1000
e_daysold=timeold/msPerDay
daysold=Math.floor(e_daysold);
e_hrsold=(e_daysold-daysold)*24;
hrsold=setzero(Math.floor(e_hrsold));
e_minsold=(e_hrsold-hrsold)*60;
minsold=setzero(Math.floor((e_hrsold-hrsold)*60));
seconds=setzero(Math.floor((e_minsold-minsold)*60));
document.getElementById('days').innerHTML="已运行了 "+daysold+" 天 "+hrsold+" 小时 "+minsold+" 分 "+seconds+" 秒";
}
function setzero(i){
if (i<10)
{i="0" + i};
return i;
}
show_date_time();
</script>