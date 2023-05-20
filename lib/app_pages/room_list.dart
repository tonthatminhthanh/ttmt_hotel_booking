import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/app_pages/room_details.dart';
import 'package:hotel_booking_app/firebase/firebase_room_data.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:hotel_booking_app/objects/search.dart';

class RoomListPage extends StatefulWidget {
  UserSnapshot user;
  bool myRoom, myRent;
  RoomListPage({Key? key, required this.user, required this.myRoom, required this.myRent}) : super(key: key);

  @override
  State<RoomListPage> createState() => _RoomListPageState();
}

class _RoomListPageState extends State<RoomListPage> {
  UserSnapshot? user;
  TextEditingController txtSearch = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RoomSnapshot>>(
      stream: widget.myRoom ? RoomSnapshot.myListFromFirebase(user!.user!)
          : widget.myRent ? RoomSnapshot.rentListFromFirebase(user!.user!) :
      RoomSnapshot.listFromFirebase(),
        builder: (context, snapshot) {
          if(snapshot.hasError)
            {
              return Column(
                children: [
                  Icon(Icons.warning,color: Colors.red,),
                  Text(snapshot.error.toString())
                ],
              );
            }
          else
            {
              if(!snapshot.hasData)
                {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              else
                {
                  var list = snapshot.data!;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Flexible(
                          child: ListView.separated(
                              itemBuilder: (context, index) {
                                return getItem(context, list, index);
                              } ,
                              separatorBuilder: (context, index) => Divider(height: 2,),
                              itemCount: list.length)
                      )
                    ],
                  );
                }
            }
        },
    );
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    MyFilter().city = cities[0];
  }

  Widget getItem(BuildContext context, List<RoomSnapshot> list, int index)
  {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0,),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Image.network(list[index].room!.photos[0], width: 100,height: 100,)),
              GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context)
                          => RoomDetailsPage(
                              user: user!,
                              roomSnapshot: list[index]),
                        )
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list[index].room!.title, style: TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                      Text("Tại: ${list[index].room!.thanhPho}", style: TextStyle(fontSize: 16)),
                      Text("Giá: ${list[index].room!.gia}VND/${list[index].room!.thoiGian}", style: TextStyle(fontSize: 20, color: Colors.pinkAccent),),
                      widget.myRoom && list[index].room.buyerEmail != null ? Text("Liên hệ người thuê: ${list[index].room!.buyerEmail}") : Text("Liên hệ: ${list[index].room!.email}")
                    ],
                  )
              )
            ],
          )
        ],
      ),
    );
  }
}
