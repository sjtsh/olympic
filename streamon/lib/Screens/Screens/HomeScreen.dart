import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Screens/Screens/BroadcastView/BroadcastView.dart';
import 'package:streamon/Screens/Screens/Header.dart';

import '../../Providers/UserManagement.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(child: BroadcastView()),
        ],
      ),
    );
  }
}
