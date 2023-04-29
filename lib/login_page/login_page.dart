import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_booking_app/app_pages/main_menu.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:hotel_booking_app/utilities/utilities.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPasswd = TextEditingController();
  bool _hidePass = true;
  bool _loggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(controller: txtEmail,
              validator: (value) {
                if(value != null)
                  return null;
                return "Bạn chưa nhập email!";
              },
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "Nhập địa chỉ email của bạn"
              ),keyboardType: TextInputType.emailAddress,
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(controller: txtPasswd, obscureText: _hidePass,
                      validator: (value) {
                        if(value != null)
                          return null;
                        return "Bạn chưa nhập mật khẩu!";
                      },
                      decoration: InputDecoration(
                        labelText: "Mật khẩu",
                        hintText: "Nhập mật khẩu của bạn",
                      ),keyboardType: TextInputType.visiblePassword,
                    )
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if(_hidePass)
                          _hidePass = false;
                        else
                          _hidePass = true;
                      });
                    },
                    icon: Icon(Icons.remove_red_eye))
              ],
            ),
            SizedBox(height: 5,),
            _loggingIn ? CircularProgressIndicator() : ElevatedButton(
                onPressed: () {
                  if(_formKey.currentState!.validate())
                  {
                    _dangNhap();
                  }
                },
                child: Text("Đăng nhập")
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {

                      },
                    icon: Image.asset("media/google_icon.png")
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _dangNhap() async
  {
    String userEmail = txtEmail.text;
    setState(() {
      _loggingIn = true;
    });
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: txtPasswd.text
    ).whenComplete(() async {
      print("Signed in!");
    }).catchError((e) {showSnackBar(context: context, message: "Lỗi firebase auth: " + e.toString(), duration: 2);setState(() {
      _loggingIn = false;
    });});
    var users = await FirebaseFirestore.instance.collection("Users").where("email", isEqualTo: userEmail)
        .limit(1)
        .get().then((event) {
      if(event.docs.isNotEmpty)
      {
        UserSnapshot snapshot = UserSnapshot.fromSnapshot(event.docs.single);
        print(snapshot.user!.hoten!);
        setState(() {
          _loggingIn = false;
        });
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => MainMenuPage(user: snapshot, userCredential: userCredential),));
      }
    }).catchError((e) {showSnackBar(context: context, message: "Lỗi Firestore: " + e.toString(), duration: 2);});
  }

  @override
  void dispose() {
    super.dispose();
    txtEmail.dispose();
    txtPasswd.dispose();
  }
}
