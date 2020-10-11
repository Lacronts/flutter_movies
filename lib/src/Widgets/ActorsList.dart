import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Actor.dart';
import 'package:flutter_movie/src/Models/CastDetails.dart';
import 'package:flutter_movie/src/Models/HeroTags.dart';
import 'package:flutter_movie/src/Router/Path.dart' show Path;
import 'package:flutter_movie/src/Utils.dart';
import 'package:flutter_movie/src/Widgets/RowSpaceDivider.dart';

class ActorsList extends StatelessWidget {
  final List<Actor> actors;

  const ActorsList(this.actors);

  void _openCastDetails(BuildContext context, Actor actor) {
    Navigator.pushNamed(context, Path.CastDetails,
        arguments: CastArguments(castId: actor.id, castName: actor.name));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: actors.length,
        itemBuilder: (context, idx) {
          final Actor actor = actors[idx];

          return GestureDetector(
            key: Key(actor.id.toString()),
            onTap: () => _openCastDetails(context, actor),
            child: SizedBox(
              width: 160,
              child: Card(
                elevation: 3,
                margin: EdgeInsets.only(bottom: 7.5),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 230,
                      child: Hero(
                        tag: HeroTags.build(actor.profilePath, EHeroType.Image),
                        child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder:
                              AppUtils.buildAssetPath(size: EImageSize.w200, axis: Axis.vertical),
                          image: AppUtils.buildImagePath(actor.profilePath, size: EImageSize.w200),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0),
                      child: Text(
                        actor.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        actor.character,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
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
