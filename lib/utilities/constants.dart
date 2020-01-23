import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


spinner(){
  return Center(
    child: SpinKitCircle(
      itemBuilder: (_, int index) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: index.isEven
                ? Colors.red
                : Colors.grey,
          ),
        );
      },
    ),
  );
}
