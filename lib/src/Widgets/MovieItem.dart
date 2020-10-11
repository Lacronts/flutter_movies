import 'package:flutter/material.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/Genre.dart';
import 'package:flutter_movie/src/Models/HeroTags.dart';
import 'package:flutter_movie/src/Utils.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

typedef OnTapCallback = void Function(Entertainment movie);

class MovieItem extends StatelessWidget {
  final Entertainment movie;
  final List<Genre> genres;
  final OnTapCallback onTap;

  MovieItem({Key key, this.movie, this.genres, this.onTap}) : super(key: key);

  Widget _renderPoster() {
    return SizedBox(
      width: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          bottomLeft: Radius.circular(10.0),
        ),
        child: Hero(
          tag: HeroTags.build(movie.id, EHeroType.Image),
          child: FadeInImage.assetNetwork(
            fit: BoxFit.cover,
            placeholder: AppUtils.buildAssetPath(
                size: EImageSize.w92, axis: Axis.vertical),
            image: movie.getPoster(),
          ),
        ),
      ),
    );
  }

  Widget _renderTitle() {
    return Padding(
      padding: EdgeInsets.only(bottom: 7.5),
      child: Text(
        movie.title,
        style: TextStyle(fontSize: 20.0),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _renderRating() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.star,
          color: Colors.orange,
        ),
        Text(
          '${movie.voteAverage}',
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }

  Widget _renderGenre() {
    List<String> genreNames = movie.genreIds
        .map((id) => genres
            .firstWhere((genre) => genre.id == id, orElse: () => null)
            ?.name)
        .toList();

    return Padding(
      padding: EdgeInsets.only(top: 5.0),
      child: Text(genreNames.join(', ')),
    );
  }

  Widget _renderDescription() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        margin: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _renderTitle(),
            _renderRating(),
            _renderGenre(),
            _renderReleaseDate(),
          ],
        ),
      ),
    );
  }

  Widget _renderReleaseDate() {
    final date = DateTime.parse(movie.releaseDate);
    initializeDateFormatting('ru', null);
    return Padding(
      padding: EdgeInsets.only(top: 7.5),
      child: Text(
        'В кино с ${DateFormat.yMMMd('ru').format(date)}',
        style: TextStyle(
          fontStyle: FontStyle.italic,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5, horizontal: 10.0),
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kElevationToShadow[4],
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        child: InkWell(
          onTap: () => onTap(movie),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _renderPoster(),
              _renderDescription(),
            ],
          ),
        ),
      ),
    );
  }
}
