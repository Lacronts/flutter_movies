import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Widgets/AppContainer.dart';

class TextDetails extends StatelessWidget {
  final String title;
  final String data;

  const TextDetails({@required this.data, this.title = ''});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: AppContainer(
        child: SingleChildScrollView(
          child: Text(data),
        ),
      ),
    );
  }
}
