import 'package:flutter/material.dart';

class ExpandableWidget extends StatefulWidget {
  final Widget child;
  final withFade;
  final bool open;
  final double minHeight;
  final Duration duration;
  final Curve curve;
  final Alignment alignment;
  final AnimationBehavior animationBehavior;

  const ExpandableWidget({
    @required this.child,
    @required this.open,
    this.duration,
    this.withFade = false,
    this.alignment = Alignment.topCenter,
    this.minHeight = 0.0,
    this.curve = Curves.linear,
    this.animationBehavior = AnimationBehavior.normal,
  });

  @override
  _ExpandableWidgetState createState() => _ExpandableWidgetState();
}

class _ExpandableWidgetState extends State<ExpandableWidget> with TickerProviderStateMixin {
  GlobalKey _keyFoldChild;
  double _childWidth;
  double _childHeight;
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration ?? const Duration(milliseconds: 500),
      animationBehavior: widget.animationBehavior,
    );
    _keyFoldChild = GlobalKey();
    WidgetsBinding.instance.addPostFrameCallback(_afterLayout);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _afterLayout(_) {
    final RenderBox renderBox = _keyFoldChild?.currentContext?.findRenderObject();
    _childWidth = renderBox.size.width;
    _childHeight = renderBox.size.height;

    if (renderBox != null && _childHeight > widget.minHeight) {
      setState(() {
        _animation = Tween<double>(begin: widget.minHeight, end: _childHeight).animate(
          CurvedAnimation(parent: _controller, curve: widget.curve),
        );
      });
    }
  }

  Widget _renderClipRect(Widget child) {
    return ClipRect(
      child: SizedOverflowBox(
        alignment: widget.alignment,
        size: Size(_childWidth, _animation.value),
        child: child,
      ),
    );
  }

  Widget _renderClipRectWithFade(BuildContext context, Widget child) {
    final Color backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final double heightDiff = _childHeight - widget.minHeight;
    if (heightDiff.isNegative || heightDiff == 0.0) {
      return _renderClipRect(child);
    }

    return ShaderMask(
        shaderCallback: (Rect rect) {
          final animatedOpacity = (_animation.value - widget.minHeight) / heightDiff;

          return LinearGradient(
            colors: [
              backgroundColor.withOpacity(1.0),
              backgroundColor.withOpacity(animatedOpacity),
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0, 1),
            stops: const [0.6, 1],
          ).createShader(rect);
        },
        child: _renderClipRect(child));
  }

  @override
  Widget build(BuildContext context) {
    widget.open ? _controller.forward() : _controller.reverse();
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        if (_animation == null) {
          return child;
        } else {
          return widget.withFade ? _renderClipRectWithFade(context, child) : _renderClipRect(child);
        }
      },
      child: SizedBox(
        key: _keyFoldChild,
        child: widget.child,
      ),
    );
  }
}
