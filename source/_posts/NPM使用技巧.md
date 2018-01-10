title: NPM使用技巧
date: 2017-04-04 21:53:46
tags: ['npm', '方法记录','成长']
category: npm
thumbnail: thumbnail/npm.jpg
banner: thumbnail/npm.jpg
---


如果你是一个JavaScript系的开发者，一定不会陌生NPM，它既是一个平台，也是一个工具。在这个平台上，我们能够使用其他开发者提供的功能代码，当然我们也能将我们自己代码提交到这里分享给世界上的开发者。

以下记录一些NPM作为工具的一些使用技巧。

<!-- more -->

## npmrc

.npmrc 做为npm的配置文件，它可以定义在多个地方。

* ~/.npmrc 

> 用户根目录，根目录内所有的npm指令都会查询到该配置

* /path/to/npm/npmrc

> npm内建配置文件

* ./.npmrc

> 当前项目根目录，用于配置特定于当前项目的配置

npmrc对我们来说十分有用，我们可以配置例如username、registry、email等信息。 eg:


```
save=true
save-exact=true
email=wfsovereign@outlook.com
username=wfsovereign
registry=https://registry.npm.taobao.org
```

npm最让人头疼的问题之一就是版本号了，这里配置了save和save-exact属性，作用是让我们 `npm install` 指令安装的依赖自动保存在`package.json`文件的`dependencies`中并且让版本号固定。

一些国内的服务器在拉取某些被墙的包的经常会失败或者速度很慢，这个时候我们可以试试[淘宝NPM镜像](https://npm.taobao.org/)(这是一个完整 npmjs.org 镜像，你可以用此代替官方版本(只读)，同步频率目前为 10分钟 一次以保证尽量与官方服务同步)。官方还定制了[cnpm](https://github.com/cnpm/cnpm)，这个看具体情况而定了。比如，我曾经的一个项目，部署在微软的Asure上面，这个服务器感觉被墙的厉害，用官方的npm库下phantomjs的zip文件运气好的话也得下个两三次才能下下来，后来为了解决这个问题尝试了淘宝镜像，不过问题就出在用了cnpm，用cnpm拉的包在本地编译不了，后来换回npm，使用淘宝镜像，一切正常了~


## package.json

`package.json`是项目的配置管理文件，它定义了这个项目所需要的各个依赖模块以及项目的配置信息（名字，版本号，许可证等）。一个最基本的`package.json`必须有`name`和`version`，差不多长这样：

```
{
	"name": "xxx",
	"version": 0.0.0
}
```

我们可以通过`npm init`指令初始化创建一个package.json文件，

```
{
  "name": "test",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "wfsovereign",
  "license": "ISC",
  "devDependencies": {
  },
  "dependencies": {
  }
}

```



下面分属性介绍

#### scripts

`scripts`定义了一些脚本指令的npm命令缩写，通过这些命令我们可以方便的启动项目、进行测试或者拿到一些钩子来做某些指令前预先做的事，

```
"scripts": {
	 "pretest": "echo \"this is pre test\" ", 
	 "test": "echo \"Error: no test specified\"",
	 "posttest": "echo \"this is post test\""
  }
```

当我们执行`npm test`会得到如下输出：

> this is pre test

> test@1.0.0 test 
> echo "Error: no test specified"

> Error: no test specified

> test@1.0.0 posttest 
> echo "this is post test"

> this is post test

通过如上实验，我们能够知道，`prexx`指令是一个预执行指令，`postxx`是一个后置指令，他俩都和`xx`指令强相关。


#### main

`main`指定项目加载的入口文件，默认是根目录的inde.js


#### file

`file`是一个字符串的数组，指定我们发布的包应该包含当前目录的哪些文件，这个在我们发布包的时候很有用，因为开发包里面的文件夹不是都需要发布出去的。当然一下文件是始终会被包含进去的，不论我们是否设置，

* package.json
* README
* CHANGES / CHANGELOG / HISTORY
* LICENSE / LICENCE
* NOTICE
* The file in the "main" field

#### keywords

`keywords`指定了在库中搜索时能够被哪些关键字搜索到，所以一般这个会多写一些项目相关的词在这里，这是一个字符串的数组。

其余属性详情可以查询[官方文档](https://docs.npmjs.com/files/package.json)


## semantic version

关于语义化的版本号，这里不多讲，放一些preference

* [npm semver](https://docs.npmjs.com/misc/semver)
* [Gravatars semver](http://semver.org/lang/zh-CN/)

Nodejs项目中最常见的一些版本标识( *, ~, ^ )，经常忘了它们的含义，这里记录一下：

* `*` 任意版本
* `1.0.0` 安装指定的1.0.0版本

> lodash: 4.7.0 会安装准确的4.7.0到我们的node_module目录

* `~1.0.0` 安装 >= 1.0.0 小于 1.(0 + 1).0的最新版本
* `^1.0.0` 安装 >= 1.0.0 小于 (1 + 1).0.0的最新版本


## package publish

如何发布一个包？

1. `npm addUser` 按照提示输入账号密码，创建一个npm的账号，如果已有账号直接到下一步
2. `npm whoami` 查看当前用户，确认是使用当前用户来发布包
3. `npm publish` 然后就可以直接发布了，当然这个时候可能会出现各种问题，比如你的包和别人的重名了，或者当前的包的版本号已经发布过了等等

说到发布包，这里在记录一些开发包的小技巧。

我们在开发包的时候免不了一些调试，但是这些调试的过程我们并不想它发布又想确保当前的功能是可用的，这个时候有两个办法能够帮助我们来解决这个问题。

* `npm link`

关于`npm link`的详细介绍我们可以看[官网](https://docs.npmjs.com/cli/link)，这里介绍三种用法:

1. 直接在我们开发包的主目录下直接使用，这个时候，相当于我们在npm global的目录下符号链接了当前包。
2. `npm link package-name`， 作用相当于把一个全局安装的包link到了我们当前目录下node_module中。
3. 在`package.json`文件的dependencies中使用如下方式声明，然后就如同使用一个已经正常发布的包一样安装使用就行。

```
"dependencies": {
    "bar": "file:../foo/bar"
  }
```



ps: 继续努力啊，如风少年~
