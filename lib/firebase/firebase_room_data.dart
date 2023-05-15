import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hotel_booking_app/objects/room.dart';
import 'package:hotel_booking_app/objects/user.dart';

class RoomSnapshot
{
  Room room;
  DocumentReference documentReference;
  RoomSnapshot({required this.room, required this.documentReference});

  factory RoomSnapshot.fromSnapshot(DocumentSnapshot snapshot)
  {
    return RoomSnapshot(
        room: Room.fromJson(snapshot.data() as Map<String,dynamic>),
        documentReference: snapshot.reference);
  }

  static Future<DocumentReference> addRoom(Room newRoom)
  {
    return FirebaseFirestore.instance.collection("Rooms").add(newRoom.toJson());
  }

  void capNhat(Room room) async {
    return await documentReference.update(room.toJson());
  }

  static Stream<List<RoomSnapshot>> listFromFirebase()
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("Rooms").snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => RoomSnapshot.fromSnapshot(ds)).toList()
    );
  }

  static Stream<List<RoomSnapshot>> myListFromFirebase(MyUser user)
  {
    Stream<QuerySnapshot> streamQS = FirebaseFirestore.instance.collection("Rooms").where("email",isEqualTo: user.email).snapshots();
    Stream<List<DocumentSnapshot>> streamListDocSnap = streamQS.map(
            (queryInfo) => queryInfo.docs);
    return streamListDocSnap.map((listDS) => listDS.map((ds) => RoomSnapshot.fromSnapshot(ds)).toList()
    );
  }
}