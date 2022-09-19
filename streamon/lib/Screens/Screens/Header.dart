import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/TextField.dart';
import '../../Providers/NavigationManagement.dart';
import '../../Providers/UserManagement.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Image.asset(
            "assets/logo.png",
            height: 50,
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            "Stream On",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(child: Container()),
          PersonalTextField(
              width: 250,
              controller: TextEditingController(),
              onChanged: (String? input) {},
              isDense: true,
              prefix: Icon(Icons.search)),
          SizedBox(
            width: 20,
          ),
          Row(
              children: ["News", "Fixtures", "Coaches", "Fan Merch", "Discover"]
                  .asMap()
                  .entries
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          print(context.read<NavigationManagement>().index);
                          context.read<NavigationManagement>().index = e.key;
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              e.value,
                              style: TextStyle(
                                fontSize: 14,
                                color: context
                                            .watch<NavigationManagement>()
                                            .index ==
                                        e.key
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.4),
                              ),
                            ),
                            Container(
                              width: 30,
                              height: 5,
                              color:
                                  context.watch<NavigationManagement>().index ==
                                          e.key
                                      ? Colors.white
                                      : Colors.white.withOpacity(0.1),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList()),
          // GestureDetector(onTap: (){
          // print("onTap");
          // },
          //   onTapDown: (TapDownDetails details) {
          //   print("hwllo world");
          //     showMenu(
          //         context: context,
          //         position: RelativeRect.fromLTRB(details.globalPosition.dx,
          //             details.globalPosition.dy, 0, 0),
          //         items: <Widget>[
          //           getPopupMenuButton(context),
          //           Row(
          //             children: [
          //               Icon(Icons.password),
          //               SizedBox(
          //                 width: 12,
          //               ),
          //               Text("Change Password"),
          //             ],
          //           ),
          //           Row(
          //             children: [
          //               Icon(Icons.logout),
          //               SizedBox(
          //                 width: 12,
          //               ),
          //               Text("Logout"),
          //             ],
          //           )
          //         ].map((e) => PopupMenuItem(child: e)).toList());
          //   },
          //   child: getPopupMenuButton(context),
          // ),
          PopupMenuButton(
            itemBuilder: (_) {
              return <Widget>[
                getPopupMenuButton(context),
                Row(
                  children: [
                    Icon(Icons.password),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Change Password"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.logout),
                    SizedBox(
                      width: 12,
                    ),
                    Text("Logout"),
                  ],
                )
              ].map((e) => PopupMenuItem(child: e)).toList();
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
