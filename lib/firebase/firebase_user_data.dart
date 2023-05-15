import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_app/objects/user.dart';

class UserSnapshot
{
  MyUser? user;
  DocumentReference? documentReference;

  UserSnapshot({required this.user, required this.documentReference});

  factory UserSnapshot.fromSnapshot(DocumentSnapshot snapshot)
  {
    return UserSnapshot(
        user: MyUser.fromJson(snapshot.data() as Map<String, dynamic>),
        documentReference: snapshot.reference
    );
  }

  static Future<DocumentReference> addUser(MyUser user) async
  {
    return FirebaseFirestore.instance.collection("Users").add(user.toJson());
  }

  void capNhat(MyUser user) async
  {
    return await documentReference!.update(user.toJson());
  }

  static Stream<UserSnapshot> userFromFirebase(MyUser usr)
  {
    Stream<QuerySnapshot> qs = FirebaseFirestore.instance.collection("Users").where("email", isEqualTo: usr.email).snapshots();
    Stream<DocumentSnapshot> streamDocSnap = qs.map((queryInfo) => queryInfo.docs.single);

    return streamDocSnap.map((snapshot) => UserSnapshot.fromSnapshot(snapshot));
  }
}