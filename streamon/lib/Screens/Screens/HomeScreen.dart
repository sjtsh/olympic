import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'package:streamon/Providers/UserManagement.dart';
import 'package:streamon/Screens/Screens/Header.dart';

import '../Admin/AdminScreen.dart';
import 'BlogsView/BlogsView.dart';
import 'Highlights/HighlightsScreen.dart';
import 'LiveView/LiveView.dart';
import 'ManageUserScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   if(kDebugMode){
  //     Future.delayed(Duration(seconds: 1)).then(
  //         (value) => Navigator.push(context, MaterialPageRoute(builder: (_) {
  //               return ManageUserScreen();
  //             })));
  //   }
  // }

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
