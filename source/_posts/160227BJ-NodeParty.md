title: 北京2月27号NodeParty
date: 2016-03-06 10:16:58
tags: ['nodejs','方法记录','成长']
categories: 交流分享
---
第一次参加cnode社区的技术交流分享会，感触良多。

### 物联网
这一次的分享，有两个topic，第一个是关于物联网的，由现就职于Microduino的陈昊前辈带来的《How Arduino is open-sourcing imagination》分享，一个小时的时间里，向我们介绍了物联网以及他是如何一步一步的深入物联网这个领域，分享了他所在公司做的一些很酷的事情以及一些项目的基本实现，还带了一些成品demo，大开眼界。这个我未曾接触的新新领域->物联网，于我来说像打开了一扇新世界的大门一样，思考了很多。这个软硬件结合的领域里，感觉更加能够深入到生活的点滴之中，能够帮助人们解决很多实际性的问题，就比如Microduino他们的《秃鹫蛋》项目，在条件苛刻的环境之下，完成了一款坚持40+天记录秃鹫蛋各种参数的`蛋`作品，切实的帮助了科学家们的研究。在我看来，物联网这个领域重要程度不会低于互联网太多，在将来，能够更直观的改善人们生活的，一定会有物联网的一席之地。


### 架构经验分享

第二个topic来自百度前员工现XLegal架构师的王啸，主要分享总结了他在项目初期遇到的一些坑以及自己总结的一套项目经验，都是实打实的干货啊。分析了项目中的技术债是怎么起源的，并且用了一个对于咱们程序员来说十分写实的例子来讲述这个故事，真是听得滋滋有味的..这个故事也让我重温了曾经看到过的一句话：“同样的代码出现第二次，咱们就该停下想想，想想自己代码是不是出现了什么问题，需要如何优化”。粘贴、复制真不是什么程序员，更多的像是打字员？不能自我学习、自我总结提高的程序员，一辈子也就只是个普普通通的程序员..还有一点灰常干，就是不要随便引入第三方库，在我后端来说，一般的工具库我都会参考源码之后来抉择如何引入，太重的，采取剥离的方法。这一点让我想起在和keep的小星星@NSWBMW聊过之后受到的最大启发之一，项目引入的第三方库的版本号一定要是一个确定的数字，否则各版本之间的接口差别真可能让人调试的崩溃的，并且给我推荐了一个用于自动升级依赖包的库-> npm-check-updates，酷酷的，我也要这么做~
王啸前辈关于这些经验的总结也挺棒的，

1. 按重要性设计方案，参考紧急程度考虑实现顺序
2. 技术债由非功能性需求产生，被功能实现掩藏，务必警惕其造成的减速效应
3. 非功能性需求的完善，会将项目导入加速曲线
4. 项目初期技术方案，应尽可能以撑过长期为目标
5. 项目迭代的过程，最终一定会导向自有的技术方案



### Thinking


这次的技术分享会也有和很厉害的人交流，比如卡耐基梅隆大学海龟的@罗诗亚，给我讲了好多关于3D技术方面的东西，告诉我了一些新东西，比如我都不怎么了解的3Dweb技术方向的程序员，关系到比较深入的算法方向，了解了硅谷程序员基本都是要考算法的，真爽啊，爽的浑身冒气那种，感觉要在算法方面去战斗了！

程序员这个群体来说，大多数人其实都挺内向的，比如我自己..特别是在大伙吃晚饭的时候，这气氛真是让我biubiubiu...一会大伙都聊得兴起，一会全桌子十多个人鸦雀无声..这就是他人眼中呆萌的技术宅嘛- -


