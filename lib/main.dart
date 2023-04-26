import 'package:flutter/material.dart';
import 'package:hotel_booking_app/login_page/accountpage.dart';

void main() {
  runApp(HotelBookingApp());
}

class HotelBookingApp extends StatelessWidget {
  const HotelBookingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EstablishConnectionPage(),
      theme: ThemeData(
          primarySwatch: Colors.pink,
      ),
    );
  }
}
