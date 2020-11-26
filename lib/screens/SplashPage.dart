import 'dart:async';

import 'package:flutter/material.dart';
import 'package:youtube_channel/screens/MyHomePage.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });

    _controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);

    // _animation = Tween<double>(begin: 0.0, end: 0.0).animate(_controller);

    _controller.forward();

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Opacity(
          opacity: _controller.value,
          child: Image.asset(
            'assets/images/riseuplabs.png',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
