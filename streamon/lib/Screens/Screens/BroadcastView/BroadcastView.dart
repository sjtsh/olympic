import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BroadcastView extends StatelessWidget {
  const BroadcastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: height / 2,
          width: width,
          color: Colors.white.withOpacity(0.1),
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                  shape: BoxShape.circle),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
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
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "Barcelona Vs Real Madrid",
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          ?.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      "1.2k watching, Currently Streaming",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: Colors.white.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),

              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_sharp,
                    color: Colors.white,
                    size: 30,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Icon(Icons.bookmark_outline,
                    size: 30,),

                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(child: Container()),
        Divider(color: Colors.white.withOpacity(0.1),),
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
            children: ["", "", "", "", ""]
                .asMap()
                .entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: width / 5,
                          height: 100,
                          color: Colors.white.withOpacity(0.1),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text("Stream ${e.key}")
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        )
      ],
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
