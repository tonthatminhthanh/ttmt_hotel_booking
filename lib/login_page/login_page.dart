import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPasswd = TextEditingController();
  bool _hidePass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng nhập")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(controller: txtEmail,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Nhập địa chỉ email của bạn"
            ),keyboardType: TextInputType.emailAddress,
          ),
          Row(
            children: [
              Expanded(
                  child: TextFormField(controller: txtPasswd, obscureText: _hidePass,
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
          ElevatedButton(
              onPressed: () {

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
              IconButton(
                  onPressed: () {

                  },
                  icon: Image.asset("media/phone_icon.png")
              )
            ],
          )
        ],
      ),
    );
  }
}
