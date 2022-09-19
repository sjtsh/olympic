import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Entities/LocalUser.dart';
import '../Services/AuthService.dart';
import 'SignInManagement.dart';
import 'SignUpManagement.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class UserManagement with ChangeNotifier, DiagnosticableTreeMixin {
  int _index = 1;
  User? _user;
  bool _listening = false;
  LocalUser? _localUser;

  bool get listening => _listening;

  set listening(bool value) {
    _listening = value;
    notifyListeners();
  }

  User? get user => _user;

  set user(User? value) {
    _user = value;
    notifyListeners();
  }

  LocalUser? get localUser => _localUser;

  set localUser(LocalUser? value) {
    _localUser = value;
    notifyListeners();
  }

  int get index => _index;

  setindex(int value, BuildContext context) {
    _index = value;
    context.read<SignInManagement>().clearState();
    context.read<SignUpManagement>().clearState();
    notifyListeners();
  }

  Future<void> showSnackbar(String text) async {
    await ScaffoldMessenger.of(scaffoldMessengerKey.currentContext!)
        .showSnackBar(
          SnackBar(
            backgroundColor: Color(0xff2f2f2f),
            duration: Duration(seconds: 5),
            content: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.info,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                    child: Text(
                  text,
                  style: TextStyle(color: Colors.white),
                )),
              ],
            ),
          ),
        )
        .closed;
  }

  logout(BuildContext context) async {
    setindex(0, context);
    UserManagement read = context.read<UserManagement>();
    await FirebaseAuth.instance.signOut();
    read.showSnackbar("Successfully logged out");
  }
}
