import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Entities/LocalUser.dart';
import 'package:streamon/Providers/UserManagement.dart';
import 'package:streamon/Services/AuthService.dart';

import '../../Components/DialogPrompt.dart';

class ManageUserScreen extends StatelessWidget {
  const ManageUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Manage Users",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            SizedBox(
              height: 20,
            ),
            FutureBuilder(
                future: AuthService().getUsers(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List<LocalUser> users = snapshot.data;
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Name")),
                                    ))),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Email")),
                                    ))),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Phone Number")),
                                    ))),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text("Change Password")),
                                    ))),
                          ],
                        ),
                        ...users
                            .map(
                              (e) => Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(e.firstName),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(e.email),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(e.phone),
                                      ),
                                    ),
                                  )),
                                  Expanded(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)),
                                            left: BorderSide(
                                                color: Colors.white
                                                    .withOpacity(0.1)))),
                                    child: Center(
                                      child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return DialogPrompt(
                                                        e.email,
                                                        e.password,);
                                                  });
                                            },
                                            icon: Icon(Icons.password),
                                          )),
                                    ),
                                  )),
                                ],
                              ),
                            )
                            .toList()
                      ],
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
