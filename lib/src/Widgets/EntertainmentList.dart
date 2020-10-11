import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/EntertainmentDetails.dart';
import 'package:flutter_movie/src/Utils.dart';
import 'package:flutter_movie/src/Widgets/RowSpaceDivider.dart';
import 'package:flutter_movie/src/Router/Path.dart';

typedef OpenDetailsCallback = void Function(BuildContext context, int index);

const double ASPECT_RATIO = 0.67;

const double TITLE_HEIGHT = 50.0;

class EntertainmentList extends StatelessWidget {
  final List<Entertainment> items;
  final EEntertainmentType type;
  final double height;

  const EntertainmentList({
    @required this.items,
    @required this.type,
    this.height = 300,
  });

  void _openDetails(BuildContext context, Entertainment entertainment) {
    Navigator.of(context).pushNamed(
      Path.MovieDetails,
      arguments: DetailsArguments(
        id: entertainment.id,
        title: entertainment.originalTitle,
        type: type,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double imageHeight = height - TITLE_HEIGHT;
    final double cardWidth = imageHeight * ASPECT_RATIO;

    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, idx) {
          final item = items[idx];

          return GestureDetector(
            onTap: () => _openDetails(context, items[idx]),
            child: SizedBox(
              width: cardWidth,
              child: Card(
                margin: EdgeInsets.only(bottom: 7.5),
                elevation: 3,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: imageHeight,
                      child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder:
                            AppUtils.buildAssetPath(size: EImageSize.w200, axis: Axis.vertical),
                        image: AppUtils.buildImagePath(item.posterPath, size: EImageSize.w200),
                      ),
                    ),
                    if (item.title != null)
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0),
                          child: Center(
                            child: Text(
                              item.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (context, idx) => RowSpaceDivider(width: 4.0),
      ),
    );
  }
}
