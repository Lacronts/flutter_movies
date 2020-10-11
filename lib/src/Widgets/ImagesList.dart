import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/HeroTags.dart';
import 'package:flutter_movie/src/Utils.dart';
import 'package:flutter_movie/src/Widgets/RowSpaceDivider.dart';
import 'package:flutter_movie/src/screens/Carousel.dart';

class ImagesList extends StatelessWidget {
  final List<String> items;
  final double height;
  final Axis axis;

  const ImagesList({
    @required this.items,
    this.height = 150,
    this.axis = Axis.horizontal,
  });

  _openCarousel(BuildContext context, String selected, List<String> images) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Carousel(images, selectedItem: selected, axis: axis)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, idx) {
          return GestureDetector(
            key: Key(items[idx]),
            onTap: () => _openCarousel(context, items[idx], items),
            child: Hero(
              tag: HeroTags.build(items[idx], EHeroType.Image),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.contain,
                  placeholder: AppUtils.buildAssetPath(size: EImageSize.w200, axis: axis),
                  image: AppUtils.buildImagePath(items[idx], size: EImageSize.w200),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, idx) {
          return RowSpaceDivider(width: 4.0);
        },
      ),
    );
  }
}
