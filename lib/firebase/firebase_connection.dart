import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import '../utilities/utilities.dart';

class FirebaseConnectionPage extends StatefulWidget {
  String connectingMsg;
  String errorMsg;
  final Widget Function(BuildContext context)? builder;
  FirebaseConnectionPage({Key? key, required this.builder, required this.connectingMsg, required this.errorMsg}) : super(key: key);

  @override
  State<FirebaseConnectionPage> createState() => _FirebaseConnectionPageState();
}

class _FirebaseConnectionPageState extends State<FirebaseConnectionPage> {
  bool isConnected = false;
  bool hasError = false;
  @override
  Widget build(BuildContext context) {
    if(hasError)
      {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.warning,color: Colors.red,),
                Text(widget.errorMsg),
                ElevatedButton(onPressed: () {
                  setState(() {
                    hasError = false;
                    _establishConnection();
                  });
                }, child: Text("Thử lại"))
              ],
            ),
          ),
        );
      }
    else
      {
        if(!isConnected)
          {
            return Scaffold(
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text(widget.connectingMsg)
                  ],
                ),
              ),
            );
          }
        else
          {
            return widget.builder!(context);
          }
      }
  }

  @override
  void initState() {
    super.initState();
    _establishConnection();
  }

  void _establishConnection()
  {
    Firebase.initializeApp().then(
            (value) {
              setState(() {
                isConnected = true;
              });
              showSnackBar(context: context, message: "Welcome back!", duration: 2);
            }
    ).catchError(
            (error) {
              setState(() {
                hasError = true;
              });
              print("${error.toString()}");
            }
    );
  }
}

