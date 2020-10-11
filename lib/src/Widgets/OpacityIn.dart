import 'package:flutter/material.dart';

class OpacityIn extends StatefulWidget {
  final Widget child;
  final Duration duration;

  OpacityIn({
    @required this.child,
    this.duration = const Duration(milliseconds: 400),
  });

  @override
  State<StatefulWidget> createState() {
    return _OpacityInState();
  }
}

class _OpacityInState extends State<OpacityIn> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      child: widget.child,
      opacity: _opacity,
      duration: widget.duration,
    );
  }
}
