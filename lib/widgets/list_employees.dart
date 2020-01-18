import 'package:flutter/material.dart';
import 'package:list_emp/screens/profile_screen.dart';
import 'package:list_emp/widgets/profile_pic.dart';
import "package:list_emp/models/emp_details.dart";

class ListEmployees extends StatelessWidget {
  final List employee;
  ListEmployees(this.employee);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: employee.length,
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
                            title: Text("${employee[index]["FirstName"]} ${employee[index]["LastName"]}", style: TextStyle(letterSpacing: 2.0),),
                            titlePadding: EdgeInsets.all(2.0),
                            content: Container(
                              width: 100,
                              height: 240,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(employee[index]["EmployeePhoto"]),
                                  fit: BoxFit.fill
                                ),
                              ),
                            )
                          ));
                },
                child: Container(
                  width: 60,
                  height: 100,
                  alignment: Alignment.center,
                  child: profile(photo: employee[index]["EmployeePhoto"], width: 70, height: 70, color: Colors.blue)
                ),
              ),

              title: Text("${employee[index]["FirstName"]} ${employee[index]["LastName"]} (${employee[index]["EmployeeID"]})"),
              subtitle: Text(employee[index]["EmailID"]),
              trailing: GestureDetector(
                onTap: () {
                  print("opened");
                },
                child: Container(
                    width: 90,
                    height: 50,
                    child: Text(employee[index]["Project"],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold))),
              ),
              isThreeLine: true,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen(employee[index])));
              },
            ),
          );
        });
  }
}
