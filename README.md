# flutter_slide_done

[![License](https://img.shields.io/badge/license-MIT-green.svg)](/LICENSE)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://stackoverflow.com/questions/tagged/flutter?sort=votes)
[![Pub](https://img.shields.io/badge/pub-v0.0.1-orange.svg)](https://pub.dartlang.org/packages/flutter_slide_done)

## [English](https://github.com/xuelongqy/flutter_slide_done/blob/master/README_EN.md) | 中文

SlideDone的灵感来源于滑动解锁，可以将它定义为滑动开关，可以单向也可以双向。你可以自定义SlideDone的参数，让它变成你想要的样子。

## 特点功能:

 - 支持滑动触发事件
 - 支持主动触发事件
 - 支持自定义样式
 - 支持单向与双向，初始化默认位置

## Demo
[下载 APK-Demo](https://github.com/xuelongqy/flutter_slide_done/raw/master/art/pkg/SlideDone.apk)

![](https://github.com/xuelongqy/flutter_slide_done/raw/master/art/image/apk_QRCode.png)

## 项目演示
|Example|
|:---:|
|![](https://raw.githubusercontent.com/xuelongqy/flutter_slide_done/master/art/image/snipaste_index.png)|
|[main.dart](https://github.com/xuelongqy/flutter_slide_done/blob/master/example/lib/main.dart)|

## 简单用例
#### 1.在 pubspec.yaml 中添加依赖
```
//pub方式
dependencies:
  flutter_slide_done: ^0.0.1

//导入方式
dependencies:
  flutter_slide_done:
    path: 项目路径
```
#### 2.在布局文件中添加 SlideDone
```dart
import 'package:flutter_slide_done/slide_done.dart';
....
  GlobalKey<SlideDoneState> slideDoneKey = new GlobalKey<SlideDoneState>();
....
  SlideDone(
    key: slideDoneKey,
    onStart: () async {
      await Future.delayed(Duration(seconds: 2), (){});
    },
    onEnd: () async {
      await Future.delayed(Duration(seconds: 2), (){});
    },
  ),
```
#### 3.触发动作
```dart
  // 如果不需要可以不用设置SlideDone的key
  slideDoneKey.currentState.callOnStart();
  slideDoneKey.currentState.callOnEnd();
```

# 捐赠
如果你喜欢我的项目，请在项目右上角 "Star" 一下。你的支持是我最大的鼓励！ ^_^
你也还可以扫描下面的二维码，或者通过[![Donate to this project using Paypal](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=334PPRBZTY3J8&source=url)，对作者进行打赏。  

![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_alipay.jpg?raw=true) ![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_wxpay.jpg?raw=true) ![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_tencent.jpg?raw=true)

如果在捐赠留言中备注名称，将会被记录到列表中~ 如果你也是github开源作者，捐赠时可以留下github项目地址或者个人主页地址，链接将会被添加到列表中起到互相推广的作用  
[捐赠列表](https://github.com/xuelongqy/donation/blob/master/flutter_slide_done.md)

### QQ讨论群 - 554981921
#### 进群须知
这个群不仅仅是解决SlideDone的问题，任何Flutter相关的问题都可以进行讨论。正如它的名字一样，有问必答，只要群主有时间，都会帮大家一起解决问题。

## 开源协议
 
```
 
MIT License

Copyright (c) 2018 xuelongqy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

 
 ```
