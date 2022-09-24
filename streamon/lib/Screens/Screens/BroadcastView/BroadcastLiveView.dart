import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Components/DialogPrompt.dart';
import 'package:streamon/Providers/InteractionManagement.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:streamon/Screens/Screens/VideoWidget.dart';
import 'package:streamon/data.dart';

import '../../../Entities/LiveVideoObject.dart';
import '../../../Entities/VideoObject.dart';
import 'BroadcastView.dart';

class BroadcastLiveView extends StatefulWidget {
  final LiveVideoObject playUrl;

  BroadcastLiveView(this.playUrl);

  @override
  State<BroadcastLiveView> createState() => _BroadcastLiveViewState();
}

class _BroadcastLiveViewState extends State<BroadcastLiveView> {
  final StreamController<double> controller = StreamController<double>();

  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<InteractionManagement>().addStreamer(widget.playUrl.id);
    timer = Timer.periodic(Duration(milliseconds: 200), (timer) {
      controller.add(1);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    context.read<InteractionManagement>().removeStreamer(widget.playUrl.id);
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
                child: VideoWidget(
                  widget.playUrl.url,
                  shouldPlay: true,
                  dur: widget.playUrl.started.difference(DateTime.now()),
                  playUrl: widget.playUrl,
                ),
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
                      Slider(value: 1, max: 1, min: 0, onChanged: (value) {}),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            widget.playUrl.started.isAfter(DateTime.now())
                                ? Text(
                                    "Stream starts on ${widget.playUrl.started.toString().substring(11, 19)}")
                                : Text(
                                    "Stream started on ${widget.playUrl.started.toString().substring(11, 19)}"),
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
                                })
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
                    widget.playUrl.started.isAfter(DateTime.now())
                        ? "${widget.playUrl.viewers} other waiting"
                        : "${widget.playUrl.viewers} other streamers",
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
