import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Providers/UserManagement.dart';

class ExceptionHandler {
  static Future<bool> catchFrom(
      {required Function() function, required BuildContext context}) async {
    // try {
      await function();
      return true;
    // } catch (e) {
    //   // scaffoldMessengerKey
    //   context.read<UserManagement>().showSnackbar(e.toString());
    //   print(e);
    //   return Future.value(false);
    // }
  }
}
