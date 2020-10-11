import 'package:flutter/cupertino.dart';
import 'package:flutter_movie/src/Widgets/AppContainer.dart';

class Header extends StatelessWidget {
  final String data;

  const Header(this.data);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Text(
        data,
        style: TextStyle(fontSize: 26.0),
      ),
    );
  }
}
