class Rating
{
  String userId, roomId;
  int score;

  Rating({required this.userId, required this.roomId, required this.score});

  factory Rating.fromJson(Map<String, dynamic> json)
  {
    return Rating(
        userId: json["user_id"] as String,
        roomId: json["room_id"] as String,
        score: json["score"] as int
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "user_id": userId,
      "room_id": roomId,
      "score": score
    };
  }
}