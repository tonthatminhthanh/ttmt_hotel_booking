import 'package:flutter/material.dart';
import 'package:hotel_booking_app/app_pages/user_profile_editor.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';

class UserProfileView extends StatelessWidget {
  UserSnapshot? user;
  String? ngaySinh;
  UserProfileView({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder(
        stream: UserSnapshot.userFromFirebase(user!.user!),
        builder: (context, snapshot) {
          if(snapshot.hasError)
            {
              return Column(
                children: [
                  Icon(Icons.warning, color: Colors.red,),
                  Text("Không thể lấy dữ liệu người dùng từ Firestore!")
                ],
              );
            }
          else
            {
              if(!snapshot.hasData)
                return CircularProgressIndicator();
              else
                {
                  var userSnapshot = snapshot.data;
                  double labelSize = 18, valueSize = 32;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: userSnapshot?.user!.anh != null ? Image.network(userSnapshot!.user!.anh!, width: 150, height: 150,) :
                        Image.asset("media/placeholder.png"),
                      ),
                      Text("Họ tên:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.hoten!,style: TextStyle(fontSize: valueSize),),
                      Text("Căn cước công dân:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.cccd!,style: TextStyle(fontSize: valueSize),),
                      Text("Email:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.email!,style: TextStyle(fontSize: valueSize),),
                      Text("Số điện thoại:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.sdt!,style: TextStyle(fontSize: valueSize),),
                      Text("Ngày sinh:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.getNgaySinh(),style: TextStyle(fontSize: valueSize),),
                      Text("Địa chỉ:",style: TextStyle(fontSize: labelSize),),
                      Text(userSnapshot!.user!.diaChi!,style: TextStyle(fontSize: valueSize),),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => UserEditorPage(user: userSnapshot),));
                            },
                            child: Text("Sửa đổi")
                        ),
                      ),
                    ],
                  );
                }
            }
        },
      ),
    );
  }
}

