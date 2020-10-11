import 'package:flutter/material.dart';

class RowSpaceDivider extends StatelessWidget {
  final double width;

  RowSpaceDivider({this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width ?? 10),
    );
  }
}
