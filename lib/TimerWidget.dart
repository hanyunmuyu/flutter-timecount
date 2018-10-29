import 'package:flutter/material.dart';

typedef void StopCount(bool b);
typedef void StartCountAction(BuildContext context);

class TimerWidget extends StatefulWidget {
  final int time;
  final StartCountAction startCountAction;

  TimerWidget({this.time = 10, this.startCountAction});

  @override
  State createState() {
    return new _TimerWidgetState();
  }
}

class _TimerWidgetState extends State<TimerWidget> {
  bool isPressed = false;
  Widget timer;

  void _startCount(bool b) {
    setState(() {
      isPressed = b;
    });
  }

  void _stopCount(bool b) {
    setState(() {
      isPressed = !b;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        if (isPressed) {
          return;
        }
        timer = new TimerCount(
          time: 10,
          stopCount: _stopCount,
        );
        widget.startCountAction(context);
        _startCount(true);
      },
      child: isPressed ? timer : new Text('点击获得验证码'),
    );
  }
}

class TimerCount extends StatefulWidget {
  final int time;
  final StopCount stopCount;
  final String leftLabel;
  final String rightLabel;

  TimerCount(
      {this.time = 60,
      this.stopCount,
      this.leftLabel = '还有',
      this.rightLabel = '秒重发'});

  @override
  State createState() {
    return new _TimerCountState();
  }
}

class _TimerCountState extends State<TimerCount> {
  int _time;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _time = widget.time;
    });
    _triggerStart();
  }

  void _count() {
    Future.delayed(const Duration(seconds: 1), _triggerStart);
  }

  void _triggerStart() {
    if (_time <= 0) {
      widget.stopCount(true);
      return;
    }
    _count();
    setState(() {
      _time -= 1;
      print(_time);
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Text(widget.leftLabel + '$_time' + widget.rightLabel),
    );
  }
}
