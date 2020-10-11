import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/Bloc/Tabs_bloc/tabs_bloc.dart';
import 'package:flutter_movie/src/Bloc/cast_details_bloc/bloc.dart';
import 'package:flutter_movie/src/Bloc/cast_list_bloc/bloc.dart';
import 'package:flutter_movie/src/Bloc/details/details_bloc.dart';
import 'package:flutter_movie/src/Bloc/entertainment_images/bloc.dart';
import 'package:flutter_movie/src/Bloc/genres/genres_bloc.dart';
import 'package:flutter_movie/src/Bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:flutter_movie/src/Bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:flutter_movie/src/Bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:flutter_movie/src/MainPage.dart';
import 'package:flutter_movie/src/Models/CastDetails.dart';
import 'package:flutter_movie/src/Models/EntertainmentDetails.dart';
import 'package:flutter_movie/src/Repositories/MovieRepositories.dart';
import 'package:flutter_movie/src/Router/Path.dart' show Path;
import 'package:flutter_movie/src/screens/CastDetailsScreen.dart';
import 'package:flutter_movie/src/screens/EntertainmentDetailsScreen.dart';

void main() {
  runApp(
    MaterialApp(
      //theme: ThemeData.dark(),
      initialRoute: Path.NowPlaying,
      routes: {
        Path.NowPlaying: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => TabsBloc(),
                ),
                BlocProvider(
                  create: (context) =>
                      NowPlayingBloc(moviesRepository: MovieRepositories())
                        ..add(NowPlayingLoaded()),
                ),
                BlocProvider(
                  create: (context) =>
                      UpcomingBloc(moviesRepository: MovieRepositories())
                        ..add(UpcomingLoaded()),
                ),
                BlocProvider(
                  create: (context) =>
                      TopRatedBloc(moviesRepository: MovieRepositories())
                        ..add(TopRatedLoaded()),
                ),
                BlocProvider(
                  create: (context) =>
                      GenresBloc(MovieRepositories())..add(GenresLoaded()),
                ),
              ],
              child: MainPage(),
            ),
        Path.MovieDetails: (context) {
          final DetailsArguments arguments =
              ModalRoute.of(context).settings.arguments;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      EntertainmentImagesBloc(MovieRepositories())
                        ..add(EntertainmentImagesLoaded(
                          entertainmentId: arguments.id,
                          type: arguments.type,
                        ))),
              BlocProvider(
                  create: (context) => DetailsBloc(MovieRepositories())
                    ..add(DetailsLoaded(
                        entertainmentId: arguments.id, type: arguments.type))),
              BlocProvider(
                  create: (context) => GenresBloc(MovieRepositories())),
              BlocProvider(
                create: (context) => CastListBloc(MovieRepositories())
                  ..add(CastListLoaded(
                    entertainmentId: arguments.id,
                    type: arguments.type,
                  )),
              ),
            ],
            child: EntertainmentDetailsScreen(
              originalTitle: arguments.title,
              type: arguments.type,
            ),
          );
        },
        Path.CastDetails: (context) {
          final CastArguments arguments =
              ModalRoute.of(context).settings.arguments;
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CastDetailsBloc(MovieRepositories())
                  ..add(CastDetailsLoaded(arguments.castId)),
              )
            ],
            child: CastDetailsScreen(
              castName: arguments.castName,
            ),
          );
        }
      },
    ),
  );
}
