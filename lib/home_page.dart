import 'package:flutter/material.dart';

import './common/app_bottom_bar.dart';
import 'profile_page_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _heightFactorAnimation;

  double collapsedHeightFactor = 0.85;
  double expandedHeightFactor = 0.67;
  double screenHeight = 0;

  bool isAnimationCompleted = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _heightFactorAnimation =
        Tween<double>(begin: collapsedHeightFactor, end: expandedHeightFactor)
            .animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  onBottomPartTap() {
    setState(() {
      if (isAnimationCompleted) {
        _animationController.fling(velocity: -1);
      } else {
        _animationController.fling(velocity: 1);
      }

      isAnimationCompleted = !isAnimationCompleted;
    });
  }

  Widget getWidget() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          FractionallySizedBox(
            heightFactor: _heightFactorAnimation.value,
            alignment: Alignment.topCenter,
            child: ProfilePageView(),
          ),
          GestureDetector(
            onTap: onBottomPartTap,
            onVerticalDragUpdate: _handleVerticalUpdate,
            onVerticalDragEnd: _handleVerticalEnd,
            child: FractionallySizedBox(
              heightFactor: 1.05 - _heightFactorAnimation.value,
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      );

  _handleVerticalUpdate(DragUpdateDetails dragUpdateDetails) {
    print('Update Details: ${dragUpdateDetails.primaryDelta}');
    double fractionDragged = dragUpdateDetails.primaryDelta / screenHeight;
    _animationController.value =
        _animationController.value - 5 * fractionDragged;
    print(_animationController.value);
  }

  _handleVerticalEnd(DragEndDetails dragEndDetails) {
    if (_animationController.value >= 0.5) {
      _animationController.fling(velocity: 1);
    } else {
      _animationController.fling(velocity: -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      bottomNavigationBar: AppBottomBar(),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, widget) {
          return getWidget();
        },
      ),
    );
  }
}
