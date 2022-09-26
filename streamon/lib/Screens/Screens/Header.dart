import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:streamon/Components/DialogPrompt.dart';

import '../../Components/TextField.dart';
import '../../Providers/NavigationManagement.dart';
import '../../Providers/UserManagement.dart';
import 'ManageUserScreen.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserManagement userManagement = context.watch<UserManagement>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          SvgPicture.network(
            "https://olympics.com/images/static/b2p-images/logo_color.svg",
            height: 50,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Olympic On",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          if (!(userManagement.localUser?.admin ?? false)) Container() else Row(
                children: [
                  GestureDetector(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_){
                    return ManageUserScreen();
                    }));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12,
                              ),
                              Icon(Icons.person_pin_circle_outlined,),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                "manage users",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ),
                    SizedBox(width: 12,)
                ],
              ),
          context.watch<UserManagement>().localUser?.admin ?? false
              ? Container()
              : Row(
                  children: [
                  "Live",
                  "Highlights",
                  "My Bookmarks",
                  "My Likes",
                  "Blogs",
                ]
                      .asMap()
                      .entries
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: GestureDetector(
                            onTap: () {
                              context
                                  .read<NavigationManagement>()
                                  .navigationIndex = e.key;
                            },
                            child: Container(
                              color: context
                                          .watch<NavigationManagement>()
                                          .navigationIndex ==
                                      e.key
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  e.value,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
          PopupMenuButton(
            itemBuilder: (_) {
              return <Widget>[
                getPopupMenuButton(context),
                Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Logout"),
                  ],
                )
              ]
                  .asMap()
                  .entries
                  .map((e) => PopupMenuItem(
                        value: e.key,
                        child: e.value,
                      ))
                  .toList();
            },
            onSelected: (int i) {
              switch (i) {
                case 1:
                  context.read<UserManagement>().logout(context);
                  break;
              }
            },
            child: getPopupMenuButton(context),
          ),
        ],
      ),
    );
  }

  getPopupMenuButton(BuildContext context) {
    UserManagement userManagement = context.watch<UserManagement>();
    return Container(
      decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(6)),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: [
            SizedBox(
              width: 12,
            ),
            Icon(Icons.person),
            SizedBox(
              width: 12,
            ),
            Text(
              userManagement.localUser == null
                  ? " - "
                  : ("${userManagement.localUser?.firstName}"),
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      ),
    );
  }
}
