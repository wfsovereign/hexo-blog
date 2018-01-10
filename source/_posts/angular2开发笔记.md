title: Angular2开发笔记
date: 2016-06-26 22:32:21
tags: ['typescript','方法记录','成长']
categories: angular2
thumbnail: /thumbnail/angular.png
banner: /thumbnail/angular.png
---


### Problem

1. 使用依赖注入应该注意些什么
2. 服务一般用来做什么
3. 指令一般用来做什么
4. angular2如何提取公共组件
5. angular2为什么不需要提公共组件
6. 父组件与子组件之间如何通讯
7. 什么时候应该使用ngModel
8. 为什么要用Typescript？我喜欢JavaScript
9. 为什么如Input之类的语法后面必须加()

<!-- more -->

### Solution

#### 使用依赖注入应该注意些什么

首先我们要明白什么是依赖注入(Dependency Injection, DI)，Java程序员应该不会陌生，DI是一种编程模式，它让一个类从外部资源中获取它的依赖，而不是自己亲自创建它。这样的好处是什么呢？好处就是我们不必去关心如何创建依赖这个过程，我们只需要舒服的使用这个已经创建好的实例就行。在angular2中使用DI一般是在组件中，注入的东西我们一般称之为service，使用@Injectable()进行标记。在使用DI时需注意在Component中的providers中声明该服务，然后在class中contructor中声明即可，eg:

```javascript
@Component({
    selector: 'source-list',
    styles: require('xxx.scss'),
    template: require('xxx.html'),
    providers: [Regions]
})
export class SourceList {
    constructor(private Region: Regions) {
    }
}	
	
```

此外，若组件的父组件providers中引入了一个service，在其子组件中可不用引入直接在contructor中声明即可；否则会报"not providers..."之类的错误


#### 服务一般用来做什么

服务是什么呢？"Service" is a broad category encompassing any value, function or feature that our application needs. 它可以是值、函数或所需的特性等，一个典型的服务应该是具有专注、良好的定义的类。它应该做一件具体的事情，把它做好。我的理解，服务一般用来与后端通信即获取组件所需数据，或者管理组件特定属性的。

此外，服务的引入是单例的，也就是说你在一个组件中改变了这个服务对象的值，在另一个使用了该服务的组件也会跟随该服务的变化而变化。


#### 指令一般用来做什么

指令一般用来操作DOM，通过在组件的directives中引入，这个引入就是新生成一个实例，他们之间互不影响，这点与服务相反。在我看来，指令大多时候都是按功能封装的一些组件，由父组件来统一使用。

还有另外两种指令，结构型指令与属性型指令。结构型 指令 会通过添加 / 删除 DOM 元素来更改 DOM 树布局。 NgFor 和 NgIf 就是两个最熟悉的例子。属性型指令改变一个元素的外观或行为。


#### angular2如何提取公共组件

angular2框架层面上就对样式进行了隔离，每个组件下属的样式对其他组件不会产生影响。


#### 父组件与子组件之间如何通讯

父组件与子组件：
我一般通过input来实现，在子组件中用Input() 声明从父组件接收的变量，在父组件template使用子组件的地方传递改数据，eg:

*父组件*

```javascript
@Component({
    selector: 'source-list',
    styles: require('xxx.scss'),
    template: `
       <header>
        <nav-header></nav-header>
        <nav-breadcrumb [paths]="paths"></nav-breadcrumb>
       </header>
    `,
    providers: [Regions]
})
export class SourceList {
    constructor(private Region: Regions) {
    }

    path = '/source/list';
}

```

*子组件*

```javascript
@Component({
    selector: 'nav-breadcrumb',
    template: require('./breadcrumb.html')
})
export class NavBreadcrumb {
    constructor() {
    }

    @Input() paths;
}
```


子组件与父组件：
我一般通过借助output和EventEmitter类来实现，通过在子组件中使用@Output()声明该类实例来获得和父组件通信的通道，支持触发事件并将相应数据返回，由父组件在template中使用处进行捕获。eg:

*父组件*

```javascript
@Component({
    selector: 'source-list',
    styles: require('xxx.scss'),
    template: `
       <header>
        <nav-header></nav-header>
        <select-dialog (cancelDialogRequest)="cancelDialog()"></select-dialog>
       </header>
    `,
    providers: [Regions]
})
export class SourceList {
    constructor(private Region: Regions) {
    }

    path = '/source/list';
    cancelDialog() {
    
    }
}

```

*子组件*


```javascript
@Component({
    selector: 'nav-breadcrumb',
    template: require('./breadcrumb.html')
})
export class NavBreadcrumb {
    constructor() {
    }

    @Output() cancelDialogRequest = new EventEmitter();
    @Input() paths;

    cancelDialog() {
        this.cancelDialogRequest.emit(1);
    }
}
```


#### 什么时候应该使用ngModel

ngModel用于数据双向绑定，一般形式为：

```javascript
	<input [(ngModel)]="title">
```

它实际上是：

```javascript
<input [value]="title"
       (input)="title=$event.target.value" >
```

这又是是吗意思呢？我的理解是，[]表示值传递，也就是说这个值是其他地方定义的，这里就是引用了这个值，()表示事件监听，监听在此标签中该值得变化，并将此变化传递会来源的地方。因此，我们可以利用这一特性，将数据传递到子组件中，并在父组件里响应该数据的变化。比如，现在我们在父组件中有一个orders变量，我在父组件的模板中可以这样使用：

```javascript
<delete-order-dialog [(orders)]="orders"></delete-order-dialog>
```

这样，我们在子组件里input该对象，通过一定操作，对orders进行的改变都能传递回父组件，并相应的展示在页面上。




#### 为什么要用Typescript？我喜欢JavaScript

为什么要用typescript啊，我比较喜欢JavaScript这种弱类型的语言，想怎么用就怎么用，从来不需要考虑类型这些什么鬼。不管在什么领域都会有各种群体，就像目前的前端，就有React、Angular、Vue等，这些框架的使用者都很多，我们不能简单的去评判一个框架的优劣及难易程度，因为有些东西就是为特定的人群设计的，比如typescript，Java这种后端程序员使用起来就会顺手很多。嗯，秉持着多学点东西的开放心态，我开始使用spring、typescript了..


#### 为什么如Input之类的语法后面必须加()

关于括号问题，官网其实已经多次提到了，Don't forget the parentheses! Neglecting them leads to an error that's difficult to diagnose. 没有()就会导致不可预料的错误！一定要写。为什么呢？这里我先做个假设，()在JavaScript里，一般都是执行某个函数，那么这里的input()，在我看就是执行了某个函数，标记了后面所跟着的变量，帮助程序运行定位的。


最后安利一波带我的老司机雪狼老大翻译的angular2[中文官网](http://www.angular.live/)

PS：我还是如风少年！
