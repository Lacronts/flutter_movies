import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/Bloc/cast_list_bloc/bloc.dart';
import 'package:flutter_movie/src/Bloc/details/details_bloc.dart';
import 'package:flutter_movie/src/Bloc/entertainment_images/bloc.dart';
import 'package:flutter_movie/src/Models/Actor.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/EntertainmentCrew.dart';
import 'package:flutter_movie/src/Models/EntertainmentDetails.dart';
import 'package:flutter_movie/src/Models/HeroTags.dart';
import 'package:flutter_movie/src/Models/Review.dart';
import 'package:flutter_movie/src/Utils.dart';
import 'package:flutter_movie/src/Widgets/ActorsList.dart';
import 'package:flutter_movie/src/Widgets/EntertainmentList.dart';
import 'package:flutter_movie/src/Widgets/GenreCard.dart';
import 'package:flutter_movie/src/Widgets/Header.dart';
import 'package:flutter_movie/src/Widgets/HorizontalDivider.dart';
import 'package:flutter_movie/src/Widgets/ImagesList.dart';
import 'package:flutter_movie/src/Widgets/LoadingIndicator.dart';
import 'package:flutter_movie/src/Widgets/RowSpaceDivider.dart';
import 'package:flutter_movie/src/Widgets/Section.dart';
import 'package:flutter_movie/src/Widgets/Subheader.dart';
import 'package:flutter_movie/src/Widgets/TextDetails.dart';
import 'package:flutter_movie/src/Widgets/YouTubeWidget.dart';
import 'package:flutter_movie/src/screens/ReviewsList.dart';
import 'package:intl/intl.dart';

class EntertainmentDetailsScreen extends StatelessWidget {
  final String originalTitle;
  final EEntertainmentType type;

  EntertainmentDetailsScreen({this.originalTitle, this.type});

  final NumberFormat currencyFormatter =
      NumberFormat.currency(locale: 'en', name: '\$');

  void _openOverviewDetails(BuildContext context, String data) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TextDetails(data: data, title: 'Обзор фильма')));
  }

  void _openUserReviews(BuildContext context, List<Review> reviews) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ReviewsList(reviews)));
  }

  Widget _renderBackdrop(BuildContext context, String src) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            colors: [
              Theme.of(context)
                  .scaffoldBackgroundColor
                  .withOpacity(0.0)
                  .withOpacity(0.95),
              Theme.of(context).scaffoldBackgroundColor.withOpacity(0.0),
            ],
            begin: const FractionalOffset(0.0, 0.7),
            end: const FractionalOffset(0.0, 1),
          ).createShader(rect);
        },
        child: FadeInImage.assetNetwork(
          fit: BoxFit.cover,
          placeholder: AppUtils.buildAssetPath(
              size: EImageSize.w780, axis: Axis.horizontal),
          image: src,
        ),
      ),
    );
  }

  Widget _renderSubTitleInfo(EntertainmentDetails details) {
    return Section(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('${details.releaseDate.substring(0, 4)}г'),
              RowSpaceDivider(),
              Text(
                AppUtils.formatRuntime(details.runtime),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Colors.orange,
                      ),
                      Text(
                        '${details.voteAverage}',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '/10',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                  Text(
                    '${details.voteCount} голосов',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      shadowPosition: EShadowPosition.none,
    );
  }

  Widget _renderPoster(EntertainmentDetails details) {
    return Hero(
      tag: HeroTags.build(details.id, EHeroType.Image),
      child: FadeInImage.assetNetwork(
        placeholder:
            AppUtils.buildAssetPath(size: EImageSize.w92, axis: Axis.vertical),
        image: details.getPoster(),
      ),
    );
  }

  Widget _renderOverview(BuildContext context, EntertainmentDetails details) {
    return Section(
      child: Row(
        children: <Widget>[
          _renderPoster(details),
          Expanded(
            child: SizedBox(
              height: 150,
              child: Padding(
                padding: EdgeInsets.only(left: 7.5),
                child: Column(
                  children: <Widget>[
                    _renderGenres(details.genres),
                    _renderDescription(context, details.overview),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      shadowPosition: EShadowPosition.bottom,
    );
  }

  Widget _renderDescription(BuildContext context, String overview) {
    return Material(
      child: InkWell(
        onTap: () => _openOverviewDetails(context, overview),
        child: Padding(
          padding: EdgeInsets.only(top: 7.5),
          child: Text(
            overview,
            overflow: TextOverflow.ellipsis,
            maxLines: 6,
          ),
        ),
      ),
    );
  }

  Widget _renderGenres(List<String> genres) {
    return SizedBox(
      height: 35,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          for (var genre in genres) ...[
            GenreCard(genre),
            if (genre != genres.last) RowSpaceDivider(width: 4),
          ],
        ],
      ),
    );
  }

  Widget _renderImages(List<String> images) {
    return Section(
      child: ImagesList(
        items: images,
        height: 130,
      ),
      shadowPosition: EShadowPosition.bottom,
      title: 'Фото',
    );
  }

  Widget _renderTrailer(BuildContext context, String key) {
    return Section(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Subheader('Трейлер'),
          YouTubeWidget(id: key),
        ],
      ),
      shadowPosition: EShadowPosition.bottom,
    );
  }

  Widget _renderActors(List<Actor> actors) {
    if (actors != null && actors.isNotEmpty) {
      return Section(
        child: ActorsList(actors),
        title: 'Актеры',
      );
    }
    return SizedBox.shrink();
  }

  TableRow _spaceRowDivider() =>
      TableRow(children: [SizedBox(height: 7.5), SizedBox(height: 7.5)]);

  Widget _renderDetails(
      List<EntertainmentCrew> crew, EntertainmentDetails details) {
    final List<String> countries = details.productionCountries;
    final List<String> directors = EEntertainmentType.Movie == type
        ? crew
            .where((person) => person.job == Jobs.Director)
            .map((director) => director.name)
            .toList()
        : details.directors;

    final List<String> screenWriters = EEntertainmentType.Movie == type
        ? crew
            .where((person) => person.department == Department.Writing)
            .map((writer) => writer.name)
            .toList()
        : [];

    return Section(
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: FlexColumnWidth(),
        children: [
          if (directors.isNotEmpty) ...[
            TableRow(
              children: [
                TableCell(child: Text('Режиссер:')),
                TableCell(
                  child: directors.length > 1
                      ? Text('${directors[0]}, ${directors[1]}')
                      : Text(directors[0]),
                ),
              ],
            ),
            _spaceRowDivider()
          ],
          if (screenWriters.isNotEmpty) ...[
            TableRow(
              children: [
                TableCell(child: Text('Сценарий:')),
                TableCell(
                  child: screenWriters.length > 1
                      ? Text('${screenWriters[0]}, ${screenWriters[1]}')
                      : Text(screenWriters[0]),
                ),
              ],
            ),
            _spaceRowDivider()
          ],
          TableRow(
            children: [
              TableCell(child: Text('Оригинальное название:')),
              TableCell(child: Text(details.originalTitle)),
            ],
          ),
          _spaceRowDivider(),
          if (details.revenue != null && details.revenue != 0) ...[
            TableRow(
              children: [
                TableCell(child: Text('Доход:')),
                TableCell(
                    child:
                        Text('${currencyFormatter.format(details.revenue)}')),
              ],
            ),
            _spaceRowDivider()
          ],
          if (details.budget != null && details.revenue != 0) ...[
            TableRow(
              children: [
                TableCell(child: Text('Бюджет:')),
                TableCell(
                    child: Text('${currencyFormatter.format(details.budget)}')),
              ],
            ),
            _spaceRowDivider()
          ],
          if (details.numberOfSeasons != null) ...[
            TableRow(
              children: [
                TableCell(child: Text('Сезонов:')),
                TableCell(child: Text(details.numberOfSeasons.toString())),
              ],
            ),
            _spaceRowDivider()
          ],
          if (details.numberOfEpisodes != null) ...[
            TableRow(
              children: [
                TableCell(child: Text('Эпизодов:')),
                TableCell(child: Text(details.numberOfEpisodes.toString())),
              ],
            ),
            _spaceRowDivider()
          ],
          if (countries.isNotEmpty) ...[
            TableRow(
              children: [
                TableCell(child: Text('Страна:')),
                TableCell(
                  child: countries.length > 1
                      ? Text('${countries[0]}, ${countries[1]}')
                      : Text(countries[0]),
                ),
              ],
            ),
            _spaceRowDivider()
          ],
        ],
      ),
      shadowPosition: EShadowPosition.bottom,
      title: 'Детали',
    );
  }

  Widget _renderUserReviews(BuildContext context, List<Review> reviews) {
    return Section(
      child: Material(
        child: InkWell(
          onTap: () => _openUserReviews(context, reviews),
          child: Text(
            reviews[0].content,
            maxLines: 6,
            overflow: TextOverflow.fade,
          ),
        ),
      ),
      title: 'Отзывы',
      shadowPosition: EShadowPosition.bottom,
    );
  }

  Widget _renderRecomendations(List<Entertainment> recommedations) {
    return Section(
      title: 'Рекомендации',
      child: EntertainmentList(items: recommedations, type: type),
      shadowPosition: EShadowPosition.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(originalTitle ?? 'О фильме'),
      ),
      body: Builder(
        builder: (context) {
          return BlocBuilder<DetailsBloc, DetailsState>(
              builder: (context, detailsState) {
            return BlocBuilder<EntertainmentImagesBloc,
                EntertainmentImagesState>(builder: (context, imagesState) {
              return BlocBuilder<CastListBloc, CastListBlocState>(
                  builder: (context, castState) {
                if (detailsState is DetailsLoadedInProgress) {
                  return LoadingIndicator();
                } else if (detailsState is DetailsLoadedSuccess) {
                  final details = detailsState.details;

                  return ListView(
                    children: <Widget>[
                      if (details.getBackdrop() != null)
                        _renderBackdrop(context, details.getBackdrop()),
                      Header(details.title),
                      HorizontalDivider(),
                      _renderSubTitleInfo(details),
                      HorizontalDivider(),
                      _renderOverview(context, details),
                      if (imagesState is EntertainmentImagesLoadedSuccess &&
                          imagesState.images.isNotEmpty)
                        _renderImages(imagesState.images),
                      if (detailsState.trailer != null)
                        _renderTrailer(context, detailsState.trailer.key),
                      if (castState is CastListLoadedSuccess) ...[
                        _renderActors(castState.actors),
                        HorizontalDivider(),
                        _renderDetails(castState.crew, details),
                      ],
                      if (detailsState.reviews.isNotEmpty)
                        _renderUserReviews(context, detailsState.reviews),
                      if (detailsState.recommendations.isNotEmpty)
                        _renderRecomendations(detailsState.recommendations),
                    ],
                  );
                } else {
                  return SizedBox(
                    child: Center(
                      child: Text('cant open details'),
                    ),
                  );
                }
              });
            });
          });
        },
      ),
    );
  }
}
