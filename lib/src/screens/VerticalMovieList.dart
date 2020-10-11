import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_movie/src/Models/Entertainment.dart';
import 'package:flutter_movie/src/Models/EntertainmentDetails.dart';
import 'package:flutter_movie/src/Models/Genre.dart';
import 'package:flutter_movie/src/Widgets/FadeIn.dart';
import 'package:flutter_movie/src/Widgets/MovieItem.dart';

import '../Router/Path.dart' show Path;

const STEP_TO_LOAD_PART = 0.75;

const STEP = 0.5;

class VerticalMovieList extends StatefulWidget {
  final List<Entertainment> movies;
  final List<Genre> genres;
  final String title;
  final Function onLoadCb;

  VerticalMovieList({
    Key key,
    @required this.movies,
    @required this.genres,
    this.title = '',
    this.onLoadCb,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VerticalMovieListState();
  }
}

class _VerticalMovieListState extends State<VerticalMovieList> {
  bool loadCbCalled = false;
  bool isToBottomScrolled = true;
  ScrollController _controller;
  ScrollDirection _lastScrollDirection;

  @override
  void initState() {
    _controller = ScrollController();

    _controller.addListener(() {
      if (_lastScrollDirection != _controller.position.userScrollDirection) {
        _lastScrollDirection = _controller.position.userScrollDirection;

        if (_lastScrollDirection == ScrollDirection.forward) {
          setState(() {
            isToBottomScrolled = false;
          });
        } else if (_lastScrollDirection == ScrollDirection.reverse) {
          setState(() {
            isToBottomScrolled = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.movies.length != widget.movies.length) {
      loadCbCalled = false;
    }
  }

  _onTap(BuildContext context, Entertainment movie) {
    Navigator.of(context).pushNamed(Path.MovieDetails,
        arguments: DetailsArguments(
          id: movie.id,
          title: movie.originalTitle,
          type: EEntertainmentType.Movie,
        ));
  }

  bool isNeedLoadMoreData(int idx) {
    if ((idx / widget.movies.length) > STEP_TO_LOAD_PART && !loadCbCalled) {
      return loadCbCalled = true;
    }
    return false;
  }

  double _getDuration(int idx) {
    return (idx < 6 && isToBottomScrolled) ? STEP * idx : 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: widget.movies.length,
        itemBuilder: (context, idx) {
          final movie = widget.movies[idx];
          if (widget.onLoadCb != null && isNeedLoadMoreData(idx)) {
            widget.onLoadCb();
          }
          return FadeIn(
              _getDuration(idx),
              MovieItem(
                key: Key(movie.id.toString()),
                movie: movie,
                genres: widget.genres,
                onTap: (movie) => _onTap(context, movie),
              ));
        },
      ),
    );
  }
}
