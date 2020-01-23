import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'home_screen.dart';

class ServerError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.stop_screen_share, size: 120,color: Colors.red,),
          Text("SERVER ERROR", style: TextStyle(fontSize: 30, color: Colors.black54),),
          FlatButton(onPressed: (){
//            HomeScreen.getData();
          }, child: Icon(Icons.refresh, size: 40,color: Colors.black54,))
        ],
      ),
    );
  }
}
