import 'package:flutter/cupertino.dart';

class AnimatedBody extends StatefulWidget {
  final Widget child;
  const AnimatedBody({required this.child});

  @override
  _AnimatedBodyState createState() => _AnimatedBodyState();
}

class _AnimatedBodyState extends State<AnimatedBody>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
