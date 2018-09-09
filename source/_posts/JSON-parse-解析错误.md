---
title: JSON parse 解析错误
date: 2018-09-09 20:41:32
tags: ['javascript','方法记录','成长']
categories: javascript
thumbnail: /thumbnail/programmer.jpg
banner: /thumbnail/programmer.jpg
---

### 0x01

最近在做一个小爬虫，爬去淘宝特定商品数据，页面数据异步加载，还好在返回的数据中看到了配置数据（page_config），那么剩下的问题就是字符串截取、json解析了，问题也就正好出在json解析上。

<!-- more -->


### 0x02

我们先看看返回的数据大概长啥样吧，很长，放一段，

>...
>
>"traceData":{"filterid":"filter_ershou"},"isHighlight":false,"pos":0,"dom_id":"filter_ershou"},{"isActive":false,"value":"tmall","title":"天猫","key":"filter_tianmao","trace":"filterbox","traceData":{"filterid":"filter_tianmao"},"isHighlight":false,"pos":0,"dom_id":"filter_tianmao"},{"isActive":false,"value":"1","title":"正品保障","key":"user_type","trace":"filterbox","traceData":{"filterid":"filterProtectionQuality"},"isHighlight":false,"pos":0,"dom_id":"filterProtectionQuality"},{"isActive":false,"value":"4806","title":"7+天内退货","key":"auction_tag[]","trace":"filterbox",
>
>...
>
>19900:2000\",\"ADGTITLE\":\"\\u4EBA\\u9645\\u4EA4\\u5F80\\u5FC3\\u7406\\u5B66\\u4E66\\u7C4D\\u7545\\u9500\\u4E66\\u4E3A\\u4EBA\\u5904\\u4E8B\\u6C9F\\u901A\\u8BFB\\u5FC3\\u672F\\u5FC3\\u7406\\u5B66\\u5165\\u95E8\\u60C5\\u5546\\u4E66\\u7C4D\\u53E3\\u624D\\u8BAD\\u7EC3\\u6C9F\\u901A\\u9752\\u6625\\u52B1\\u5FD7\\u8425\\u9500\\u9500\\u552E\\u6280\\u5DE7\\u7C7B\\u4E66\\u7C4D\\u7545\\u9500\\u4E66\\u7BA1\\u7406\\u8BF4\\u8BDD\\u6280\\u5DE7\\u7684\\u4E66\",\"DESC\":\"\",\"ISHK\":\"0\",\"COUPON_TAG_ID\":\"47776002 0\",\"SSPUID\":\"0\",\"ISGLOBAL\":\"0\",\"RESOURCEID\":\"547668928452\",\"SHOPNAME\":\"\\u4E07\\u4F17\\u5174\\u90A6\\u56FE\\u4E66\\u4E13\\u8425\\u5E97\"
>
>...

这个json中存在Unicode字符，尝试过直接解析，报错如下：

> Uncaught SyntaxError: Unexpected token i in JSON at position 8672

那么我就想是不是Unicode导致不能解析，所以，先就Unicode字符进行解析，

```javascript
function decode(s) {
  return decodeURIComponent(s.replace(/\\(u[0-9a-fA-F]{4})/gm, '%$1'));
}
```

结果还是报错了，

> Uncaught URIError: URI malformed

我们知道，**decodeURIComponent**解析的时候，“**%**”经常就是罪魁祸首，那么尝试将它给干掉呢，反正它对我们想要的结果没什么影响，

```javascript
function decode(s) {
  return decodeURIComponent(s.replace(/%/g, '').replace(/\\(u[0-9a-fA-F]{4})/gm, '%$1'));
}
```

这样我们拿到的结果看起来好像是没什么问题了，那我们直接就**Object.parse**试试，报错如下，

> Uncaught SyntaxError: Octal escape sequences are not allowed in template strings.

Oh，字符串中出现了八进制，这个就没有什么解决的思路了 - -| 



我们来小结一下，我们对淘宝返回数据进行截取，拿到我们想要的以String形式的配置数据，直接用**Object.parse**解析，发现不是一个规则的JSON字符串，其中有Unicode字符，所以我们尝试对Unicode字符解码，**decodeURIComponent**解析有报错，尝试将**%**干掉再解码，没有问题，最后再**Object.parse**解析又报了八进制的错... 所以我们这条路很难再进行下去了



### 0x03

到此为止，感觉是要换个方法了…因为我们对数据的安全和性能要求不高，所以这个时候**eval**就派上了用场，直接将我们拿到的json字符串丢给它吧..

```javascript
const targetSource = eval("(" + ObjString + ")")
```

这样真的是方便又无脑呢 ：）


##### Reference：

* [JSON](http://www.json.org/json-zh.html)
* [eval](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/eval)
* [URIError](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Errors/Malformed_URI)
* [ECMA](http://www.ecma-international.org/)
