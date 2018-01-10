title: 浅析javascript原型与对象
date: 2015-02-06 14:24
tags: [javascript,原型,对象]
categories: javascript
---


在我学习与使用javascript三个月中，我一直对javascript的继承关系以及prototype理解不清，导致很多时候为什么这么用说不出个所以然来。截止到本周为止，通过之前的学习以及自己的再学习，自我感觉算是对这一块有了较为清晰的认识，此文将谈谈我对javascript原型与继承的理解，在此之前，我们首先要知道一些基本的知识。 

知识铺垫
-------------   
### 1、数据类型

JavaScript中的数据类型在曾经我也有提到过，它包括未定义值（undefined），空值（null），布尔值（boolean），数字（number），字符串（string）以及对象（object），而对象中又包含特殊对象数组（array），并且函数也是对象。其中，字符串（string），对象（object）等都是由构造函数来实现的。讲到这里又得说说JavaScript中的函数了。

### 2、函数

就我所知的语言都是有函数这个概念的，所以就不再细说。在 JavaScript 中函数也是一个对象，那么对象又是通过什么来创建的呢？对象是作为现有示例（即原型）对象的副本而创建的，该名称就来自于这一概念，此原型对象的任何属性和方法都将显示为从原型的构造函数创建的对象的属性和方法。可以说，这些对象从其原型继承了属性和方法。

普通的函数与构造函数在JavaScript中都是通过function来创建，不同的是构造函数需要通过大写来标明。例如：

```
function Person(name, age, sex) {
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.say = function () {
        console.log('my name is ' + this.name + ",I'm " + this.age)
    }
}

Person.say_hello = function () {
    console.log("Hello,I'm" + this.sex)
};

Person.prototype.is_alive = function () {
    return true
};

var wfsovereign = new Person('wfsovereign', 21, "boy");

wfsovereign.say();  //output my name is wfsovereign,I'm 21
console.log(wfsovereign.is_alive());     //output true
console.log(wfsovereign.say_hello(), "----");    //output undefined
```

此例中，创建了构造函数Person，接受参数为name，age，拥有静态方法say_hello（），实例方法say（）和is_alive（），使用构造函数创建实例对象wfsovereign，能够调用实例方法，调用静态方法时提示未定义。

在构造函数后通过"."来添加的方法或属性，称之为静态方法或静态属性，这是实例之后的对象不能访问的。因此，我们通过wfsovereign调用say_hello（）时才会提示undefined。

那么，我们写在构造函数的prototype上的方法is_alive（）为什么实例过后仍然能够被访问呢？这个问题我们先放放，先来看看实例对象与构造函数间的联系，通过控制台，我们输出

	console.log(wfsovereign.prototype);
	console.log(wfsovereign.__proto__);
	console.log(wfsovereign.constructor);
可以看到

```
undefined    //wfsovereign.prototype
Person{
    is_alive: function(){}
}    //wfsovereign.__proto__)
{
    constructor: function Person(name, age, sex) {
        is_alive: function () {
            __proto__: Object
            function Person(name, age, sex) {   //wfsovereign.constructor
                this.name = name;
                this.age = age;
                this.sex = sex;
                this.say = function () {
                    console.log('my name is ' + this.name + ",I'm " + this.age)
                }
            }
        }
    }
}
```

可以看到，实例对象wfsovereign没有prototype属性，但是有了指向构造函数Person.prototype的__proto__属性以及指向构造函数的constructor属性，而Person这一构造函数也有指向object的__proto__属性，说明Person也是通过object创建的一个实例。这个时候我相信聪明如你就能回答上面提出的问题了—我们写在构造函数的prototype上的方法is_alive（）为什么实例过后仍然能够被访问呢？

由此，我们得出，创建的每一个函数都有prototype属性，这是一个指针，它指向一个对象，这个对象的用途是包含可以由特定类型的所有实例共享的属性和方法。也就是说prototype是通过调用构造函数而创建的那个对象实例的原型对象，并且只有函数才有prototype属性，实例的对象没有该属性，即这里用Person创建的实例wfsovereign是没有prototype这一属性的。

当使用构造函数（Person）创建一个实例（wfsovereign）的时候，实例内部将包含一个内部指针（__proto__)指向构造函数的prototype，这个连接存在于实例和构造函数的prototype之间，而不是实例与构造函数之间，实例与构造函数之间通过constructor连接。知道了prototype是什么和怎么来的之后，我们再来看JavaScript的原型链就容易多了。

继承与原型链
---
### 1、原型链的理解

JavaScript 不包含传统的类继承模型，而是使用 prototype 原型模型。在JavaScript中，一共有两种类型的值,原始值和对象值。每个对象都有一个内部属性 prototype ,我们通常称之为原型。原型的值可以是一个对象，也可以是null。如果它的值是一个对象，则这个对象也一定有自己的原型。当从一个对象那里调取属性或方法时，如果该对象自身不存在这样的属性或方法，就会自己去关联的prototype对象那里寻找，如果prototype没有，就会去关联的创造者那里找，直到prototype为undefined为止，Object的prototype就是undefined即所有原型都终止于 Object.prototype，这样就形成了一条线性的链，我们称之为原型链。JavaScript正是通过原型链来调用关联创造者的属性与方法的即继承。

### 2、使用原型的好处

可以让对象实例共享它所包含的属性和方法。也就是说，不必在构造函数中添加定义对象信息，而是可以直接将这些信息添加到原型中，通过指针引用的方式来调用。使用构造函数的主要问题就是每个方法都要在每个实例中创建一遍。

　　
