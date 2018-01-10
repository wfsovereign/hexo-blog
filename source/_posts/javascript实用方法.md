title: Javascript实用方法
date: 2015-11-15 15:31:50
tags: ['javascript','方法记录','成长']
categories: javascript
---


这篇我主要记录一些在工作中常用的、实用的方法。


### String

#### trim

字符串方法中的trim主要用来去空格使用，很多时候，在后台做参数处理的时候，我们都会使用该方法，比如在获取用户输入的账户时

```js
var a = String(' 1234         ');
var b = "hello world";

console.log(b.trim()); //hello world
console.log(a.trim()); //1234
console.log(a); // 1234         
```

以上，可以看出，trim方法去掉的是两头的空格，对中间的空格并不会产生影响。值得注意的是，trim方法，返回的是一个新的字符串，对原来的变量没有影响。

#### slice

slice方法用于切割字符串，用到的地方挺多的，比如在处理文件流的时候，我们就可以用slice来切割，当然，大多时候，也就仅仅是对字符串做一个简单处理

```js
var b = "hello world, I like you";

console.log(b.slice(13)); //I like you
console.log(b.slice(15,20)); //like
console.log(b.slice(15,-4)); //like
console.log(b); //hello world, I like you
```

slice方法，支持传入两个参数，开始位置与结束位置，传入负数时，代表此次计数从末尾开始。

#### split

split方法用于将字符串分组存放，是常用的方法之一。能够让我们对分组好的字符串进行分组操作

```js
var b = "hello world, I like you, and you?";

console.log(b.split()); //[ 'hello world, I like you, and you?' ]
console.log(b.split('')); //["h","e","l","l","o"," ","w","o","r","l","d",","," ","I",
" ","l","i","k","e"," ","y","o","u",","," ","a","n","d"," ","y","o","u","?"]
console.log(b.split(' ')); //[ 'hello', 'world,', 'I', 'like', 'you,', 'and', 'you?' ]
console.log(b.split(' ',3)); //[ 'hello', 'world,', 'I' ]
```

以空字符分组的时候，会将字符串按每一个字符来分组，这点很实用，可以按字符分组，想想都会觉得程序的世界也是鸟语花香啊～

#### substr、substring

都是用来截取字符串的，substr方法，支持传入两个参数，一个是开始位置，一个是截取长度，而substring的两个参数一个是开始位置，一个是结束位置

```js
var b = "hello world, I like you, and you?";

console.log(b.substr()); //hello world, I like you, and you?
console.log(b.substr(13,10)); //I like you
console.log(b.substring(15,-9)); //hello world, I
console.log(b.substring(15,-1)); //hello world, I
```

由此可见，substr、substring和slice这三者来说，各有所长(╯°O°)╯┻━┻
你能体会么～不能体会的就留个言咯

### Array

#### filter

filter能够按一定条件筛选出满足条件的数据，比如在后台处理mongdb的id时，前台传过来的id必须得满足id.trim().length === 24

```js
var b = [ 'hello', 'world,', 'I', 'like', 'you,', 'and', 'you?' ];

console.log(b.filter(function (item){
    return item.length < 5;
}));  //[ 'I', 'like', 'you,', 'and', 'you?' ]
```

#### concat

concat方法能够将多个数组组合成一个数组，这在异步处理数据最后进行组装的时候特别有用

``` js
var b = [ 'hello', 'world,', 'I', 'like'];
var a = [ 'you,', 'and', 'you?' ];
var c = [[1],[2]];

console.log(b.concat(a)); //[ 'hello', 'world,', 'I', 'like', 'you,', 'and', 'you?' ]
console.log(b.concat(a).concat(c)); //[ 'hello', 'world,', 'I', 'like', 'you,', 'and', 'you?', [ 1 ], [ 2 ] ]
```

很多时候，在最后处理数据的时候，这种数组中嵌套了数组的情况是比较烦的，不过很简单，underscore有方法能够轻松解决它，你知道吗？(๑•́ ₃ •̀๑)

#### forEach

forEach应该是用的最多的方法了吧，它的作用就是遍历数组中的每一个值，然后你就可以对每一个值进行操作了

```js
var b = ['hello', 'world,', 'I', 'like', 'you,', 'and', 'you?'];

b.forEach(function (ele, index) {
    ele = ele + 1;
});
console.log(b); //[ 'hello', 'world,', 'I', 'like', 'you,', 'and', 'you?' ]
```

关于forEach，更准确的说对于Javascript中的对象，我一直觉得自己的理解已经够解决遇到的一般问题了，但是这个forEach还是给我带来了难题。比如上面这个，我对ele进行改变之后，b数组并没有按照我想象中的改变，结果是一成不变。而在在我的经历中，forEach中对遍历的值进行改变，它最终的结果使能够被改变的。因此，在这个变与不变之间，我没有找到一条清晰的分界线...

#### map

说了forEach怎么可以没有map，同是遍历数组中的每一个值，map能够将对这些值的操作进行返回为一个新的数组

```js
var b = ['hello', 'world,', 'I', 'like', 'you,', 'and', 'you?'];

console.log(b.map(function (ele){
    ele = ele + 1;
    return ele;
})); //[ 'hello1', 'world,1', 'I1', 'like1', 'you,1', 'and1', 'you?1' ]
```

#### reduce

再说说这个reduce吧，reduce方法遍历数组的每一个值，操作自己定，最后返回一个做了这些累积操作的值，常用来算和吧，实用的呢，它能够产生比filter更强力的功效，这个自己体会吧～

```js
var summary = [1, 2, 3, 4, 5, 6, 7, 8, 9];
console.log(summary.reduce(function (pre, cur) {
    pre += cur;
    return pre;
}, 0)); //45
```

今天就先写这么多吧，细水长流～

你可以很厉害，也可以很坚强，baby～





