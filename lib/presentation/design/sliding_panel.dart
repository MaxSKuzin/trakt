import 'package:flutter/material.dart';

class SlidingPanel extends StatefulWidget {
  final Widget child;
  final Widget body;
  final bool canBeExpanded;
  final double edgeDragWidth;
  final double width;

  const SlidingPanel({
    required this.child,
    required this.body,
    required this.width,
    this.canBeExpanded = true,
    this.edgeDragWidth = 20,
    Key? key,
  }) : super(key: key);

  @override
  State<SlidingPanel> createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> with TickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      value: 0,
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final width = widget.width * _animationController.value;
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onPanUpdate: (details) {
                _animationController.value += details.delta.dx / widget.width;
              },
              onPanEnd: (details) {
                final dx = details.velocity.pixelsPerSecond.dx;
                if (dx > 0.0) {
                  _animationController.animateTo(1);
                } else if (dx < 0.0) {
                  _animationController.animateTo(0);
                } else if (_animationController.value > 0.5) {
                  _animationController.animateTo(1);
                } else {
                  _animationController.animateTo(0);
                }
              },
              child: Container(
                width: width > widget.edgeDragWidth ? width : widget.edgeDragWidth,
                padding: EdgeInsets.only(
                  right: width > widget.edgeDragWidth ? 0 : widget.edgeDragWidth,
                ),
                height: double.infinity,
                child: widget.body,
              ),
            );
          },
        ),
      ],
    );
  }
}
