import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget {
  final String id;
  final String title;
  final String description;

  const VideoPage({Key key, this.id, this.title, this.description})
      : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
        return true;
      },
      child: OrientationBuilder(
        builder: (context, orientation) {
          return orientation == Orientation.landscape
              ? Scaffold(
                  body: SafeArea(
                    child: _buildPageView(),
                  ),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text('Player'),
                  ),
                  body: SafeArea(
                    child: _buildPageView(),
                  ),
                );
        },
      ),
    );
  }

  _buildPageView() {
    return ListView(children: [
      YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
      ),
      SizedBox(height: 20),
      Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title :',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(height: 20),
            Text(
              'Description :',
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(color: Theme.of(context).primaryColor),
            ),
            Text(
              widget.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    ]);
  }
}
