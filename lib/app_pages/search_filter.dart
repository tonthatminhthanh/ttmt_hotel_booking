import 'package:flutter/material.dart';
import 'package:hotel_booking_app/objects/search.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  State<SearchFilter> createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  GlobalKey _formKey = GlobalKey<FormState>();
  String? defaultCity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                value: defaultCity,
                  items: cities.map((city)
                  => DropdownMenuItem<String>(child: Text(city), value: city,)
                  ).toList(),
                  decoration: InputDecoration(
                    labelText: "Thành phố"
                  ),
                  onChanged: (value) {
                    setState(() {
                      defaultCity = value;
                    });
                    MyFilter.setCity(city: value!);
                  },),
              TextButton(
                  onPressed: () {
                    setState(() {
                      defaultCity = cities[0];
                    });
                    MyFilter.setCity(city: cities[0]);
                  },
                  child: Text("Đặt lại"))
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    defaultCity = MyFilter().city != null ? MyFilter().city! : cities[0];
  }
}
