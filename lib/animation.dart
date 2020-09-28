import 'dart:math';

import 'package:ds_amimation/painters/circle1.dart';
import 'package:ds_amimation/painters/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Vishanti extends StatefulWidget {
  @override
  _VishantiState createState() => _VishantiState();
}

class _VishantiState extends State<Vishanti> with TickerProviderStateMixin {
  Animation<double> _animation;
  Animation _loop;
  AnimationController _controller;
  AnimationController _loopController;
  bool light = false;
  bool beforeLight = false;
  double rodHeight = 15;

  Color _color =  Color(0xFF7d12ff);

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    _controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    _loopController = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _loop = Tween<double>(begin: 0, end: 1.0).animate(_loopController);
    _loop.addListener(() {
      if(light) {
        setState(() {
        });
      }
    });
    _loop.addStatusListener((status) {
      if(status == AnimationStatus.dismissed) {
        _loopController.forward();
      } else if(status == AnimationStatus.completed) {
        _loopController.reverse();
      }
    });
    _loopController.forward();
    _animation = Tween<double>(begin: 0.2, end: 1).animate(CurvedAnimation(curve: Curves.easeIn, parent: _controller));
    _animation.addListener(() {
      setState(() {
      });
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          light = true;
        });
      } else if(status == AnimationStatus.dismissed) {
        setState(() {
          light = false;
        });
      }
    });

    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(rodHeight),
                bottomRight: Radius.circular(rodHeight)
              ),
              color:  Color(0xFF7d12ff).withOpacity(_animation.value),
              boxShadow: [
                BoxShadow(
                  color:  Color(0xFF7d12ff).withOpacity(_animation.value),
                  blurRadius: rodHeight * 1.5, // soften the shadow
                  spreadRadius: rodHeight / 3,
                )
              ]
            ),
          ),
          left: 0,
          top: MediaQuery.of(context).size.height / 3 - rodHeight / 2,
          width: MediaQuery.of(context).size.width / 3,
          height: rodHeight,
        ),
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(rodHeight),
                    bottomLeft: Radius.circular(rodHeight)
                ),
                color:  Color(0xFF7d12ff).withOpacity(_animation.value),
                boxShadow: [
                  BoxShadow(
                    color:  Color(0xFF7d12ff).withOpacity(_animation.value),
                    blurRadius: rodHeight * 1.5, // soften the shadow
                    spreadRadius: rodHeight / 3,
                  )
                ]
            ),
          ),
          right: 0,
          top: MediaQuery.of(context).size.height / 3 - rodHeight / 2,
          width: MediaQuery.of(context).size.width / 3,
          height: rodHeight,
        ),

        Container(
          child: light ? CustomPaint(
              isComplex: true,
              willChange: true,
              size: MediaQuery.of(context).size,
              painter: BoltLine()
          ) : Container(),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Switch(
            value: beforeLight,
            onChanged: (_) {
              if(beforeLight == false) {
                _controller.forward();
              } else {
                light = false;
                _controller.reverse();
              }
              setState(() {
                beforeLight = !beforeLight;
              });
            },
            activeColor: Colors.orange,
            inactiveThumbColor: Color(0xFF7d12ff).withAlpha(150),
            inactiveTrackColor: Color(0xFF7d12ff).withAlpha(100),
          ),
        )
      ],
    );
  }
}
