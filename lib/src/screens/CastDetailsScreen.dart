import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/Bloc/cast_details_bloc/bloc.dart';
import 'package:flutter_movie/src/Models/CastDetails.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Widgets/EntertainmentList.dart';
import 'package:flutter_movie/src/Widgets/HorizontalDivider.dart';
import 'package:flutter_movie/src/Widgets/ImagesList.dart';
import 'package:flutter_movie/src/Widgets/LoadingIndicator.dart';
import 'package:flutter_movie/src/Widgets/Section.dart';
import 'package:flutter_movie/src/Widgets/TextDetails.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CastDetailsScreen extends StatelessWidget {
  final String castName;

  const CastDetailsScreen({this.castName = ''});

  void _openBiographyDetails(BuildContext context, String data) {
    if (data.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TextDetails(
            data: data,
            title: 'Биография',
          ),
        ),
      );
    }
  }

  Widget _renderName(BuildContext context, String name) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Positioned(
        bottom: 0,
        child: ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                colors: [
                  backgroundColor.withOpacity(0.0),
                  backgroundColor.withOpacity(1),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0, 1),
                stops: const [0, 0.5],
              ).createShader(rect);
            },
            child: ShaderMask(
              shaderCallback: (Rect rect) {
                return LinearGradient(
                  colors: [
                    backgroundColor.withOpacity(0.1),
                    backgroundColor.withOpacity(.9),
                  ],
                  begin: Alignment.centerRight,
                  end: Alignment.center,
                  stops: const [0, 0.2],
                ).createShader(rect);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.only(right: 17.0),
                decoration: BoxDecoration(
                  //border: Border.all(width: 3, color: Colors.red),
                  color: Colors.white,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(name, style: GoogleFonts.dancingScript(fontSize: 32)),
                ),
              ),
            )));
  }

  Widget _renderHeaderStack(BuildContext context, CastDetailsLoadedSuccess state) {
    return Padding(
      padding: EdgeInsets.all(4),
      child: SizedBox(
        height: 260,
        child: Stack(
          children: <Widget>[
            if (state.personImages.isNotEmpty)
              ImagesList(
                items: state.personImages,
                height: 250,
                axis: Axis.vertical,
              ),
            _renderName(context, state.castDetails.name),
          ],
        ),
      ),
    );
  }

  Widget _renderBiography(BuildContext context, CastDetails details) {
    if (details.biography != null && details.biography.isNotEmpty) {
      final birthDay = DateTime.parse(details.birthday);

      return Section(
        child: Material(
          child: InkWell(
            onTap: () => _openBiographyDetails(context, details.biography),
            child: Wrap(
              children: <Widget>[
                Text(
                  details.biography,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 7,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7.5),
                  child: Text('Дата рождения: ${DateFormat.yMMMd('ru').format(birthDay)}'),
                ),
              ],
            ),
          ),
        ),
        shadowPosition: EShadowPosition.none,
      );
    }

    return SizedBox.shrink();
  }

  Widget _renderFilmography(List<Entertainment> movies) {
    if (movies.isNotEmpty) {
      return Section(
        child: EntertainmentList(
          items: movies,
          type: EEntertainmentType.Movie,
        ),
        shadowPosition: EShadowPosition.none,
        title: 'Фильмография',
      );
    }
    return SizedBox.shrink();
  }

  Widget _renderTVShows(List<Entertainment> shows) {
    if (shows.isNotEmpty) {
      return Section(
        child: EntertainmentList(
          items: shows,
          type: EEntertainmentType.TV,
        ),
        shadowPosition: EShadowPosition.none,
        title: 'ТВ шоу и сериалы',
      );
    }
    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastDetailsBloc, CastDetailsState>(
      builder: (context, castState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(castName),
          ),
          body: Builder(
            builder: (context) {
              if (castState is CastDetailsLoadedInProgress) {
                return LoadingIndicator();
              } else if (castState is CastDetailsLoadedSuccess) {
                return ListView(
                  children: <Widget>[
                    _renderHeaderStack(context, castState),
                    HorizontalDivider(),
                    _renderBiography(context, castState.castDetails),
                    HorizontalDivider(),
                    _renderFilmography(castState.filmography),
                    _renderTVShows(castState.tvShows),
                  ],
                );
              } else {
                return Center(
                  child: Text(castState.toString()),
                );
              }
            },
          ),
        );
      },
    );
  }
}
