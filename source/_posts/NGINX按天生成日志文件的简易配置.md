---
title: NGINX按天生成日志文件的简易配置
date: 2018-05-10 17:45:27
tags: ['成长', '总结', 'NGINX']
categories: 经历
thumbnail: /thumbnail/nginx.png
banner: /thumbnail/nginx.png
---


### 0x01

  最近后端童鞋遇到一个小需求，拆分nginx生成的log文件，最好是按天生成，看着她还有很多bug待改的状态，我说这个简单啊，我来吧。曾经搞node后端的时候，这些东西都so easy的，我还记得当时用log4js，几行配置文件就能搞定，现在就算是直接配置nginx应该也不会特别麻烦。
  
### 0x02

  先说一下项目的大概架构。整个项目采用docker部署，一共三个container，一个getaway负责整个服务的网络转发，然后就是一个backend和frontend的container。frontend跑在一个nginx镜像中，对应的nginx.conf在frontend repo修改，我们将要操作的也就是这个配置文件。
  <!-- more -->
  通过Google，我们能够很容易的找到相关的解决办法，关键字搜索，"nginx generate log file by date"，我们能够很容易的找到解决方案：使用map定义一个时间结构，并且在access_log的配置名中加上这个结构，类似下面这样，
  
 > nginx.conf
 
 ```javascript
 map $time_iso8601 $logdate {
          '~^(?<ymd>\d{4}-\d{2}-\d{2})'   $ymd;
          default                         'nodate';
    }
    
 access_log  '/var/log/nginx/access_${logdate}.log'
 ```
 
### 0x03

不过吧，上面这种方式居然不起作用，还导致nginx不再记录log文件。好吧，英文的不行，我们看看中文的，关键字搜索，"nginx log文件按天生成"， 搜出来一大堆内容差不多的blog，比如，

![](/images/nginx-chinese-search-result.png)


内容大同小异，自己写shell脚本去迁移日志，或者就再加个crontab添加个定时任务的。这种自己写脚本去迁移日志的，就太重了，与我理想的几行配置搞定的初衷不符。

### 0x04

怎么办呢，我这么不喜欢麻烦的人，那我们还是回到上一个解决办法再瞧瞧吧。现在来想一想，为什么我们像[0x02](#user-content-0x02)那样的解决办法不行，会导致整个nginx没有记录log了呢？container运行正常，服务能够正常访问，但就是没有记录日志，可以排除nginx.conf配置语法错误，因为语法错误会导致nginx启动不了，也就是nginx运行正常，那些没有日志的产生，是不是没有"write"的权限呢？下面我们要做的就是

> docker exec -it frontendContainerId sh

进入到frontend container中，使用"chown"、"chgrp"把对应日志文件目录的用户和用户组改成nginx。好的，接下来，重启container，访问对应服务，在日志文件夹下面，我们看到了新生成的带日期的文件名的日志文件！


ps: 解决问题就是这么简单流畅，如风少年~


