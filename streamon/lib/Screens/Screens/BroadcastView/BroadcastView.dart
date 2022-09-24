import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Components/DialogPrompt.dart';
import 'package:streamon/Providers/InteractionManagement.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:streamon/Screens/Screens/VideoWidget.dart';
import 'package:streamon/data.dart';

import '../../../Entities/VideoObject.dart';

class BroadcastView extends StatefulWidget {
  final VideoObject playUrl;

  BroadcastView(this.playUrl);

  @override
  State<BroadcastView> createState() => _BroadcastViewState();
}

class _BroadcastViewState extends State<BroadcastView> {
  final StreamController<double> controller = StreamController<double>();

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<InteractionManagement>().addViewer(widget.playUrl.id);
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      controller.add(1);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                height: height / 2,
                width: width,
                color: Colors.white.withOpacity(0.1),
                child: VideoWidget(widget.playUrl.url, shouldPlay: true),
                //               Center(
                //     child: Container(
                //       decoration: BoxDecoration(
                //           border: Border.all(color: Colors.white.withOpacity(0.5)),
                //           shape: BoxShape.circle),
                //       child: const Padding(
                //         padding: EdgeInsets.all(12.0),
                //         child: Icon(
                //           Icons.play_arrow,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ),
                //   ),
              ),
            ),
            StreamBuilder(
                stream: controller.stream,
                builder: (context, AsyncSnapshot snapshot) {
                  return Column(
                    children: [
                      Slider(
                          value: (context
                                      .read<NavigationManagement>()
                                      .controllerPlaying
                                      ?.value
                                      .position
                                      .inSeconds ??
                                  0) +
                              0.0,
                          max: (context
                                      .read<NavigationManagement>()
                                      .controllerPlaying
                                      ?.value
                                      .duration
                                      .inSeconds ??
                                  1) +
                              0.0,
                          min: 0,
                          onChanged: (value) {
                            context
                                .read<NavigationManagement>()
                                .controllerPlaying
                                ?.seekTo(Duration(seconds: value.round()));
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                Duration? dur = await context
                                    .read<NavigationManagement>()
                                    .controllerPlaying
                                    ?.position;
                                if (dur != null) {
                                  dur -= const Duration(seconds: 15);
                                  context
                                      .read<NavigationManagement>()
                                      .controllerPlaying
                                      ?.seekTo(dur);
                                }
                              },
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                context.read<NavigationManagement>().pause();
                              },
                              icon: Icon(
                                context.watch<NavigationManagement>().pauseVideo
                                    ? Icons.play_arrow
                                    : Icons.pause,
                                color: Colors.white,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                Duration? dur = await context
                                    .read<NavigationManagement>()
                                    .controllerPlaying
                                    ?.position;
                                if (dur != null) {
                                  dur += const Duration(seconds: 15);
                                  context
                                      .read<NavigationManagement>()
                                      .controllerPlaying
                                      ?.seekTo(dur);
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                            Expanded(child: Container()),
                            Icon(Icons.volume_up_rounded),
                            Slider(
                                value: context
                                        .read<NavigationManagement>()
                                        .controllerPlaying
                                        ?.value
                                        .volume ??
                                    0,
                                onChanged: (value) {
                                  context
                                      .read<NavigationManagement>()
                                      .controllerPlaying
                                      ?.setVolume(value);
                                }),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<InteractionManagement>()
                                        .like(widget.playUrl.id);
                                  },
                                  child: Icon(
                                    context
                                            .watch<InteractionManagement>()
                                            .likes
                                            .contains(widget.playUrl.id)
                                        ? Icons.thumb_up_alt_sharp
                                        : Icons.thumb_up_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    context
                                        .read<InteractionManagement>()
                                        .bookmark(widget.playUrl.id);
                                  },
                                  child: Icon(
                                    context
                                            .watch<InteractionManagement>()
                                            .bookmarks
                                            .contains(widget.playUrl.id)
                                        ? Icons.bookmark
                                        : Icons.bookmark_outline,
                                    size: 30,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    widget.playUrl.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        ?.copyWith(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "${widget.playUrl.views} viewers",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white.withOpacity(0.5)),
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            Divider(
              color: Colors.white.withOpacity(0.1),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Other recommended streams",
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: context
                    .read<InteractionManagement>()
                    .videoObjects
                    .where((element) => widget.playUrl.id != element.id)
                    .toList()
                    .asMap()
                    .entries
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.0, vertical: 20),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return BroadcastView(e.value);
                            }));
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width / 5,
                                height: 130,
                                color: Colors.white.withOpacity(0.1),
                                child: Stack(
                                  children: [
                                    VideoWidget(
                                      e.value.url,
                                    ),
                                    Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(e.value.name)
                            ],
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            )
          ],
        );
      }),
    );
    // return MasonryGridView.count(
    //   crossAxisCount: 2,
    //   mainAxisSpacing: 4,
    //   crossAxisSpacing: 4,
    //   itemBuilder: (context, index) {
    //     return Container(
    //     height: ,
    //       child: Center(child: Text(index.toString())),
    //     );
    //   },
    // );
  }
}
