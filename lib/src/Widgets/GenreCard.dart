import 'package:flutter/material.dart';

class GenreCard extends StatelessWidget {
  final genre;

  GenreCard(this.genre);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      padding: EdgeInsets.symmetric(horizontal: 7.5),
      decoration: BoxDecoration(
        border: Border.all(width: 0.5, color: Colors.grey[400]),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Center(child: Text(genre)),
    );
  }
}
