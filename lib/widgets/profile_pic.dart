import 'package:flutter/material.dart';

Widget profile({String photo,double width,double height, Color color}){
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(photo),
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.all(Radius.circular(60.0)),
      border: Border.all(
        color: color,
        width: 1.0,
      ),
    ),
  );
}