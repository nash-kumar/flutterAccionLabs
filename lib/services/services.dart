import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/emp_details.dart';
String  homeIpAddress = "192.168.0.106";
String phoneIpAddress = "192.168.43.128";
String server = "intranet.accionlabs.com";


getEmployeeData() async {
  try{
  var URL = "http://$phoneIpAddress:3005/employee/search-company-Employee-ative";
  http.Response response = await http.post(URL, body: {"gender": "Male"});
  if(response.statusCode == 200){
    var decodedData = jsonDecode(response.body);
    return decodedData;
  }}
  catch (err){
    return err;
  }
}

getEmployeeByEmail(email) async {
  try {
    var URL = "http://$phoneIpAddress:3005/employee/get-employeeid?id=$email";
    http.Response response = await http.get(URL);
    if(response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      print(decodedData);
      return decodedData;
    }if(response.statusCode == 400) {
      return "error";
    }
  } catch (err) {
    return err;
  }
}

Future<Map<String, dynamic>> logIn(email) async {
  try{
    var URL = "http://$phoneIpAddress:3005/user/login";
    http.Response response = await http.post(URL, body: {"empEmail": email});
    if(response.statusCode == 200) {
      var decodedData = jsonDecode(response.body);
      return decodedData;
    } if(response.statusCode == 404) {
      return {
        "error": "User not found in Accion group"
      };
    }
  } catch(err){
      return err;
  }
}