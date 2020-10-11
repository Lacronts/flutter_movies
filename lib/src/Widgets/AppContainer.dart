import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final Color color;

  AppContainer({@required this.child, this.height, this.color}) : assert(child != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 7.5),
      decoration: BoxDecoration(color: color ?? Theme.of(context).scaffoldBackgroundColor),
      child: child,
    );
  }
}
