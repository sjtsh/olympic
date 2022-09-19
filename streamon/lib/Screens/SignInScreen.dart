import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Screens/CommonWidget.dart';

import '../Components/TextField.dart';
import '../Providers/SignInManagement.dart';
import '../Providers/UserManagement.dart';
class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInManagement read = context.read<SignInManagement>();
    SignInManagement watch = context.watch<SignInManagement>();
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Row(
        children: [
        CommonWidget(),
          SizedBox(
            width: 500,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Row(
                children: [
                  Expanded(child: Container()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Sign In",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "And stream your favourite football team",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PersonalTextField(
                            controller: read.emailController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.emailError
                                : null,
                            labelText: "Email",
                            onChanged: (String? input) {
                              read.validate();
                            },
                          ),
                          PersonalTextField(
                            controller: read.passwordController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.passwordError
                                : null,
                            labelText: 'Password',
                            obscureText:
                            watch.isPasswordVisible ? false : true,
                            icon: GestureDetector(
                              onTap: () {
                                read.isPasswordVisible =
                                !read.isPasswordVisible;
                              },
                              child: Icon(watch.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            onChanged: (String? input) {
                              read.validate();
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool valid = await read.logInToAccount(context);
                              if (valid) {
                                context
                                    .read<UserManagement>()
                                    .showSnackbar("Successfully signed in");
                                context.read<UserManagement>().setindex(2, context);
                              }
                            },
                            child: HoverContainer(
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              color: watch.createButtonEnabled
                                  ? Color(0xff0071FF)
                                  : Colors.blueGrey,
                              hoverColor: Color(0xff0071FF),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Log in to the Account",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Text("Don't have an account? ",
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  context.read<UserManagement>().setindex(1, context);

                                },
                                child: HoverWidget(
                                  onHover: (PointerEnterEvent event) {},
                                  hoverChild: Text(
                                    "Signup",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  child: Text(
                                    "Signup",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
