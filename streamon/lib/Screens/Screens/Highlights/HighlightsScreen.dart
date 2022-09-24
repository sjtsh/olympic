import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Entities/VideoObject.dart';
import 'package:streamon/Providers/InteractionManagement.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:streamon/Screens/Screens/BroadcastView/BroadcastView.dart';

import '../../../data.dart';
import '../VideoWidget.dart';

class HighlightsScreen extends StatelessWidget {
  const HighlightsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<VideoObject> videosToShow = [];
    if (context.watch<NavigationManagement>().navigationIndex == 3) {
      videosToShow = context
          .watch<InteractionManagement>()
          .videoObjects
          .where((element) =>
              context.watch<InteractionManagement>().likes.contains(element.id))
          .toList();
    } else if (context.watch<NavigationManagement>().navigationIndex == 2) {
      videosToShow = context
          .watch<InteractionManagement>()
          .videoObjects
          .where((element) => context
              .watch<InteractionManagement>()
              .bookmarks
              .contains(element.id))
          .toList();
    } else {
      videosToShow = context.watch<InteractionManagement>().videoObjects;
    }

    if (videosToShow.isEmpty) {
      String message = "No Videos to show";
      if (context.watch<NavigationManagement>().navigationIndex == 3) {
        message = "No Liked Videos";
      } else if (context.watch<NavigationManagement>().navigationIndex == 2) {
        message = "No Bookmarked Videos";
      }
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
                            return BroadcastView(videosToShow[e]);
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
                                  Text(
                                    "${videosToShow[e].views} viewers",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            color:
                                                Colors.white.withOpacity(0.5)),
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
