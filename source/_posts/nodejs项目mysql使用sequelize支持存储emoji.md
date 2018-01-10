title: nodejs项目mysql使用sequelize支持存储emoji
date: 2016-05-01 16:02:08
tags: ['nodejs','方法记录','成长', 'mysql']
categories: nodejs
thumbnail: /thumbnail/emoji.png
banner: /thumbnail/emoji.png
---

本篇主要记录nodejs项目阿里云mysql如何支持存储emoji表情。

### 因由
最近项目遇到用户在文本输入emoji进行存储的时候导致存储失败的问题。经本地调试发现emoji表情在存储时转成的四个字节（\xF0\x9F\x90\xAC）导致sequelize报错，Unhandled rejection SequelizeDatabaseError。由于数据库使用的是utf8字符集utf8_general_ci，这个校对规则（collation）最大只支持3个字节，所以四个字节的emoji就抛异常了...

<!-- more -->

### 扩展
上文提到的`utf8_general_ci`与`ut8_unicode_ci`是utf8的两种字符编码方式，不同之处就是对字符的分类（sorting）和对比（comparison）。

MySQL 5.5.3及以后版本支持使用utf8mb4字符集，它在与utf8数据格式处理性能相同基础上加强了对字符码位（code point）的处理能力。与utf8对应的，utf8mb4有`utf8mb4_unicode_ci `和`utf8mb4_general_ci `。

* utf8mb4_unicode_ci  基于Unicode standard sorting与comparison，支持更多的语言种类。
* utf8mb4_general_ci  不能解析所有的Unicode分类规则，在一些特别的语言或字符处理上存在一定的问题。不过在性能上，它能更快的sorting、comparison，因其采用一组性能相关的快捷方式（performance-related shortcuts）。


### 解决办法
通过上文我们已经知道一种解决办法了，但有一个硬性条件就是你的数据库版本。当你的数据库版本没有达到5.5.3怎么办呢...总结一下，mysql支持存储emoji表情的方法，至少有两种。

1. 修改数据库编码为utf8mb4，前提是你的mysql数据库版本必须得是5.5.3及以后的。
2. 将带emoji的文本转为base64来进行存储，返回时进行相应解码返回（实诚的方法）。

下面介绍我如何使用第一种方法：

- 将数据库编码由utf8改为utf8mb4。

```
set character_set_client      = utf8mb4;                       
set character_set_connection  = utf8mb4;                       
set character_set_database    = utf8mb4;                       
set character_set_results     = utf8mb4;                       
set character_set_server      = utf8mb4; 

```

我们项目用的是阿里的云数据库RDS版，可用其提供的线上管理工具DMS进行设置。

- 将已经生成的表也转成utf8mb4，

```
alter table TABLE_NAME convert to character set utf8mb4 collate utf8mb4_bin; 
```

![](/images/mysql_cli.jpg)

- 更新sequelize的配置，主要更改options。关于sequelize相关配置issue可参看
 
> https://github.com/jsha/blocktogether/issues/66
> https://github.com/sequelize/sequelize/issues/1220

```
options: {
            dialect: "mysql",
            dialectOptions: {
                charset: "utf8mb4",
                collate: "utf8mb4_unicode_ci",
                supportBigNumbers: true,
                bigNumberStrings: true
            }
```


至此，重启你的项目，emoji便能够进行存储啦~


ps: 内心要强大到混蛋啊喂~
