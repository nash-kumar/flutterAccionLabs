import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:accionlabs/screens/profile_screen.dart';
import 'package:accionlabs/widgets/profile_pic.dart';
import 'dart:async';

class ListEmployees extends StatefulWidget {
  final List employee;
  ListEmployees(this.employee);

  @override
  _ListEmployeesState createState() => _ListEmployeesState();
}

class _ListEmployeesState extends State<ListEmployees> {
  List filterEmp = [];
  var _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filterEmp = widget.employee;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: TextField(
            controller: _controller,
            maxLength: 40,
            maxLengthEnforced: true,
            decoration: InputDecoration(
              counter: Text(filterEmp.length.toString()),
                helperStyle: TextStyle(fontSize: 9),
                helperText: "search by Name, EmployeeID, Skills, Project, Email, PhoneNumber, Location",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      Future.delayed(Duration(milliseconds: 50)).then((_) {
                        _controller.clear();
                        FocusScope.of(context).unfocus();
                      });
//                      WidgetsBinding.instance.addPostFrameCallback( (_) => _controller.clear());
                      filterEmp = widget.employee;
                    });
                  },
                  child: Icon(
                    Icons.cancel,
                    size: 20,
                  ),
                ),
                hintText: "search"),
            onChanged: (string) {
              Future.delayed(Duration(milliseconds: 1000)).then((_){
                setState(() {
                  filter(string);
                });
              });
            },
            style: TextStyle(fontSize: 20),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: filterEmp.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 2.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: ListTile(
                    leading: GestureDetector(
                      onTap: () {
                        print("Clicked");
                        showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                                contentPadding: EdgeInsets.all(2.0),
                                title: Text(
                                  "${filterEmp[index]["FirstName"]} ${filterEmp[index]["LastName"]}",
                                  style: TextStyle(letterSpacing: 2.0),
                                ),
                                titlePadding: EdgeInsets.all(2.0),
                                content: Container(
                                  width: 100,
                                  height: 240,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            filterEmp[index]["EmployeePhoto"]),
                                        fit: BoxFit.fill),
                                  ),
                                )));
                      },
                      child: Container(
                          width: 60,
                          height: 100,
                          alignment: Alignment.center,
                          child: profile(
                              photo: filterEmp[index]["EmployeePhoto"],
                              width: 70,
                              height: 70,
                              color: Colors.blue)),
                    ),
                    title: Text(
                        "${filterEmp[index]["FirstName"]} ${filterEmp[index]["LastName"]} (${filterEmp[index]["EmployeeID"]})"),
                    subtitle: Text(filterEmp[index]["EmailID"]),
                    trailing: GestureDetector(
                      onTap: () {
                        print("opened");
                      },
                      child: Container(
                          width: 90,
                          height: 70,
                          child: Center(
                            child: Text(filterEmp[index]["Project"],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: filterEmp[index]["Project"].toLowerCase() == "bench" ? Colors.red : Colors.green,
                                    fontWeight: FontWeight.bold)),
                          )),
                    ),
                    isThreeLine: true,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProfileScreen(filterEmp[index])));
                    },
                  ),
                );
              }),
        ),
      ],
    );
  }

  filter(string) {
    filterEmp = widget.employee
        .where((emp) =>
            (emp["FirstName"].contains(string.toLowerCase())) ||
            (emp["LastName"].toLowerCase().contains(string.toLowerCase())) ||
            (emp["EmployeeID"].toLowerCase().contains(string.toLowerCase())) ||
            (emp["EmailID"].toLowerCase().contains(string.toLowerCase())) ||
            (emp["Work_location"].toLowerCase().contains(string.toLowerCase())) ||
            (emp["Mobile"].toLowerCase().contains(string.toLowerCase())) ||
              (emp["Expertise"].toLowerCase().contains(string.toLowerCase())) ||
            (emp["Project"].toLowerCase().contains(string.toLowerCase())))
        .toList();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

