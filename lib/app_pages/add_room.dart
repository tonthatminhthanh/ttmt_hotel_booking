import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hotel_booking_app/firebase/firebase_room_data.dart';
import 'package:hotel_booking_app/objects/search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:image_picker/image_picker.dart';

import '../firebase/firebase_user_data.dart';
import '../objects/room.dart';
import '../utilities/utilities.dart';

List<String> thoiGians = [
  'ngày','tháng','năm'
];

class AddRoomPage extends StatefulWidget {
  UserSnapshot user;
  AddRoomPage({Key? key, required this.user}) : super(key: key);

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  UserSnapshot? user;
  XFile? file;
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtDetails = TextEditingController();
  String? _cityName, _dvThoiGian;
  ImagePicker picker = ImagePicker();
  List<String> imageLinks = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mở phòng cho thuê"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: imageLinks.length == 0 ? SizedBox(
                  width: 150,
                  height: 150,
                  child: Container(
                    color: Colors.grey,
                    child: Icon(Icons.image, color: Colors.white,),
                  ),
                ) : CarouselSlider.builder(
                    itemCount: imageLinks.length,
                    itemBuilder: (context, index, realIndex) {
                      return Column(
                        children: [
                          Expanded(flex: 1, child: Image.network(imageLinks[index],width: 250,height: 250,),),
                          IconButton(onPressed: () {
                            setState(() {
                              imageLinks.removeAt(index);
                            });
                          }, icon: Icon(Icons.remove_circle, color: Colors.red,))
                        ],
                      );
                    },
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeFactor: 2,
                        viewportFraction: 1
                    )
                )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: () {
                    _recvImage(src: ImageSource.camera);
                  }, icon: Icon(Icons.camera_alt)),
                  IconButton(onPressed: () {
                    _recvImage(src: ImageSource.gallery);
                  }, icon: Icon(Icons.image)),
                ],
              ),
              TextFormField(
                  controller: txtTitle,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập tiêu đề";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Tiêu đề của phòng",
                      hintText: "Nhập tiêu đề của phòng"
                  ),keyboardType: TextInputType.name
              ),
              TextFormField(
                  controller: txtAddress,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập địa chỉ";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Địa chỉ của phòng",
                      hintText: "Nhập địa chỉ của phòng"
                  ),keyboardType: TextInputType.streetAddress
              ),
              DropdownButtonFormField<String>(
                items: cities.map((city)
                => DropdownMenuItem<String>(child: Text(city), value: city,)
                ).toList(),
                decoration: InputDecoration(
                    labelText: "Thành phố"
                ),
                onChanged: (value) {
                  setState(() {
                    _cityName = value;
                  });
                },),
              TextFormField(
                  controller: txtGia,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập giá";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Giá thuê của phòng",
                      hintText: "Nhập giá thuê của phòng"
                  ),keyboardType: TextInputType.number
              ),
              DropdownButtonFormField<String>(
                items: thoiGians.map((thoiGian)
                => DropdownMenuItem<String>(child: Text(thoiGian), value: thoiGian,)
                ).toList(),
                decoration: InputDecoration(
                    labelText: "Đơn vị thời gian"
                ),
                onChanged: (value) {
                  setState(() {
                    _dvThoiGian = value;
                  });
                },),
              TextFormField(
                controller: txtDetails,
                  validator: (value) {
                    if(value == null || value.isEmpty)
                      return "Vui lòng nhập thông tin";
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Thông tin của phòng",
                      hintText: "Nhập thông tin của phòng"
                  ),keyboardType: TextInputType.text, maxLines: null,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if(_formKey.currentState!.validate())
                    {
                      if(_cityName == null || _dvThoiGian == null || imageLinks.length == 0)
                        {
                          showSnackBar(context: context, message: "Vui lòng chọn giá trị!", duration: 2);
                        }
                      else
                        {
                          _themPhong();
                          Navigator.pop(context);
                        }
                    }
                  },
                  child: Text("Thêm phòng"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _recvImage({required ImageSource src}) async
  {
    file = await picker.pickImage(source: src);

    if(file == null)
    {
      return;
    }

    Reference fileDirRef = FirebaseStorage.instance.ref().child("photos");
    Reference fileRef = fileDirRef.child("${user!.documentReference?.id}_${Random().nextInt(1000)}_${DateTime.now().millisecondsSinceEpoch}");

    String? imageUrl;

    await fileRef.putFile(File(file!.path))
        .catchError((e) => print(e.toString()))
        .then((value) async {
      imageUrl = await fileRef.getDownloadURL();
      print(imageUrl);
    });

    setState(() {
      file = file;
      imageLinks.add(imageUrl!);
    });
  }

  @override
  void initState() {
    user = widget.user;
  }

  void _themPhong()
  {
      RoomSnapshot.addRoom(Room(
        title: txtTitle.text,
        diaChi: txtAddress.text,
        email: user!.user!.email,
        gia: int.parse(txtGia.text),
        photos: imageLinks,
        thanhPho: _cityName!,
        thoiGian: _dvThoiGian!,
        thongTin: txtDetails.text
      ));
  }
}
