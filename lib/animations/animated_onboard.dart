import 'package:anim_onboard/animations/animation_body.dart';
import 'package:anim_onboard/animations/custom_painter.dart';
import 'package:flutter/material.dart';

/*
  Use this widget in your onboarding process.
  It already comes with Scaffold widget.
*/
class AnimatedOnboarding extends StatefulWidget {
  // total of all pages in your onboarding process
  final List<OnboardingPage> pages;
  // your custom PageController
  final PageController pageController;
  // Callback if the user clicks on Finish or the next button on the last page
  final VoidCallback onFinishedButtonTap;
  // headers top left widget that should be displayed
  final Widget topLeftChild;
  // headers top right widget that should be displayed; Will be replaced by "Finish"-button on the last page.
  final Widget topRightChild;
  // main axis alignment between header widgets
  final MainAxisAlignment topMainAxisAlignment;

  const AnimatedOnboarding({
    required this.pages,
    required this.pageController,
    required this.topLeftChild,
    required this.topRightChild,
    required this.onFinishedButtonTap,
    this.topMainAxisAlignment = MainAxisAlignment.spaceBetween,
  });

  @override
  _AnimatedOnboardingState createState() => _AnimatedOnboardingState();
}

class _AnimatedOnboardingState extends State<AnimatedOnboarding> {
  ValueNotifier<double> _notifier = ValueNotifier(0.025);
  final _button = GlobalKey();

  bool _lastPageIsVisible = false;

  @override
  void initState() {
    // notify scroll changes in pageview
    widget.pageController.addListener(() {
      // +0.025 - shows a little bit of the upcoming page in the circle button
      var dd = widget.pageController.page;
      if (dd != null) {
        _notifier.value = dd + 0.025;
      }

      // change state if the current page is the last page
      if (widget.pageController.page == widget.pages.length - 1 &&
          !_lastPageIsVisible) {
        setState(() => _lastPageIsVisible = true);
      }

      if (_lastPageIsVisible &&
          widget.pageController.page != widget.pages.length - 1) {
        setState(() => _lastPageIsVisible = false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    widget.pageController.dispose();
    _notifier.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _notifier,
            builder: (context, __) => CustomPaint(
              painter: FlowPainter(
                context: context,
                notifier: _notifier,
                target: _button,
                colors:
                    widget.pages.map((e) => e.color).toList(growable: false),
              ),
            ),
          ),
          PageView.builder(
            controller: widget.pageController,
            itemCount: widget.pages.length,
            itemBuilder: (c, i) => Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 200),
                child: AnimatedBody(
                  child: widget.pages.elementAt(i).child,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: widget.topMainAxisAlignment,
                  children: <Widget>[
                    widget.topLeftChild,
                    if (_lastPageIsVisible)
                      MaterialButton(
                        onPressed: () => widget.onFinishedButtonTap(),
                        child: const Text(
                          "Finish",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    if (!_lastPageIsVisible) widget.topRightChild,
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!_lastPageIsVisible) {
                widget.pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeOut);
              } else {
                widget.onFinishedButtonTap();
              }
            },
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewPadding.bottom + 25),
                child: Material(
                  color: Colors.transparent,
                  // elevation: 4.0,
                  // shadowColor: Colors.white,
                  shape: CircleBorder(),
                  child: AnimatedBuilder(
                    animation: _notifier,
                    builder: (_, __) {
                      final animatorVal =
                          _notifier.value - _notifier.value.floor();
                      double iconPos = 0;
                      int colorIndex;
                      if (animatorVal < 0.5) {
                        iconPos = 60 * -animatorVal;
                        colorIndex = _notifier.value.floor() + 1;
                      } else {
                        colorIndex = _notifier.value.floor() + 2;
                        iconPos = -60;
                      }
                      if (animatorVal > 0.9) {
                        iconPos = -250 * (1 - animatorVal) * 10;
                      }
                      // colorIndex = colorIndex % widget.pages.length;
                      return SizedBox(
                        key: _button,
                        width: 60,
                        height: 60,
                        // child: const Center(child: Text('gdrg')),
                        child: Transform.translate(
                          offset: const Offset(0, 0),
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Icons.navigate_next,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final Color color;
  final Widget child;

  const OnboardingPage({required this.color, required this.child});
}
