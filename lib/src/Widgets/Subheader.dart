import 'package:flutter/cupertino.dart';

class Subheader extends StatelessWidget {
  final String data;

  const Subheader(this.data) : assert(data != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.5),
      child: Text(
        data,
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }
}
