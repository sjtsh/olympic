import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:video_player/video_player.dart';

import '../../Entities/LiveVideoObject.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  final bool shouldPlay;
  final Duration? dur;
  LiveVideoObject? playUrl;

  VideoWidget(this.url, {this.shouldPlay = false, this.dur, this.playUrl});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      widget.url,
      videoPlayerOptions: VideoPlayerOptions(),
    )..initialize().then((_) async {
        setState(() {});
        if (widget.shouldPlay) {
          await _controller.setLooping(true);
          context.read<NavigationManagement>().pauseVideo = false;
          context.read<NavigationManagement>().controllerPlaying = _controller;
          if (widget.playUrl != null &&
              widget.playUrl!.started.isAfter(DateTime.now())) {
          } else {
            Future.delayed(const Duration(milliseconds: 100))
                .then((value) async {
              await _controller.play();
              if (widget.dur != null) {
                print(widget.dur);
                await _controller.seekTo(widget.dur!.abs());
              }
            });
          }
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    // onPressed: () {
    //   setState(() {
    //     _controller.value.isPlaying
    //         ? _controller.pause()
    //         : _controller.play();
    //   });
    // },
    if (_controller.value.isInitialized) {
      return AspectRatio(
        aspectRatio: 3,
        child: VideoPlayer(
          _controller,
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
