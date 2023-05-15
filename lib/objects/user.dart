class MyUser
{
  String email;
  String? sdt;
  String? anh;
  String? hoten;
  String? ngaySinh;
  String? diaChi;
  String? cccd;

  MyUser({required this.email, this.sdt, this.anh, this.hoten, this.ngaySinh, this.cccd, this.diaChi});

  factory MyUser.fromJson(Map<String, dynamic> json)
  {
    return MyUser(
        email: json["email"] as String,
        anh: json["pfp"] as String?,
        hoten: json["name"] as String,
        ngaySinh: json["dob"] as String,
        diaChi: json["address"] as String,
        cccd: json["cccd"] as String,
        sdt: json["phone"] as String,
    );
  }
  
  String getNgaySinh()
  {
    var dob = DateTime.parse(ngaySinh!);
    return dob.day.toString() + "/" + dob.month.toString() + "/" + dob.year.toString();
  }
  
  Map<String, dynamic> toJson()
  {
    return {
      "email": this.email,
      "pfp": this.anh,
      "name": this.hoten,
      "address": this.diaChi,
      "dob": this.ngaySinh,
      "cccd": this.cccd,
      "phone": this.sdt
    };
  }
}