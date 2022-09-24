import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Entities/AdminStats.dart';
import 'package:streamon/Providers/InteractionManagement.dart';
import 'package:streamon/Screens/Screens/VideoWidget.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: context
          .watch<InteractionManagement>()
          .videoObjects
          .map(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2,
                      color: Colors.white.withOpacity(0.3),
                      child: VideoWidget(e.url),
                    ),
                  ),
                  Expanded(
                      child: FutureBuilder(
                          future: context
                              .read<InteractionManagement>()
                              .getAdminStats(e.id),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              AdminStats adminStats = snapshot.data;
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30.0),
                                child: Column(
                                  children: [
                                    ["Likes", "${adminStats.likes} likes"],
                                    [
                                      "Bookmarks",
                                      "${adminStats.bookmarks} marks"
                                    ],
                                    [
                                      "Streaming",
                                      "${adminStats.streaming} users"
                                    ],
                                    [
                                      "Viewed for",
                                      "${adminStats.viewers} times"
                                    ]
                                  ]
                                      .map((e) => Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                                        child: Row(
                                              children: [
                                                Expanded(child: Text(e[0],
                                                  style: TextStyle(
                                                      fontSize: 16),)),
                                                Text(
                                                  e[1],
                                                  style: TextStyle(
                                                      color: Colors.white
                                                          .withOpacity(0.5),
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                      ))
                                      .toList(),
                                ),
                              );
                            }
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          })),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
