import 'package:flutter/material.dart';

class VeChungToi extends StatelessWidget {
  const VeChungToi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nhóm: ",style: TextStyle(fontSize: 35),),
          Text("Chủ đề: Làm về phát triển app Hotel Room Booking",style: TextStyle(fontSize: 32),),
          Text("Danh sách các thành viên:",style: TextStyle(fontSize: 32),),
          Text("Tôn Thất Minh Thành",style: TextStyle(fontSize: 32),),
          Text("Lớp: 62CNTT2",style: TextStyle(fontSize: 32),),
          Text("Lâm Phước Thịnh",style: TextStyle(fontSize: 32),),
          Text("Lớp: 62CNTT2",style: TextStyle(fontSize: 32),),
          Text("Nguyễn Văn Túc",style: TextStyle(fontSize: 32),),
          Text("Lớp: 62CNTT2",style: TextStyle(fontSize: 32),),
          Text("Đào Tuấn Nghĩa",style: TextStyle(fontSize: 32),),
          Text("Lớp: 62CNTT2",style: TextStyle(fontSize: 32),),
          Text("Giáo viên: Huỳnh Tuấn Anh",style: TextStyle(fontSize: 32),),
        ]
    );
  }
}
