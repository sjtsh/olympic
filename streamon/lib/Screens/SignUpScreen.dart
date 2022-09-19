import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Screens/CommonWidget.dart';
import '../Components/TextField.dart';
import '../Providers/SignUpManagement.dart';
import '../Providers/UserManagement.dart';
import 'SignInScreen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignUpManagement read = context.read<SignUpManagement>();
    SignUpManagement watch = context.watch<SignUpManagement>();
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
                        "Register Now",
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
                            controller: read.firstNameController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.firstNameError
                                : null,
                            labelText: "Name",
                            onChanged: (String? input) {
                              read.validate();
                            },
                          ),
                          PersonalTextField(
                            controller: read.phoneController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.phoneError
                                : null,
                            labelText: "Phone Number",
                            onChanged: (String? input) {
                              read.validate();
                            },
                          ),
                          PersonalTextField(
                            controller: read.emailController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.emailError
                                : null,
                            labelText: 'Email',
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
                                !watch.isPasswordVisible;
                              },
                              child: Icon(watch.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            onChanged: (String? input) {
                              read.confirmEnabled = input != null;
                              read.testPasswordStrength();
                              read.validate();
                            },
                          ),
                          PersonalTextField(
                            controller: read.confirmController,
                            errorText: watch.isConfirmButtonPressed
                                ? watch.confirmError
                                : null,
                            labelText: 'Confirm Password',
                            obscureText:
                            watch.isPasswordVisible ? false : true,
                            icon: GestureDetector(
                              onTap: () {
                                read.isPasswordVisible =
                                !watch.isPasswordVisible;
                              },
                              child: Icon(watch.isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            enabled: watch.confirmEnabled,
                            onChanged: (String? input) {
                              read.validate();
                            },
                          ),
                          if ((watch.isConfirmButtonPressed
                              ? watch.passwordError
                              : null) !=
                              null)
                            Container()
                          else
                            Row(
                              children: [
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      height: 5,
                                      width: (400) -
                                          40,
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.white.withOpacity(0.1),
                                        borderRadius:
                                        BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          AnimatedContainer(
                                            duration:
                                            Duration(milliseconds: 200),
                                            height: 5,
                                            width: ((400 -
                                                40) /
                                                5) *
                                                (watch.passwordStrength ??
                                                    0),
                                            color: watch
                                                .passwordStrengthColor ??
                                                Colors.transparent,
                                          ),
                                          Expanded(child: Container()),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      (watch.passwordStrengthText) ?? "-",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color:
                                        watch.passwordStrengthColor ??
                                            Colors.transparent,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width /
                                      100,
                                ),
                                Tooltip(
                                  padding: EdgeInsets.all(12),
                                  textStyle: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                  message:
                                  "1.  weakest denotes password with less than 8 characters\n2.  weak denotes password which are case insensitive\n3.  medium denotes password that are alphanumeric or case sensitive\n4.  strong denotes password that are alphanumeric case sensitive or contains special character\n5.  strongest denotes password that are alphanumeric case sensitive and contains special character",
                                  decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.9),
                                      borderRadius:
                                      BorderRadius.circular(12)),
                                  preferBelow: false,
                                  showDuration: Duration(seconds: 2),
                                  child: HoverWidget(
                                    hoverChild: Icon(
                                      Icons.info_outline,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                    onHover: (PointerEnterEvent event) {},
                                    child: Icon(
                                      Icons.info_outline,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: watch.termsCheckBox,
                                activeColor: Colors.white.withOpacity(0.5),
                                onChanged: (bool? status) {
                                  read.termsCheckBox =
                                      status ?? read.termsCheckBox;
                                  read.validate();
                                },
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "I agree to all the ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Terms",
                              ),
                              Text(
                                ", ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Privacy Policy ",
                              ),
                              Text(
                                "and ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "Fees",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              bool success = await context
                                  .read<SignUpManagement>()
                                  .createAccount(context);
                              if (success) {
                                context
                                    .read<UserManagement>()
                                    .showSnackbar("Successfully signed up");
                                context
                                    .read<UserManagement>()
                                    .setindex(0, context);
                              }
                            },
                            child: HoverContainer(
                              hoverColor: Color(0xff0071FF),
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 50),
                              color: watch.createButtonEnabled
                                  ? Color(0xff0071FF)
                                  : Colors.blueGrey,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Create Account",
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
                              Text("Already have an account? ",
                                  style: TextStyle(color: Colors.white)),
                              GestureDetector(
                                onTap: () {
                                  context
                                      .read<UserManagement>()
                                      .setindex(0, context);
                                },
                                child: HoverWidget(
                                  onHover: (PointerEnterEvent event) {},
                                  hoverChild: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blue),
                                  ),
                                  child: Text(
                                    "Login",
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
