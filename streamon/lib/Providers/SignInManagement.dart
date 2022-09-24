import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../Components/ExceptionHandler.dart';
import '../Services/AuthService.dart';

class SignInManagement with ChangeNotifier, DiagnosticableTreeMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;
  bool _isPasswordVisible = false;

  bool isConfirmButtonPressed = false;
  bool createButtonEnabled = false;

  clearState() {
    emailController.text = "";
    passwordController.text = "";
    emailError = null;
    passwordError = null;
    _isPasswordVisible = false;
    isConfirmButtonPressed = false;
    createButtonEnabled = false;
    notifyListeners();
  }

  bool validateEmail() {
    RegExp regExpEmail = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (emailController.text.isEmpty) {
      emailError = "Please enter email";
      return false;
    } else if (!regExpEmail.hasMatch(emailController.text)) {
      emailError = "Please enter valid email";
      return false;
    } else {
      emailError = null;
      return true;
    }
  }

  bool validatePassword() {
    if (passwordController.text.isNotEmpty) {
      passwordError = null;
      return true;
    } else {
      passwordError = "Password cannot be empty";
      return false;
    }
  }

  bool validate() {
    bool user = validateEmail();
    bool password = validatePassword();
    createButtonEnabled = user && password;
    notifyListeners();
    return createButtonEnabled;
  }

  Future<bool> logInToAccount(BuildContext context) async {
    isConfirmButtonPressed = true;
    bool isValidated = validate();
    if (isValidated) {
      bool success = await ExceptionHandler.catchFrom(
          function: () async {
            await AuthService()
                .signIn(emailController.text, passwordController.text, context);
          },
          context: context);
      return success;
    }

    return Future.value(false);
  }

  bool get isPasswordVisible => _isPasswordVisible;

  set isPasswordVisible(bool value) {
    _isPasswordVisible = value;
    notifyListeners();
  }
}
