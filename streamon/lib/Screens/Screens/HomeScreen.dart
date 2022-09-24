import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:streamon/Providers/UserManagement.dart';
import 'package:streamon/Screens/Screens/Header.dart';

import '../Admin/AdminScreen.dart';
import 'BlogsView/BlogsView.dart';
import 'Highlights/HighlightsScreen.dart';
import 'LiveView/LiveView.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Header(),
          Expanded(
            child:  context.watch<UserManagement>().localUser?.admin ?? false ? AdminScreen(): context.watch<NavigationManagement>().navigationIndex == 0
                ? LiveView()
                : context.watch<NavigationManagement>().navigationIndex == 4
                    ? BlogsView()
                    : HighlightsScreen(),
          ),
        ],
      ),
    );
  }
}
