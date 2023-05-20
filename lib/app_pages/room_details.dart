import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/firebase/firebase_rating_data.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:photo_view/photo_view.dart';
import '../firebase/firebase_room_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../objects/rating.dart';

class RoomDetailsPage extends StatefulWidget {
  UserSnapshot user;
  RoomSnapshot roomSnapshot;
  RoomDetailsPage({Key? key, required this.user, required this.roomSnapshot}) : super(key: key);

  @override
  State<RoomDetailsPage> createState() => _RoomDetailsPageState();
}

class _RoomDetailsPageState extends State<RoomDetailsPage> {
  UserSnapshot? user, seller;
  RoomSnapshot? roomSnapshot;
  RatingSnapshot? ratingSnapshot;
  double? currRating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${roomSnapshot!.room.title}"),
      ),
      floatingActionButton: roomSnapshot!.room!.email != user!.user!.email ? (
        roomSnapshot!.room!.buyerEmail != null ? FloatingActionButton(
          onPressed: () {
        roomSnapshot?.capNhat(roomSnapshot!.room.rent(null));
    Navigator.pop(context);
    },
    child: Icon(Icons.remove),
    ) : FloatingActionButton(
          onPressed: () {
            roomSnapshot?.capNhat(roomSnapshot!.room.rent(user!.user!.email));
            Navigator.pop(context);
          },
          child: Icon(Icons.add),
        )
      ) : FloatingActionButton(
        onPressed: () {
          roomSnapshot!.xoa();
          Navigator.pop(context);
        },
        child: Icon(Icons.remove),
      ),
      body: SingleChildScrollView(
        child: seller == null ? Center(
          child:
          CircularProgressIndicator(),
        ) : Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
                items: roomSnapshot!.room.photos.map(
                        (item) =>
                        PhotoView(
                            imageProvider: NetworkImage(item)
                        )
                ).toList(),
                options: CarouselOptions(
                    autoPlay: true,
                    enlargeFactor: 2,
                    viewportFraction: 1
                )
            ),
            Text("${roomSnapshot!.room.title}", style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 24,
                fontWeight: FontWeight.bold),
            ),
            Text("Người cho thuê: ${seller!.user!.hoten}", style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 16,
                fontWeight: FontWeight.bold),
            ),
            Text("Thông tin liên hệ:", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
            Text("Email: ${seller!.user!.email}", style: TextStyle(
              fontSize: 16,)),
            Text("Số điện thoại: ${seller!.user!.sdt}", style: TextStyle(
              fontSize: 16,)),
            roomSnapshot!.room.buyerEmail == user!.user!.email ? Text("Đánh giá cá nhân", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)) : Text("Đánh giá:", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
            roomSnapshot!.room.buyerEmail == user!.user!.email ? Row(
                children:
                List.generate(5, (index) => IconButton(
                    onPressed: () async {
                      setState(() {
                        currRating = index + 1;
                      });
                      if (ratingSnapshot == null) {
                        Rating rating = Rating(
                            userId: user!.documentReference!.id,
                            roomId: roomSnapshot!.documentReference!.id,
                            score: currRating!.round()
                        );
                        DocumentReference docRef = await RatingSnapshot
                            .addRating(rating);
                        ratingSnapshot = RatingSnapshot(
                            rating: rating, documentReference: docRef);
                      }
                      else {
                        ratingSnapshot!.capNhat(Rating(
                            userId: user!.documentReference!.id,
                            roomId: roomSnapshot!.documentReference!.id,
                            score: currRating!.round()
                        ));
                      }
                    },
                    icon: currRating != null && (index + 1) <= currRating!
                        ? Icon(Icons.star, color: Colors.pinkAccent,) :
                    Icon(Icons.star_border_outlined, color: Colors.black,)
                ))
            ) : Row(
              children: List.generate(5,
                      (index) => currRating != null && (index + 1) <= currRating!
                      ? Icon(Icons.star, color: Colors.pinkAccent,) :
                  Icon(Icons.star_border_outlined, color: Colors.black,)
                /**/
              ),
            ),
            Text(
              "Giá: ${roomSnapshot!.room.gia}/${roomSnapshot!.room.thoiGian}",
              style: TextStyle(
                  color: Colors.pinkAccent, fontSize: 24),
            ),
            Text("Địa chỉ: ${roomSnapshot!.room.diaChi}", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text("Thông tin chi tiết:", style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold)),
            Text(roomSnapshot!.room.thongTin, style: TextStyle(
                fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
    roomSnapshot = widget.roomSnapshot;
    _getSellerInfo();
    _getAverageRating();
    print(currRating);
  }

  void _getSellerInfo() async
  {
    var users = await FirebaseFirestore.instance.collection("Users").where(
        "email", isEqualTo: roomSnapshot!.room.email)
        .limit(1)
        .get().then((event) {
      if (event.docs.isNotEmpty) {
        UserSnapshot snapshot = UserSnapshot.fromSnapshot(event.docs.single);
        setState(() {
          seller = snapshot;
        });
      }
    });
  }

/*void _getMyRatingInfo() async
  {
    var snapshot = await RatingSnapshot.getSnapshot(userId: user!.documentReference!.id,
        roomId: roomSnapshot!.documentReference.id);
    if(snapshot != null)
      {
        ratingSnapshot = RatingSnapshot.fromSnapshot(snapshot);
        currRating = ratingSnapshot!.rating.score;
      }
  }*/
    void _getAverageRating() async
    {
      currRating = await RatingSnapshot.getAverageScore(roomId: roomSnapshot!.documentReference!.id!);
    }


}
