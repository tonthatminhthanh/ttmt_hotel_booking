import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({Key? key}) : super(key: key);

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              child: Image.network('https://images.careerbuilder.vn/content/images/cskh-1.jpg'),
            ),
          ),
          Text("Hỗ trợ khách hàng 24/7:",style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.red),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            child: Row(
              children: [
                Text("Fanpage: Hotel Room Booking", style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.facebook),
              ],
            ),
          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: ElevatedButton(
              onPressed: () async {
                final url = Uri.encodeFull('https://www.facebook.com/');
                await launchUrl(Uri.parse(url)).catchError((e) => print(e.toString()));
              },
              style: ElevatedButton.styleFrom(

                textStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              child: Text("Truy cập"),
            ),
          ),

          SizedBox(height: 10,),
          GestureDetector(
            child: Row(
              children: [
                Text("Đường dây nóng 1:",style: TextStyle(fontSize: 20),),
                Text(" 0123456789", style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.phone_forwarded),
              ],
            ),
            onTap: () async{
              const String _phone1 = "tel:0123456789";
              await launchUrl(Uri.parse(_phone1)).catchError((e) => print(e.toString()));
            },

          ),
          SizedBox(height: 10,),
          GestureDetector(
            child: Row(
              children: [
                Text("Đường dây nóng 2:",style: TextStyle(fontSize: 20),),
                Text(" 0987654321", style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20,
                  decoration: TextDecoration.underline,
                ),
                ),
                SizedBox(width: 10,),
                Icon(Icons.phone_forwarded),
              ],
            ),
            onTap: () async{
              const String _phone2 = "tel:0987654321";
              await launchUrl(Uri.parse(_phone2)).catchError((e) => print(e.toString()));
            },

          )
        ],
      ),
    );
  }
}
