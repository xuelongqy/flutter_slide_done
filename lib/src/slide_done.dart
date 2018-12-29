import 'package:flutter/material.dart';

// 回调类型
typedef Future OnStart();
typedef Future OnEnd();

/// 滑动状态
enum SlideStatus {
  START,
  END
}

/// 滑动完成UI组件
class SlideDone extends StatefulWidget {
  // 宽
  final double width;
  // 高
  final double height;
  // 滑动框形状
  final ShapeBorder shape;
  // 按钮形状
  final ShapeBorder buttonShape;
  // 滑动框高度
  final double elevation;
  // 滑动按钮高度
  final double buttonElevation;
  // 背景颜色
  final Color backgroundColor;
  // 开始颜色
  final Color startColor;
  // 结束颜色
  final Color endColor;
  // 开始图标
  final Widget startIcon;
  // 结束图标
  final Widget endIcon;
  // 开始完成图标
  final Widget startedIcon;
  // 结束完成图标
  final Widget endedIcon;
  // 加载视图
  final Widget startLoadWidget;
  final Widget endLoadWidget;
  // 开始文字
  final Widget startText;
  final Widget startingText;
  final Widget startedText;
  // 结束文字
  final Widget endText;
  final Widget endingText;
  final Widget endedText;
  // 开始和结束回调
  final OnStart onStart;
  final OnEnd onEnd;
  // 初始化状态
  final SlideStatus status;
  // 内边距
  final double padding;
  // 填充视图(滑动时的空白区域)
  final Widget startFillView;
  final Widget endFillView;
  // 完成延时
  final int startedDelay;
  final int endedDelay;

  // 构造函数
  SlideDone({
    Key key,
    this.width = 250.0,
    this.height = 60.0,
    this.shape,
    this.buttonShape,
    this.elevation = 3.0,
    this.buttonElevation = 2.0,
    this.backgroundColor = const Color.fromRGBO(255, 255, 255, 1.0),
    this.startColor = Colors.blue,
    this.endColor = Colors.red,
    this.startIcon,
    this.endIcon,
    this.startedIcon,
    this.endedIcon,
    this.startLoadWidget,
    this.endLoadWidget,
    this.padding = 3.0,
    this.startFillView,
    this.endFillView,
    this.startedDelay = 1000,
    this.endedDelay = 1000,
    this.startText = const Text("Right slide on",
      style: TextStyle(
        fontSize: 20.0
      ),
    ),
    this.startingText = const Text("Turn on...",
      style: TextStyle(
          fontSize: 20.0
      ),
    ),
    this.startedText = const Text("It's done",
      style: TextStyle(
          fontSize: 20.0
      ),
    ),
    this.endText = const Text("Left slide off",
      style: TextStyle(
          fontSize: 20.0
      ),
    ),
    this.endingText = const Text("Turn off...",
      style: TextStyle(
          fontSize: 20.0
      ),
    ),
    this.endedText = const Text("It's done",
      style: TextStyle(
          fontSize: 20.0
      ),
    ),
    this.onStart,
    this.onEnd,
    this.status = SlideStatus.START,
  }): super(key: key);

  @override
  SlideDoneState createState() => SlideDoneState();
}
class SlideDoneState extends State<SlideDone> with TickerProviderStateMixin<SlideDone>{
  // 状态
  SlideStatus _status;
  // 滑动范围
  double _slideRange;
  // 滑动距离
  double _slideDistance;
  // 上一个点
  double _lastOffsetX;
  // 是否怎在加载
  bool _isLoad = false;
  // 是否需要改变状态(用于动画过程中判断)
  bool _isChangeStatus = false;
  // 是否加载结束等待中
  bool _isLoadedWaiting = false;
  // 动画控制
  Animation<double> _animation;
  AnimationController _animationController;

  // 初始化
  @override
  void initState() {
    super.initState();
    _status = widget.status;
    // 初始化范围和距离
    _slideRange = widget.width - widget.height;
    _slideDistance = widget.status == SlideStatus.START ? 0.0 : _slideRange;
    // 初始化滑动归位动画
    _animationController = new AnimationController(duration: const Duration(milliseconds: 250), vsync: this);
    _animation = new Tween(begin: 0.0, end: _slideRange).animate(_animationController)
      ..addListener(() {
        // 判断是左滑还是右滑
        if (_status == SlideStatus.START && _isChangeStatus || _status == SlideStatus.END && !_isChangeStatus) {
          _onSlide(_animation.value);
        }else {
          _onSlide(-_animation.value);
        }
      });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        // 初始化偏移量
        _lastOffsetX = 0.0;
        // 计算是否需要改变状态
        if (_isChangeStatus) return;
        if (_status == SlideStatus.START && _slideDistance > _slideRange - widget.height + widget.padding) {
          _isChangeStatus = true;
        }else if (_status == SlideStatus.END && _slideDistance < widget.height - widget.padding) {
          _isChangeStatus = true;
        }else {
          _isChangeStatus = false;
        }
      }else if (status == AnimationStatus.completed) {
        // 初始化偏移量
        _lastOffsetX = 0.0;
        _animationController.reset();
        // 是否需要触发事件
        if (!_isChangeStatus) return;
        if (_status == SlideStatus.START) {
          // 判断是否滑动到最右端
          _onEnd();
        } else {
          // 判断是否滑动到最左端
          _onStart();
        }
        _isChangeStatus = false;
      }
    });
  }

  // 滑动
  void _onSlide(double offsetX) {
    setState(() {
      _slideDistance += (offsetX - _lastOffsetX);
      if (_slideDistance < 0.0) {
        _slideDistance = 0.0;
      }else if (_slideDistance > _slideRange) {
        _slideDistance = _slideRange;
      }
    });
    _lastOffsetX = offsetX;
  }

  // 触发开始
  void callOnStart() {
    if (_isLoad) return;
    if (_animationController.isAnimating) return;
    if (_status == SlideStatus.START) return;
    _isChangeStatus = true;
    _animationController.forward();
  }

  // 触发结束
  void callOnEnd() {
    if (_isLoad) return;
    if (_animationController.isAnimating) return;
    if (_status == SlideStatus.END) return;
    _isChangeStatus = true;
    _animationController.forward();
    print("sss");
  }

  // 开始
  void _onStart() async {
    if (widget.onStart != null) {
      setState(() {
        _status = SlideStatus.START;
        _isLoad = true;
      });
      await widget.onStart();
      setState(() {
        _isLoad = false;
        _isLoadedWaiting = true;
      });
      // 完成等待延时
      Future.delayed(Duration(milliseconds: widget.startedDelay), () {
        setState(() {
          _isLoadedWaiting = false;
        });
      });
    }else {
      setState(() {
        _status = SlideStatus.START;
        _isLoad = false;
        _isLoadedWaiting = false;
      });
    }
  }

  // 结束
  void _onEnd() async {
    if (widget.onEnd != null) {
      setState(() {
        _status = SlideStatus.END;
        _isLoad = true;
      });
      await widget.onEnd();
      _isLoad = false;
      setState(() {
        _isLoad = false;
        _isLoadedWaiting = true;
      });
      // 完成等待延时
      Future.delayed(Duration(milliseconds: widget.endedDelay), () {
        setState(() {
          _isLoadedWaiting = false;
        });
      });
    }else {
      setState(() {
        _status = SlideStatus.END;
        _isLoad = false;
        _isLoadedWaiting = false;
      });
    }
  }

  // 启动动画
  void _startAnimation() {
    if (!_animationController.isAnimating) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 判断按钮
    Widget icon = _getIcon();
    // 按钮颜色
    Color iconColor = _getIconColor();
    // 开始文字
    Widget startText = _getStartText();
    // 结束文字
    Widget endText = _getEndText();
    return new Card(
      clipBehavior: Clip.hardEdge,
      color: widget.backgroundColor,
      elevation: widget.elevation,
      shape: widget.shape ?? RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(widget.height / 2))
      ),
      child: Container(
        padding: EdgeInsets.all(widget.padding),
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: <Widget>[
            // 结束文字
            new Container(
              width: widget.width - widget.padding * 2,
              height: widget.height - widget.padding * 2,
              child: Container(
                margin: EdgeInsets.only(right: widget.height - widget.padding * 2 + (_slideRange - _slideDistance)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: widget.width - widget.padding - widget.height,
                        height: widget.height - widget.padding * 2,
                        child: Center(
                          child: endText,
                        ),
                      ),
                      right: -(_slideRange - _slideDistance),
                    )
                  ],
                ),
              )
            ),
            // 开始文字
            new Container(
              width: widget.width - widget.padding * 2,
              height: widget.height - widget.padding * 2,
              child: Container(
                margin: EdgeInsets.only(left: widget.height - widget.padding * 2 + _slideDistance),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        width: widget.width - widget.padding - widget.height,
                        height: widget.height - widget.padding * 2,
                        child: Center(
                          child: startText,
                        ),
                      ),
                      left: -_slideDistance,
                    )
                  ],
                ),
              )
            ),
            // 滑动按钮
            new Container(
              margin: EdgeInsets.only(left: _slideDistance),
              width: widget.height - widget.padding * 2,
              height: widget.height - widget.padding * 2,
              child: Card(
                clipBehavior: Clip.hardEdge,
                elevation: widget.buttonElevation,
                margin: EdgeInsets.all(0.0),
                color: iconColor,
                shape: widget.buttonShape ?? RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular((widget.height - widget.padding * 2) / 2))
                ),
                child: GestureDetector(
                  onHorizontalDragStart: (details){
                    if (_isLoad || _animationController.isAnimating) return;
                    _lastOffsetX = details.globalPosition.dx;
                  },
                  onHorizontalDragUpdate: (details){
                    if (_isLoad || _animationController.isAnimating) return;
                    _onSlide(details.globalPosition.dx);
                  },
                  onHorizontalDragEnd: (details){
                    if (_isLoad || _animationController.isAnimating) return;
                    // 滑动结束,启动动画
                    _startAnimation();
                  },
                  // 为按钮添加水波纹
                  child: InkWell(
                    onTap: (){},
                    borderRadius: BorderRadius.all(Radius.circular((widget.height - widget.padding * 2) / 2)),
                    child: Center(
                      child: icon,
                    ),
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 获取图标
  Widget _getIcon() {
    if (_status == SlideStatus.START) {
      if (_isLoad) {
        return widget.startLoadWidget ?? SizedBox(
            width: 25.0,
            height: 25.0,
            child: CircularProgressIndicator(
              strokeWidth: 3.0,
              valueColor: AlwaysStoppedAnimation(Colors.white),
            )
        );
      }else if (_isLoadedWaiting) {
        return widget.startedIcon ?? Icon(Icons.done,
          size: (widget.height - widget.padding * 2) / 3 * 2,
          color: Colors.white,
        );
      }else {
        return widget.startIcon ?? Icon(Icons.keyboard_arrow_right,
          size: (widget.height - widget.padding * 2) / 3 * 2,
          color: Colors.white,
        );
      }
    }else {
      if (_isLoad) {
        return widget.endLoadWidget ?? SizedBox(
          width: 25.0,
          height: 25.0,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            valueColor: AlwaysStoppedAnimation(Colors.white),
          )
        );
      }else if (_isLoadedWaiting) {
        return widget.endedIcon ?? Icon(Icons.done,
          size: (widget.height - widget.padding * 2) / 3 * 2,
          color: Colors.white,
        );
      }else {
        return widget.endIcon ?? Icon(Icons.keyboard_arrow_left,
          size: (widget.height - widget.padding * 2) / 3 * 2,
          color: Colors.white,
        );
      }
    }
  }

  // 获取开始文字
  Widget _getStartText() {
    if (_status == SlideStatus.START) {
      if (_isLoad) {
        return widget.endingText;
      }else if (_isLoadedWaiting) {
        return widget.endedText;
      }else {
        return widget.startText;
      }
    }else {
      return Container(
        child: widget.endFillView ?? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.keyboard_arrow_left),
            Icon(Icons.keyboard_arrow_left),
            Icon(Icons.keyboard_arrow_left),
            Icon(Icons.keyboard_arrow_left)
          ],
        ),
      );
    }
  }

  // 获取结束文字
  Widget _getEndText() {
    if (_status == SlideStatus.START) {
      return widget.startFillView ?? Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.keyboard_arrow_right),
            Icon(Icons.keyboard_arrow_right),
            Icon(Icons.keyboard_arrow_right),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      );
    }else {
      if (_isLoad) {
        return widget.startingText;
      }else if (_isLoadedWaiting) {
        return widget.startedText;
      }else {
        return widget.endText;
      }
    }
  }

  // 获取按钮颜色
  Color _getIconColor() {
    if (_status == SlideStatus.START) {
      if (_slideDistance >= _slideRange) {
        return widget.endColor;
      }else {
        // 计算比例
        double scale = (_slideRange - _slideDistance) / (widget.height - widget.padding) * 2;
        if (scale > 1) {
          return widget.startColor;
        }else {
          return Color.fromRGBO(
            widget.startColor.red + ((1 - scale) * (widget.endColor.red - widget.startColor.red)).floor(),
            widget.startColor.green + ((1 - scale) * (widget.endColor.green - widget.startColor.green)).floor(),
            widget.startColor.blue + ((1 - scale) * (widget.endColor.blue - widget.startColor.blue)).floor(),
            widget.startColor.opacity + (1 - scale) * (widget.endColor.opacity - widget.startColor.opacity)
          );
        }
      }
    }else {
      if (_slideDistance <= 0.0) {
        return widget.startColor;
      }else {
        // 计算比例
        double scale = (_slideDistance) / (widget.height - widget.padding) * 2;
        if (scale > 1) {
          return widget.endColor;
        }else {
          return Color.fromRGBO(
              widget.endColor.red + ((1 - scale) * (widget.startColor.red - widget.endColor.red)).floor(),
              widget.endColor.green + ((1 - scale) * (widget.startColor.green - widget.endColor.green)).floor(),
              widget.endColor.blue + ((1 - scale) * (widget.startColor.blue - widget.endColor.blue)).floor(),
              widget.endColor.opacity + (1 - scale) * (widget.startColor.opacity - widget.endColor.opacity)
          );
        }
      }
    }
  }
}