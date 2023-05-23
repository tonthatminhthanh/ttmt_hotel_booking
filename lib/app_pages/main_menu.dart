import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotel_booking_app/app_pages/about_page.dart';
import 'package:hotel_booking_app/app_pages/add_room.dart';
import 'package:hotel_booking_app/app_pages/room_list.dart';
import 'package:hotel_booking_app/app_pages/search_filter.dart';
import 'package:hotel_booking_app/app_pages/sharing_page.dart';
import 'package:hotel_booking_app/app_pages/support.dart';
import 'package:hotel_booking_app/app_pages/user_profile_view.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking_app/objects/menu_tiles.dart';
import 'package:hotel_booking_app/utilities/utilities.dart';

class MainMenuPage extends StatefulWidget {
  UserSnapshot user;
  UserCredential userCredential;
  MainMenuPage({Key? key, required this.user, required this.userCredential}) : super(key: key);

  @override
  State<MainMenuPage> createState() => _MainMenuPageState();
}

class _MainMenuPageState extends State<MainMenuPage> {
  int selectedTile = 0;
  String? appBarTitle;
  Widget? currentWidget;
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
          Navigator.pop(context);
        }
        print(confirm);
        return confirm;
      },
      child: Scaffold(
            appBar: AppBar(
              title: Text("$appBarTitle"),
            ),
            floatingActionButton: _assignFloatingWidget(index: selectedTile),
            drawer: Drawer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder(
                    stream: UserSnapshot.userFromFirebase(usr!.user!),
                      builder: (context, snapshot) {
                        if(snapshot.hasError)
                          {
                            return Icon(Icons.warning, color: Colors.red,);
                          }
                        else
                          {
                            if(!snapshot.hasData)
                              {
                                return CircularProgressIndicator();
                              }
                            else
                              {
                                var userSnap = snapshot.data;
                                return UserAccountsDrawerHeader(
                                    currentAccountPicture: userSnap?.user!.anh != null ? CircleAvatar(child: Image.network(userSnap!.user!.anh!),) :
                                    CircleAvatar(child: Icon(Icons.image_not_supported_outlined),),
                                    accountName: Text(userSnap!.user!.hoten!),
                                    accountEmail: Text(userSnap!.user!.email!)
                                );
                              }
                          }
                      },),
                  Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTile = index;
                                appBarTitle = tileTitles[selectedTile];
                                _assignWidget(index: index, user: usr!);
                              });
                            },
                            child: ListTile(
                              tileColor: selectedTile == index ? Colors.pinkAccent : Colors.white,
                              textColor: selectedTile == index ? Colors.white : Colors.black,
                              title: Text(tileTitles[index]),
                              trailing: tileIcons[index],
                            ),
                          ),
                          separatorBuilder: (context, index) => Divider(height: 2),
                          itemCount: tileTitles.length)
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
        body: currentWidget,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    usr = widget.user;
    appBarTitle = tileTitles[selectedTile];
    _assignWidget(index: 0, user: usr!);
  }

  Widget? _assignFloatingWidget({required int index})
  {
    switch(index)
    {
      case 0:
        return FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SearchFilter(),)
              );
            },
            child: Icon(Icons.manage_search));
      case 2:
        return FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddRoomPage(user: usr!),)
              );
            },
            child: Icon(Icons.add_business));
      default:
        return null;
    }
  }

  void _assignWidget({required int index, required UserSnapshot user})
  {
    List<Widget> widgetList = [
      RoomListPage(user: user, myRoom: false,myRent: false),
      RoomListPage(user: user, myRoom: false,myRent: true),
      RoomListPage(user: user, myRoom: true,myRent: false),
      UserProfileView(user: user),
      SharePage(),
      SupportPage(),
      VeChungToi(),
    ];

    setState(() {
      currentWidget = widgetList[index];
    });
  }
}
