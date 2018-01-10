title: ignore文件的创建与使用
date: 2014-12-26 15:39
tags: [git,ignore]
categories: git 
---

在我们使用github提交本地代码时，有些库文件和日志文件是不必要提交的，那如何处理这个问题呢？这个时候我们就会用到.gitignore文件了。这里我会介绍如何创建.gitignore，以及如何处理已提交的不必要的项目文件。此次工作环境是基于ubuntu14.04。

### 创建
首先,.gitignore文件应该是创建在你的项目的根目录下面的，你可以使用

> vim .gitignore 


或者是


> gedit .gitignore
 

例如我的一个.gitignore文件如下:


    node_modules 
    dist
    .tmp
    bower_components
    test
    public


这些文件都是库文件以及自动生成的模块，都是不必要提交的。下面我会讲一个关于已提交不必要文件的处理。

### 对已提交不必要文件的处理方法
有时候当我们明白这个gitignore之后才发现我们已经提交不必要的文件了，而自己又是一个较完美主义者，不愿意让那些文件存在我们库里，该怎么做呢？有什么办法吗？办法肯定是有的。

那么我们现在预设的问题模型是：项目文件里有一个node_modules文件，该文件是存储自动生成的模型的文件，然后我已经把这个文件提交到github库里了，现在我明白了这个道里过后想删掉它并且以后都不再提交它。处理的方法：首先，我们再终端进入项目的根文件下面，创建.gitignore文件，并且添加需要忽略提交的文件，如上面我的一个.gitignore文件，然后输入如下命令

> git rm -r --cached node_modules（要删除的文件名）


然后再

> git push


最后我们去我们的github的库里去就会发现刚刚删除的东西已经成功删除啦~


 