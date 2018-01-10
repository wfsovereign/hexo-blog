title: 重构老项目所悟
date: 2017-01-04 21:39:54
tags: ['重构', 'refactor', '方法记录', '成长']
categories: 术
thumbnail: /thumbnail/keyboard.jpg
banner: /thumbnail/keyboard.jpg
---


## 0x01

6月份的那个时候，刚进ThoughtWorks不久，工作上也没有太多的事情，然后就天真的以为在骚窝的节奏应该一直就是这样的吧，所以，便给接下来的几个月定了一些小目标，其中就包括整理github已提交代码，因为github上的东西真的太老了。可没想到接下来的几个项目以及北京Nodejs社区的事情让我基本没啥时间来做这些小目标了..

前两天，正好前端入门级的朋友来找我取经，我就在我的repo里面找了一个能跑起来且适合他的[项目](https://github.com/wfsovereign/pos-jquery)推荐给他。虽然我将这个[项目](https://github.com/wfsovereign/pos-jquery)给他了，可这样的项目拿出去我是会脸红的，所以改造开始了..


## 0x02

首先，我加上了README。README基本的功能是告诉来访者这个项目做了什么，以及如何工作的。当然一个比较完善的README一般会包括如下部分：

* Installation
* Example/Usage/Quickstart/Getting Started
* Features
* FAQ
* API References/Docs/Community
* Tests
* contributing
* contributors
* License

<!-- more -->

差不多就这些了，然后剩下的一般是专属该项目的部分了。

有了README之后，发现这个项目还没有.gitignore！gitignore可是保证项目干净的利器啊，于是立马给加上了。gitignore怎么用，已经写过[一篇文](http://wfsovereign.github.io/2014/12/26/ignore%E6%96%87%E4%BB%B6%E7%9A%84%E5%88%9B%E5%BB%BA%E4%B8%8E%E4%BD%BF%E7%94%A8/)大概介绍了，有兴趣可以看看。这里，我再说说，项目里面，一般什么东西是不应该被push的。中心思想就是，项目的外部依赖库都是不应该被push到repository的。为什么呢？因为这种外部依赖库都是与我们项目没有关系的独立库，我们可以把它们看作是工具库里面的一种工具，我们的项目只是使用了该工具，但是这个工具的源代码跟咱们项目的源代码是不应该在一个代码仓库的。正好，我这次重构的项目就是一个很好的例子。在这个项目里面的dist文件夹里面有着Bootstrap和jQuery的源码，他们是应该被提交到这里的。那么我们应该怎么做呢？方法比较多，这里介绍两个。第一个，我们现在的npm库很强大了，基本该有的都有了，Bootstrap和jQuery都有，我们可以通过npm安装它们，然后在需要用到的地方引用。第二，不想用npm，当然也可以用bower这样的工具来下载，这东西主要就是Web端的包管理工具，bower install 下载的package默认会安装在bower_components文件夹下面，当然我们也可以通过.bowerrc文件来指定安装的目录。不过，在npm一统天下的今天，bower使用的场景真是越来越少了。ok，我们来总结一下哪些文件是gitignore的常客吧。

* node_modules 

> 这个就不多做解释了，里面都是外部依赖库

* dist/build

> 这个一般是打包之后的资源文件夹，对于前端项目来说，这个文件夹内的东西一般是可以直接丢到Nginx里被代理了。

* coverage

> 这个一般是在运行项目测试覆盖率的时候生成的文件夹，在里面我们能看到整个项目和各个文件的测试覆盖率。

* log/*.log

> 这里一般是项目运行时记录的日志文件


* typings

> 该文件夹为我们在使用typescript的时候所需要的各种类型的声明的地方。


## 0x03

接下来就是源代码了。代码，在可用的前提下首先应该是整洁干净的，这样才会让自己写的舒心，让他人看的省心。所以，我清理了注释代码，无效的文件以及debug的console。接下来，就是代码质量了。毕竟过去快两年了，看当年的东西觉得到处都是问题。

我们先来看一段代码，

```javascript

function judge_exist_barcode(item, promote) {
  var judge_bar;
  _.each(promote, function (pro) {
    judge_bar = _.find(pro.barcodes, function (p) {
      if (p == item.barcode) {
        return p;
      }
    });
  });
  return judge_bar != undefined
}

```

问题挺多的，咱一个一个的看。

### 函数名

首先，这个函数的名字是judge_exist_barcode，然后看到返回值是一个Boolean值，再结合两个参数可以判断出这个方法的主要功能是要判断传入的参数的barcode是否能在另一个对象中找到。当一个函数的返回值或者变量的值的类型是Boolean的时候，我们一般倾向于用 **is**、**has**、**should**等词来开头，因为这样更表意，比如，如果把这里的judge如果换成has是不是就更好了。最后我们在根据函数的功能给它取一个新的名字，**has_promotional_barcode**，这个名字是不是就棒多了啊 ：）

### 逻辑

这里的代码逻辑比较简单，一眼就能看出来是做了什么。首先，promote是一个可迭代对象，使用underscore的each方法遍历promote，然后在promote的每一个子对象的barcodes中查找是否有和传入参数对象item的barcode相等的值，如果有，就给预先定义好的一个标识judge_bar赋值。那么，一句话总结一下这个功能，查询item对象的barcode是否有在promote的子对象的barcodes中出现。清楚了逻辑之后，再看看代码，便知道这个judge_bar变量名是一定有问题的，然后再看看each和find方法，能够看出作为新手对underscore/lodash提供的接口不够了解。

> ps: 所以，这里我建议，刚接触这个工具库的朋友可以先把他们的文档快速、完整的浏览一遍，大概知道了它提供了哪些工具方法，这样在工作中遇到也能够快速查文档来使用。这里我推荐使用[Lodash](https://lodash.com/docs/4.17.4)，为什么呢？因为lodash在一定程度上有更优秀的性能，提供更多的工具和更快的更新，如果你想了解更多，可以自己尝试测试他们，或者来[这里](http://stackoverflow.com/questions/13789618/differences-between-lodash-and-underscore)找找答案。

查询一个值是否存在于另一个对象中我们可以用_.some或者_.includes，前者是对可迭代对象的子对象进行匹配校验，用于对象之类的匹配或者key值校验，支持identity function；后者也是对可迭代对象的子元素进行校验，不支持identity，用于value值校验。再加上我们对context的理解，原代码就能够重构成这样

```javascript

function has_promotional_barcode(item, promotions) {
  return _.some(promotions, function (promotion) {
      return _.include(promotion.barcodes, item.barcode);
  });
}

```

首先，行数的缩减是最直观的感受，其次，语义上没有损失，可以像阅读课文一样容易的来理解。那么，重构到这里就结束了吗？


## 0x04

重构其实才刚刚开始。正确的重构方式，应该是先为现有代码加上测试。这样，我们才能够安心的去重构，不必担心因为自己的重构而导致代码的行为与之前的有不一致情况。所以，前面提到过的[TDD](http://www.cnblogs.com/wfsovereign/p/4198209.html)，不就可以抓起来了嘛 ：）



> ps: 新年新气象[Yeah!]
