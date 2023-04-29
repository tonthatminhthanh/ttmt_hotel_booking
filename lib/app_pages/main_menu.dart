import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking_app/utilities/utilities.dart';

class MainMenuPage extends StatefulWidget {
  UserSnapshot user;
  UserCredential userCredential;
  MainMenuPage({Key? key, required this.user, required this.userCredential}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  UserSnapshot? usr;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("Trying to pop!");
        bool? confirm = await showWarningDialog(context: context, msg: "Bạn có muốn đăng xuất?");
        if(confirm!)
        {
          FirebaseAuth.instance.signOut();
        }
        print(confirm);
        Navigator.pop(context);
        return confirm;
      },
      child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {

                    },
                    icon: Icon(Icons.notifications))
              ],
            ),
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAccountsDrawerHeader(
                      currentAccountPicture: usr?.user!.anh != null ? CircleAvatar(child: Image.network(usr!.user!.anh!),) :
                      CircleAvatar(child: Icon(Icons.image_not_supported_outlined),),
                      accountName: Text(usr!.user!.hoten!),
                      accountEmail: Text(usr!.user!.email!)
                  ),
                  Expanded(
                      child: ListView(
                        children: [
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.search),
                              title: Text("Tìm kiếm"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.house),
                              title: Text("Danh sách phòng được đặt"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.person),
                              title: Text("Tài khoản của tôi"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.share),
                              title: Text("Mời bạn bè"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.phone),
                              title: Text("Gọi điện trợ giúp"),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {

                            },
                            child: ListTile(
                              leading: Icon(Icons.corporate_fare),
                              title: Text("Về chúng tôi"),
                            ),
                          ),
                        ],
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(onPressed: () async {
                        await Navigator.maybePop(context);
                      }, icon: Icon(Icons.logout)),
                    ],
                  )
                ],
              ),
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    usr = widget.user;
  }
}
