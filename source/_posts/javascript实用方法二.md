title: Javascript实用方法二
date: 2015-12-13 11:54:07
tags: ['javascript','方法记录','成长']
categories: javascript
---


### Object

#### keys

object的keys方法能够获取一个给定对象的所有键（key/属性名）并以数组的形式返回。这个方法可以用于键的筛选、匹配等。

``` javascript
var basket = {
    strawberry: 12,
    banana: 20,
    apple: 30,
    juice: 20
};

console.log(Object.keys(basket)); 
//[ 'strawberry', 'banana', 'apple', 'juice' ]
```

#### create

create方法用于创建一个新的对象，可选参数(proto, [ propertiesObject ])，第一个为原型，比如Array.prototype之类的，第二个为需要给新建对象的一些新属性之类的,这个参数对象的属性名将是新建对象的属性，值则是属性描述符（value、writable、configurable等）。

``` js
var o = Object.create({}, {p: {value: 42}});
var O = Object.create({}, {p: {value: 66, writable: true, enumerable: true}});
console.log(o.p); //42
console.log(O.p); //66
o.p = 20;
O.p = 80;
console.log(o.p); //42
console.log(O.p); //80
```

属性描述符中writable默认为false，因此o.p即便在后来重新赋值也是不能改变其值的，而O.p则能够在后来改变值，此外，create方法proto必须传入相应参数，否则会报错TypeError，当然以上代码在严格模式下也会报错，因为o.p被重写- -

#### assign

assign方法，es6的新特性，支持传参(target, ...sources)，用于将任意多个源对象的键值对添加的目标对象，类似于lodash的assign和underscore的extendOwn方法。

```js
var boy = {handsome: true, rich: true}, girl = {cute: true, hair: 'long'};
var couples = Object.assign({}, boy, girl);

console.log(couples); //{ handsome: true, rich: true, cute: true, hair: 'long' }
```

assign方法常用于框架层面的数据处理，比如你定义了一个client用于发送HTTP请求，使用的时候获取接受到的参数之外自己可能得加上什么默认的属性。


### Number

#### isNaN

Number的isNaN方法用来判断传入值是否是NaN的值，与全局的isNaN方法不同的是它不会强制将传入参数转化为数字类型，只有在参数是真正的数字类型，且值为 NaN 的时候才会返回 true。不过就自己而言全局的isNaN用的多一点，就用来判断字符串是不是只包含数字，

```js
console.log(isNaN('123f')); //true
console.log(isNaN('123')); //true
```

此外，isFinite(value)方法用于判断传入参数是否是有穷数，isInteger(value)方法用于判断传入参数是否是整数。

#### toFixed

toFixed方法用来将数字转化为特定的字符串，支持传入参数（digits），0 < digits <= 20，在转换的时候会自动进行四舍五入以及0补充。

```js 
var cool = 666.666;
console.log(cool.toFixed(1)); //666.7
console.log(cool.toFixed(6)); //666.666000
```

这段时间发生了很多事情，从待了116天的杭州来到北京，开始一段新的工作与生活。不舍、惆怅、激动、兴奋等情绪交织缠绵...七匹狼，认识了其余六狼，很珍惜这段大家一起努力一起嗨皮的日子，尤记得夜爬宝石山，俯瞰西湖，English poor，哈哈哈...

向着梦想，go！baby！
