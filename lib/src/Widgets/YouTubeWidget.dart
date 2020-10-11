import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeWidget extends StatelessWidget {
  final String id;
  final YoutubePlayerController _controller;

  YouTubeWidget({@required this.id})
      : _controller = YoutubePlayerController(
          initialVideoId: id,
          flags: YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      progressIndicatorColor: Colors.amber,
      progressColors: ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
    );
  }
}
