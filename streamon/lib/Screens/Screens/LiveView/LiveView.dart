import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Entities/LiveVideoObject.dart';

import '../../../Providers/InteractionManagement.dart';
import '../BroadcastView/BroadcastLiveView.dart';
import '../VideoWidget.dart';

class LiveView extends StatelessWidget {
  const LiveView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<LiveVideoObject> videosToShow = [];
    videosToShow = context.watch<InteractionManagement>().liveVideoObjects;
    if (videosToShow.isEmpty) {
      String message = "No Live Videos to show";
      return Center(
        child: Text(message),
      );
    }
    return GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(20),
        childAspectRatio: 2,
        crossAxisSpacing: 20,
        children: List.generate(videosToShow.length, (index) => index)
            .map((e) =>
                LayoutBuilder(builder: (context, BoxConstraints constraints) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) {
                            return BroadcastLiveView(videosToShow[e]);
                          }));
                        },
                        child: Container(
                          height: constraints.maxWidth * 1 / 3,
                          width: constraints.maxWidth,
                          color: Colors.white.withOpacity(0.1),
                          child: Stack(
                            children: [
                              VideoWidget(videosToShow[e].url),
                              Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white.withOpacity(0.5)),
                                      shape: BoxShape.circle),
                                  child: const Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // child: VideoWidget(),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Text(
                                    videosToShow[e].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        ?.copyWith(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${videosToShow[e].viewers} streamers",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                color: Colors.white
                                                    .withOpacity(0.5)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Container(
                                          color: Colors.blue.withOpacity(0.7),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: videosToShow[e]
                                                    .started
                                                    .isBefore(DateTime.now())
                                                ? Text("STREAMING NOW")
                                                : Text(
                                                    "STREAMING FROM ${videosToShow[e].started.toString().substring(11, 19)}"),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }))
            .toList());
  }
}
