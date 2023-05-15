import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_app/objects/rating.dart';

class RatingSnapshot
{
  Rating rating;
  DocumentReference documentReference;

  RatingSnapshot({required this.rating, required this.documentReference});

  factory RatingSnapshot.fromSnapshot(DocumentSnapshot snapshot)
  {
    return RatingSnapshot(
        rating: Rating.fromJson(snapshot.data() as Map<String, dynamic>),
        documentReference: snapshot.reference);
  }

  static Future<DocumentReference> addUser(Rating rating) async
  {
    return FirebaseFirestore.instance.collection("Ratings").add(rating.toJson());
  }

  void capNhat(Rating rating) async {
    return await documentReference.update(rating.toJson());
  }

  static Future<DocumentSnapshot?> getSnapshot({required String userId, required String roomId}) async
  {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Ratings")
        .where("user_id",isEqualTo: userId)
        .where("room_id",isEqualTo: roomId).get();
    if(snapshot.docs.isEmpty)
      return null;
    return snapshot.docs.single;
  }

  static Future<double> getAverageScore({required String roomId}) async
  {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Ratings")
        .where("room_id",isEqualTo: roomId).get();
    if(snapshot.docs.isEmpty)
      {
        return 0.0;
      }
    int totalScore = 0;
    for(DocumentSnapshot snapshot in snapshot.docs)
      {
        totalScore += snapshot["score"] as int;
      }
    return totalScore / snapshot.docs.length;
  }
}