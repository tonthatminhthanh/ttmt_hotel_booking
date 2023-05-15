import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SharePage extends StatelessWidget {
  SharePage({Key? key}) : super(key: key);
  TextEditingController txtSDT = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: 100,height: 50,),
            Icon(Icons.share_rounded),
            SizedBox(width: 10,),
            Text("Chia sẻ với bạn bè!!",  style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),),
          ],
        ),
        TextFormField(
          controller: txtSDT,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: "Số điện thoại của bạn bè của bạn",
          ),
        ),
        Row(
          children: [
            SizedBox(width: 70,),
            Icon(Icons.emoji_emotions_rounded),
            SizedBox(width: 10,),
            Text("Mời bạn bè cùng nhau tải app!!", style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 18,
            ),)
          ],
        ),
        SizedBox(height: 30,),
        Center(
          child: Container(
            child: Image.asset("media/invite.jpg" , fit: BoxFit.fill,),
          ),
        ),
        SizedBox(height: 20,),
        ElevatedButton.icon(
          onPressed: () {
            _launchSMS();
          },
          icon: Icon(Icons.share_sharp),
          label: Text('Chia Sẻ'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            elevation: 5,
            shadowColor: Colors.black,
          ),
        ),
      ],
    );
  }

  void _launchSMS() async {
    final phoneNumber = 'smsto:' + txtSDT.text;
    const message = 'Chào bạn, xin mời bạn tải app Hotel Room Booker!';
    final url = '$phoneNumber?body=$message';
    await launchUrl(Uri.parse(url)).catchError((e) => print(e.toString()));
  }
}