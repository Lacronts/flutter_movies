import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/HeroTags.dart';
import 'package:flutter_movie/src/Utils.dart';

class Carousel extends StatefulWidget {
  final List<String> items;
  final String selectedItem;
  final Axis axis;

  Carousel(this.items, {this.selectedItem, this.axis = Axis.horizontal})
      : assert(items != null && items.isNotEmpty);

  @override
  _CarouselState createState() {
    final idx = items.indexOf(selectedItem);
    return _CarouselState(currentIdx: idx > -1 ? idx : 0);
  }
}

class _CarouselState extends State<Carousel> {
  int currentIdx;
  final PageController _controller;

  _CarouselState({this.currentIdx})
      : this._controller = PageController(initialPage: currentIdx, viewportFraction: 0.85);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _renderItem(String fileName) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 12),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
            elevation: 12,
            child: Hero(
              tag: HeroTags.build(fileName, EHeroType.Image),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: AppUtils.buildAssetPath(size: EImageSize.w780, axis: widget.axis),
                image: AppUtils.buildImagePath(fileName, size: EImageSize.w780),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Фото')),
      body: PageView(
        controller: _controller,
        children: widget.items.map((item) => _renderItem(item)).toList(),
      ),
    );
  }
}
