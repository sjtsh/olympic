import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:streamon/Components/TextField.dart';

class DialogPrompt extends StatelessWidget {
  const DialogPrompt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
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
                    controller: controller,
                    hintText: "Confirm Password",
                    obscureText: true,
                    padding: 0,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  GestureDetector(
                    onTap: () {},
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
}
