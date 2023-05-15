import 'package:flutter/material.dart';
import 'package:hotel_booking_app/objects/search.dart';

List<String> thoiGians = [
  'ngày','tháng','năm'
];

class AddRoomPage extends StatefulWidget {
  const AddRoomPage({Key? key}) : super(key: key);

  @override
  State<AddRoomPage> createState() => _AddRoomPageState();
}

class _AddRoomPageState extends State<AddRoomPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtTitle = TextEditingController();
  TextEditingController txtAddress = TextEditingController();
  TextEditingController txtGia = TextEditingController();
  TextEditingController txtDetails = TextEditingController();
  String? _cityName, _dvThoiGian;
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
            ],
          ),
        ),
      ),
    );
  }
}
