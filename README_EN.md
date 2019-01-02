# flutter_slide_done

[![License](https://img.shields.io/badge/license-MIT-green.svg)](/LICENSE)
[![Awesome Flutter](https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square)](https://stackoverflow.com/questions/tagged/flutter?sort=votes)
[![Pub](https://img.shields.io/badge/pub-v0.0.1-orange.svg)](https://pub.dartlang.org/packages/flutter_slide_done)

## English | [中文](https://github.com/xuelongqy/flutter_slide_done/blob/master/README.md)

SlideDone is inspired by sliding unlocking, which can be defined as a slide switch that can be unidirectional 
or bidirectional. You can customize the parameters of SlideDone to make it look what you want.

## Features:

 - Support for sliding trigger events
 - Support for active trigger events
 - Support for custom styles
 - Support one-way and two-way, initialize the default location

## Demo
[Download APK-Demo](https://github.com/xuelongqy/flutter_slide_done/raw/master/art/pkg/SlideDone.apk)

![](https://github.com/xuelongqy/flutter_slide_done/raw/master/art/image/apk_QRCode.png)

## Project demonstration
|Example|
|:---:|
|![](https://raw.githubusercontent.com/xuelongqy/flutter_slide_done/master/art/image/snipaste_index.png)
|[main.dart](https://github.com/xuelongqy/flutter_slide_done/blob/master/example/lib/main.dart)|

## Simple use case
#### 1.Add a dependency in pubspec.yaml
```
//pub way
dependencies:
  flutter_slide_done: ^0.0.1

//import way
dependencies:
  flutter_slide_done:
    path: your path
```
#### 2.Add SlideDone to the layout file
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
#### 3.Trigger action
```dart
  // If you don't need it, you don't need to set the key for SlideDone.
  slideDoneKey.currentState.callOnStart();
  slideDoneKey.currentState.callOnEnd();
```

# Donation
If you like my project, please in the upper right corner of the project "Star". Your support is my biggest encouragement! ^_^
You can also scan the qr code below or [![Donate to this project using Paypal](https://img.shields.io/badge/paypal-donate-yellow.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=334PPRBZTY3J8&source=url), donation to Author.

![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_alipay.jpg?raw=true) ![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_wxpay.jpg?raw=true) ![](https://raw.githubusercontent.com/xuelongqy/donation/master/pay_tencent.jpg?raw=true)

If in donation message note name, will be record to the list if you are making open source authors, donation can leave when making project address or personal home page, a link will be added to the list have the effect of promoting each other
(https://github.com/xuelongqy/donation/blob/master/flutter_slide_done.md)

### QQ Group - 554981921
#### Into the group of instructions
The group is not only solve the problem of SlideDone, any Flutter related issues can be discussed.
Just as its name, craigslist, as long as there is time, group of Lord will help you solve problems together.

## Open source licenses
 
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
