import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'Providers/SignInManagement.dart';
import 'Providers/SignUpManagement.dart';
import 'Providers/UserManagement.dart';
import 'Screens/Screens/HomeScreen.dart';
import 'Screens/SignInScreen.dart';
import 'Screens/SignUpScreen.dart';
import 'Theme/ThemeData.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SignUpManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => SignInManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => UserManagement(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationManagement(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int index = context.watch<UserManagement>().index;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PersonalThemeData().getLightThemeData(),
      home: HomeScreen(),
      // home: Stack(
      //   children: [
      //     index == 0
      //         ? SignInScreen()
      //         : index == 1
      //             ? SignUpScreen()
      //             :
      //             HomeScreen(),
      //     Positioned(
      //       right: 20,
      //       top: 30,
      //       child: Container(
      //         height: 100,
      //         width: 300,
      //         child: ScaffoldMessenger(
      //           child: Scaffold(
      //           key: scaffoldMessengerKey,
      //             backgroundColor: Colors.transparent,
      //             body: Container(
      //               height: 50,
      //               width: 300,
      //             ),
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
    );
  }
}
