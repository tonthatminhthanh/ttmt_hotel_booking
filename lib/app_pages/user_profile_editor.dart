import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/firebase_user_data.dart';
import '../utilities/utilities.dart';

class UserEditorPage extends StatefulWidget {
  UserSnapshot user;
  UserEditorPage({Key? key, required this.user}) : super(key: key);

  @override
  State<UserEditorPage> createState() => _UserEditorPageState();
}

class _UserEditorPageState extends State<UserEditorPage> {
  UserSnapshot? user;
  ImagePicker picker = ImagePicker();
  XFile? file;
  final _formKey = GlobalKey<FormState>();
  TextEditingController? txtName;
  TextEditingController? txtSDT;
  TextEditingController? txtDOB;
  TextEditingController? txtAddress;
  String? imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin cá nhân"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              file != null ? Image.file(File(file!.path))
              : user!.user!.anh != null ? Image.network(user!.user!.anh!) : Image.asset("media/placeholder.png"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async {
                        _recvImage(src: ImageSource.camera);
                      },
                    icon: Icon(Icons.camera_alt),
                  ),
                  IconButton(
                    onPressed: () async {
                      _recvImage(src: ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                  ),
                ]
              ),
              TextFormField(
                  controller: txtName,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập họ tên của bạn";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Họ tên",
                      hintText: "Nhập họ tên của bạn"
                  ),keyboardType: TextInputType.name
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(controller: txtDOB,
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
                        txtDOB!.text = pickedDate.toString().substring(0,10);
                      },
                      icon: Icon(Icons.calendar_month)),
                ],
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
              TextFormField(controller: txtAddress,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập địa chỉ của bạn";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Địa chỉ",
                      hintText: "Nhập địa chỉ của bạn",
                  ),keyboardType: TextInputType.text),
              SizedBox(height: 5,),
              ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                    {
                      _suaDoi();
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Sửa")
              )
            ],
          ),
        ),
      ),
    );
  }


  @override
  void initState() {
    user = widget.user;
    txtName = TextEditingController(text: user!.user!.hoten);
    txtDOB = TextEditingController(text: user!.user!.ngaySinh);
    txtSDT = TextEditingController(text: user!.user!.sdt);
    txtAddress = TextEditingController(text: user!.user!.diaChi);
  }

  void _suaDoi()
  {
    user!.user!.hoten = txtName!.text;
    user!.user!.ngaySinh = txtDOB!.text;
    user!.user!.sdt = txtSDT!.text;
    user!.user!.diaChi = txtAddress!.text;
    user!.user!.anh = imageUrl;
    user!.capNhat(user!.user!);
  }

  void _recvImage({required ImageSource src}) async
  {
    file = await picker.pickImage(source: src);

    if(file == null)
    {
      return;
    }

    Reference fileDirRef = FirebaseStorage.instance.ref().child("user_pfp");
    Reference fileRef = fileDirRef.child("${user!.documentReference?.id}");

    await fileRef.putFile(File(file!.path))
        .catchError((e) => print(e.toString()))
        .then((value) async {
      imageUrl = await fileRef.getDownloadURL();
      print(imageUrl);
    });

    setState(() {
      imageUrl = imageUrl;
    });
  }
}
