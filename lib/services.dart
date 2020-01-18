import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/emp_details.dart';
String  homeIpAddress = "192.168.0.104";
String phoneIpAddress = "192.168.43.128";
String server = "intranet.accionlabs.com";


getEmployeeData() async {
  var URL = "http://$homeIpAddress:3005/employee/search-company-Employee-ative";
  http.Response response = await http.post(URL, body: {"gender": "Male"});
  if(response.statusCode == 200){
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }
}