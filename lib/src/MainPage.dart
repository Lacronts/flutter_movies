import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_movie/src/Bloc/Tabs_bloc/tabs_bloc.dart';
import 'package:flutter_movie/src/Bloc/genres/genres_bloc.dart';
import 'package:flutter_movie/src/Bloc/now_playing_bloc/now_playing_bloc.dart';
import 'package:flutter_movie/src/Bloc/top_rated_bloc/top_rated_bloc.dart';
import 'package:flutter_movie/src/Bloc/upcoming_bloc/upcoming_bloc.dart';
import 'package:flutter_movie/src/Models/Tabs.dart';
import 'package:flutter_movie/src/Widgets/LoadingIndicator.dart';
import 'package:flutter_movie/src/Widgets/OpacityIn.dart';
import 'package:flutter_movie/src/screens/VerticalMovieList.dart';

class MainPage extends StatelessWidget {
  loadTopRated(context) {
    BlocProvider.of<TopRatedBloc>(context).add(TopRatedLoadedLazy());
  }

  loadNowPlaying(context) {
    BlocProvider.of<NowPlayingBloc>(context).add(NowPlayingLoadedLazy());
  }

  loadUpcoming(context) {
    BlocProvider.of<UpcomingBloc>(context).add(UpcomingLoadedLazy());
  }

  renderFailureState(dynamic state) {
    return Container(
      child: Center(
        child: Text(state.toString()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, TabsState>(builder: (context, state) {
      return Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Builder(
            builder: (context) {
              return BlocBuilder<GenresBloc, GenresState>(
                  builder: (context, genresState) {
                if (genresState is GenresLoadedInProgress) {
                  return LoadingIndicator();
                } else if (genresState is GenresLoadedSuccess) {
                  switch (state.activeTab.title) {
                    case NowPlayingTab:
                      return BlocBuilder<NowPlayingBloc, NowPlayingState>(
                        builder: (context, nowPlayingState) {
                          if (nowPlayingState is NowPlayingLoadedInProgress) {
                            return LoadingIndicator();
                          } else if (nowPlayingState is NowPlayingLoadSuccess) {
                            return OpacityIn(
                              child: VerticalMovieList(
                                genres: genresState.items,
                                movies: nowPlayingState.movies,
                                title: 'Уже в кино',
                                onLoadCb: () => loadNowPlaying(context),
                              ),
                            );
                          } else {
                            return renderFailureState(genresState);
                          }
                        },
                      );
                    case UpcomingTab:
                      return BlocBuilder<UpcomingBloc, UpcomingState>(
                        builder: (context, upcomingState) {
                          if (upcomingState is UpcomingLoadedInProgress) {
                            return LoadingIndicator();
                          } else if (upcomingState is UpcomingLoadSuccess) {
                            return OpacityIn(
                              child: VerticalMovieList(
                                genres: genresState.items,
                                movies: upcomingState.movies,
                                title: 'Скоро в кино',
                                onLoadCb: () => loadUpcoming(context),
                              ),
                            );
                          } else {
                            return renderFailureState(upcomingState);
                          }
                        },
                      );
                    case TopRatedTab:
                      return BlocBuilder<TopRatedBloc, TopRatedState>(
                          builder: (context, topRatedState) {
                        if (topRatedState is TopRatedLoadedInProgress) {
                          return LoadingIndicator();
                        } else if (topRatedState is TopRatedLoadSuccess) {
                          return VerticalMovieList(
                            genres: genresState.items,
                            movies: topRatedState.movies,
                            title: 'Топ',
                            onLoadCb: () => loadTopRated(context),
                          );
                        } else {
                          return renderFailureState(topRatedState);
                        }
                      });
                    default:
                      return Container(child: Text('WRONG TAB GUYS'));
                  }
                }

                return Container(
                  child: Center(
                    child: Text(genresState.toString()),
                  ),
                );
              });
            },
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 20.0,
          currentIndex: state.currentIndex,
          onTap: (int index) {
            BlocProvider.of<TabsBloc>(context)
                .add(TabSelected(newTab: appTabs[index]));
          },
          backgroundColor: Theme.of(context).primaryColor,
          selectedItemColor: Colors.white,
          items: appTabs.map((AppTab destination) {
            return BottomNavigationBarItem(
              icon: Icon(destination.icon),
              title: Text(destination.title),
            );
          }).toList(),
        ),
      );
    });
  }
}
