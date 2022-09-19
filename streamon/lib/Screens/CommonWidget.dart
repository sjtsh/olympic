import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CommonWidget extends StatelessWidget {
  const CommonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(20),
        height: double.infinity,
        color: Color(0xff383838),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child:
                    Center(child: LottieBuilder.asset("assets/stream.json"))),
            Text(
              "StreamOn",
              style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}
