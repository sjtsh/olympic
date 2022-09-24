import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Providers/NavigationManagement.dart';
import 'Providers/InteractionManagement.dart';
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
        ),
        ChangeNotifierProvider(
          create: (_) => InteractionManagement(),
        )
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // context.read<InteractionManagement>().setVideos();
    // Future.delayed(Duration(seconds: 1)).then((value) {
    //   context.read<InteractionManagement>().getLiveVideos();
    //   context.read<InteractionManagement>().getBookmarks();
    //   context.read<InteractionManagement>().getLikes();
    //   context.read<InteractionManagement>().getVideos();
    //   if (kDebugMode) {
    //     context.read<SignInManagement>().emailController.text =
    //         "sajatshrestha@gmail.com";
    //     context.read<SignInManagement>().passwordController.text =
    //         "decrypt3521";
    //
    //     // context.read<SignInManagement>().emailController.text =
    //     //     "admin@gmail.com";
    //     // context.read<SignInManagement>().passwordController.text =
    //     //     "adminuser";
    //     context.read<SignInManagement>().logInToAccount(context).then(
    //         (value) => context.read<UserManagement>().setindex(2, context));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    int index = context.watch<UserManagement>().index;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: PersonalThemeData().getLightThemeData(),
      home: Stack(
        children: [
          index == 0
              ? SignInScreen()
              : index == 1
                  ? SignUpScreen()
                  : HomeScreen(),
          Positioned(
            right: 20,
            top: 30,
            child: Container(
              height: context.watch<UserManagement>().animationOver ? 1 : 100,
              width: 300,
              child: ScaffoldMessenger(
                child: Scaffold(
                  key: scaffoldMessengerKey,
                  backgroundColor: Colors.transparent,
                  body: Container(
                    height: 50,
                    width: 300,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
