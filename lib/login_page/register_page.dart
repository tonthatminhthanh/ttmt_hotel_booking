import 'package:flutter/material.dart';
import 'package:hotel_booking_app/firebase/firebase_user_data.dart';
import 'package:hotel_booking_app/objects/user.dart';
import 'package:hotel_booking_app/utilities/utilities.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  bool _hidePass = true;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtCCCD = TextEditingController();
  TextEditingController txtBDay = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtSDT = TextEditingController();
  TextEditingController txtPasswd = TextEditingController();
  TextEditingController txtRePasswd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Đăng ký tài khoản"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(controller: txtName,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập họ tên của bạn";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Họ tên",
                      hintText: "Nhập họ tên của bạn"
                  ),keyboardType: TextInputType.name),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(controller: txtBDay,
                        validator: (value) {
                          if(value == null || value.isEmpty)
                            showSnackBar(context: context, message: "Vui lòng nhập ngày sinh của bạn", duration: 2);
                          return null;
                        },
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "Ngày sinh",
                          hintText: "Nhập ngày sinh của bạn",
                        ),
                      )
                  ),
                  IconButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.parse("19000101"),
                            lastDate: DateTime.now());
                        txtBDay.text = pickedDate.toString().substring(0,10);
                      },
                      icon: Icon(Icons.calendar_month))
                ],
              ),
              TextFormField(controller: txtAddress,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập địa chỉ của bạn";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Địa chỉ",
                      hintText: "Nhập địa chỉ của bạn"
                  ),keyboardType: TextInputType.text),
              TextFormField(controller: txtCCCD,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập số CCCD của bạn";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Số căn cước/chứng minh nhân dân",
                      hintText: "Nhập số ID của bạn"
                  ),keyboardType: TextInputType.number),
              TextFormField(controller: txtEmail,
                validator: (value) {
                  if(value == null || value.isEmpty)
                    return "Vui lòng nhập email của bạn";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Nhập địa chỉ email của bạn"
                ),keyboardType: TextInputType.emailAddress,
              ),
              TextFormField(controller: txtSDT,
                validator: (value) {
                  if(value == null || value.isEmpty)
                    return "Vui lòng nhập số điện thoại của bạn";
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Số điện thoại",
                    hintText: "Nhập số điện thoại của bạn"
                ),keyboardType: TextInputType.phone,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(controller: txtPasswd, obscureText: _hidePass,
                        validator: (value) {
                          if(value == null || value.isEmpty)
                            return "Vui lòng nhập mật khẩu của bạn";
                          return null;
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
              TextFormField(controller: txtRePasswd, obscureText: true,
                validator: (value) {
                  if(value != txtPasswd.text)
                    return "Vui lòng nhập lại mật khẩu đúng với mật khẩu bạn đã nhập";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nhập lại mật khẩu",
                  hintText: "Nhập lại mật khẩu của bạn",
                ),keyboardType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                      {
                        _dangKy();
                      }
                  },
                  child: Text("Đăng ký")
              )
            ],
          ),
        ),
      ),
    );
  }

  void _dangKy() async
  {
    MyUser newUser = MyUser(
        email: txtEmail.text,
        sdt: txtSDT.text,
        hoten: txtName.text,
        cccd: txtCCCD.text,
        diaChi: txtAddress.text,
        ngaySinh: txtBDay.text,
    );

    var user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: txtEmail.text,
        password: txtPasswd.text
    ).catchError((e) {showSnackBar(context: context, message: "Lỗi: ${e.toString()}", duration: 2);})
        .whenComplete(() => UserSnapshot.addUser(newUser));
    showSnackBar(context: context, message: "Đã đăng ký tài khoản thành công!", duration: 2);
    Navigator.pop(context);
  }
}
