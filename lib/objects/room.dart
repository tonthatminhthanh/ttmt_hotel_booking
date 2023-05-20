class Room
{
  String title, email, thanhPho, thoiGian, thongTin, diaChi;
  String? buyerEmail;
  int gia;
  List<dynamic> photos;

  Room({required this.title, required this.email, required this.thanhPho, required this.thoiGian, required this.thongTin,
    required this.diaChi, required this.gia, required this.photos, this.buyerEmail});

  factory Room.fromJson(Map<String, dynamic> json)
  {
    return Room(
        title: json["title"] as String,
        email: json["email"] as String,
        thanhPho: json["thanh_pho"] as String,
        thoiGian: json["thoi_gian"] as String,
        thongTin: json["thongtin"] as String,
        diaChi: json["diachi"] as String,
        gia: json["gia"] as int,
        photos: json["photos"] as List<dynamic>,
        buyerEmail: json["buyer_email"] as String?
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "title": title,
      "email": email,
      "thanh_pho": thanhPho,
      "thoi_gian": thoiGian,
      "thongtin": thongTin,
      "diachi": diaChi,
      "gia": gia,
      "photos": photos,
      "buyer_email": buyerEmail
    };
  }

  Room rent(String? buyerEmail)
  {
    this.buyerEmail = buyerEmail;
    return this;
  }
}