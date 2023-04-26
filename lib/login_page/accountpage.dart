import 'package:flutter/material.dart';
import 'package:hotel_booking_app/firebase/firebase_connection.dart';
import 'package:hotel_booking_app/login_page/login_page.dart';
import 'package:hotel_booking_app/login_page/register_page.dart';

class EstablishConnectionPage extends StatelessWidget {
  const EstablishConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FirebaseConnectionPage(
        builder: (context) => AccountPage(),
        connectingMsg: "Đang kết nối",
        errorMsg: "không thể kết nối được với Firebase, xin thử lại.");
  }
}


class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: Image.asset("media/hotel_acc_banner.jpg", width: MediaQuery.of(context).size.width),
              ),
            ],
          ),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 125,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          )
                      );
                    },
                    child: Text("Đăng nhập"),
                  ),
                ),
                SizedBox(height: 15,),
                SizedBox(
                  width: 125,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ));
                    },
                    child: Text("Đăng ký"),
                  ),
                ),
              ],
            )
          )
        ],
      ),
    );
  }
}
