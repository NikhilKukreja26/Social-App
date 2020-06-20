import 'package:flutter/material.dart';

import './models/profile_model.dart';
import './common/two_line_item.dart';

class ProfilePageView extends StatefulWidget {
  final PageController _pageController = PageController(
    initialPage: 0,
  );
  final double opactiy = 0.2;

  @override
  _ProfilePageViewState createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _slideAnimation, _fadeAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _slideAnimation = TweenSequence(
      [
        TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 0),
            end: Offset(0, 1),
          ),
          weight: 10,
        ),
        TweenSequenceItem<Offset>(
          tween: Tween(
            begin: Offset(0, 1),
            end: Offset(0, 0),
          ),
          weight: 10,
        ),
      ],
    ).animate(_controller);

    _fadeAnimation = TweenSequence([
      TweenSequenceItem<double>(tween: Tween(begin: 1, end: 0), weight: 10),
      TweenSequenceItem<double>(tween: Tween(begin: 0, end: 1), weight: 90),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  currentIndex(int index) {
    setState(() {
      _currentIndex = index;
      _controller.reset();
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        PageView.builder(
          itemCount: profiles.length,
          onPageChanged: (index) {
            currentIndex(index);
          },
          controller: widget._pageController,
          pageSnapping: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, int index) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  profiles[index].imagePath,
                  fit: BoxFit.cover,
                  color: Colors.black,
                  colorBlendMode: BlendMode.hue,
                ),
                DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(widget.opactiy),
                        Colors.white.withOpacity(0.1),
                        Colors.black.withOpacity(widget.opactiy),
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Positioned(
          left: 20.0,
          right: 20.0,
          bottom: 40.0,
          child: ProfileDetails(
            index: _currentIndex,
            slideAnimation: _slideAnimation,
            fadeTransition: _fadeAnimation,
          ),
        ),
      ],
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final int index;
  final Animation slideAnimation, fadeTransition;

  ProfileDetails({this.index, this.slideAnimation, this.fadeTransition});
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: fadeTransition,
      child: SlideTransition(
        position: slideAnimation,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstText: '${profiles[index].followers}',
              secondText: 'followers',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstText: '${profiles[index].posts}',
              secondText: 'posts',
            ),
            TwoLineItem(
              crossAxisAlignment: CrossAxisAlignment.start,
              firstText: '${profiles[index].following}',
              secondText: 'following',
            ),
          ],
        ),
      ),
    );
  }
}
