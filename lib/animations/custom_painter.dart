import 'package:flutter/cupertino.dart';

class FlowPainter extends CustomPainter {
  final BuildContext context;
  final ValueNotifier<double> notifier;
  final GlobalKey target;
  final List<Color> colors;

  RenderBox? _renderBox;

  FlowPainter(
      {required this.context,
      required this.notifier,
      required this.target,
      required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    final screen = MediaQuery.of(context).size;

    _renderBox ??= target.currentContext!.findRenderObject() as RenderBox?;

    if (_renderBox == null) return;

    final page = notifier.value.floor();
    final animatorVal = notifier.value - page;
    final targetPos = _renderBox!.localToGlobal(Offset.zero);
    final xScale = screen.height * 8;
    final yScale = xScale / 2;

    var curvedVal = Curves.easeInOut.transformInternal(animatorVal);
    final reverseVal = 1 - curvedVal;

    Paint nextColorPaint = Paint(), bgPaint = Paint();
    Rect buttonRect, bgRect = Rect.fromLTWH(0, 0, screen.width, screen.height);

    if (animatorVal < 0.6) {
      bgPaint..color = colors[page % colors.length];
      nextColorPaint..color = colors[(page + 1) % colors.length];
      buttonRect = Rect.fromLTRB(
        targetPos.dx - (xScale * curvedVal), //left
        targetPos.dy - (yScale * curvedVal), //top
        targetPos.dx + _renderBox!.size.width * reverseVal, //right
        targetPos.dy + _renderBox!.size.height + (yScale * curvedVal), //bottom
      );
    } else {
      bgPaint..color = colors[(page + 1) % colors.length];
      nextColorPaint..color = colors[page % colors.length];
      buttonRect = Rect.fromLTRB(
        targetPos.dx + _renderBox!.size.width * reverseVal, //left
        targetPos.dy - yScale * reverseVal, //top
        targetPos.dx + _renderBox!.size.width + xScale * reverseVal, //right
        targetPos.dy + _renderBox!.size.height + yScale * reverseVal, //bottom
      );
    }

    canvas.drawRect(bgRect, bgPaint);
    canvas.drawRRect(
      RRect.fromRectAndRadius(buttonRect, Radius.circular(screen.height)),
      nextColorPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
