import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Components/TextField.dart';

import '../Providers/UserManagement.dart';

class DialogPrompt extends StatelessWidget {
  final String email;
  final String password;

  DialogPrompt(
    this.email,
    this.password,
  );

  showSnackbar(String text, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    TextEditingController controller1 = TextEditingController();
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: ShapeDecoration(
            color: Colors.grey.shade800,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SizedBox(
            height: 300,
            width: 396,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Reset Password",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  PersonalTextField(
                    controller: controller,
                    hintText: "Password",
                    obscureText: true,
                    padding: 0,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  PersonalTextField(
                    controller: controller1,
                    hintText: "Confirm Password",
                    obscureText: true,
                    padding: 0,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () async {
                      String originalEmail =
                          context.read<UserManagement>().localUser!.email;
                      String originalPassword =
                          context.read<UserManagement>().localUser!.password;

                        if (controller.text == "") {
                          Navigator.pop(context);
                          showSnackbar("passwords cannot be empty", context);
                        } else if (controller.text != controller1.text) {
                          Navigator.pop(context);
                          showSnackbar("passwords did not match", context);
                        } else {
                          try {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: email, password: password);
                          await resetPassword(controller, email);
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: originalEmail,
                                  password: originalPassword);
                          Navigator.pop(context);
                          showSnackbar("password was changed", context);
                          } catch (e) {
                            showSnackbar(e.toString(), context);
                          }
                        }
                    },
                    child: HoverWidget(
                      onHover: (PointerEnterEvent event) {},
                      hoverChild: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            "CHANGE",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.red),
                          ),
                        ),
                      ),
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.grey,
                        ),
                        child: Center(
                          child: Text(
                            "CHANGE",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  resetPassword(TextEditingController controller, String email) async {
    await FirebaseAuth.instance.currentUser?.updatePassword(controller.text);

    var a = await FirebaseFirestore.instance.collection('users').get();
    for (var element in a.docs) {
      if (element.data()["email"] == email) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(element.id)
            .update({"password": controller.text.trim()});
      }
    }
  }
}
