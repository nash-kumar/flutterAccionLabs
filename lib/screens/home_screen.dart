import 'package:flutter/material.dart';
import '../services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../widgets/list_employees.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isWaiting;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.red,),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white10, Colors.yellow[50]],
          )
        ),
          child: isWaiting ? spinner() : ListEmployees(employee)),
    );
  }

  List employee;

  getData() async {
    isWaiting = true;
    try {
      var data = await getEmployeeData();
      setState(() {
        employee = data["data"];
        isWaiting = false;
      });
    } catch (err) {
      print(err);
    }
  }

  Center spinner() {
    return Center(
      child: SpinKitCircle(
        itemBuilder: (_, int index) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: index.isEven ? Colors.red : Colors.grey,
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getData();
  }
}
