import 'dart:convert';
import 'package:chores/main.dart';
import 'package:http/http.dart' as http;

import '../models/User.dart';
import 'api_constants.dart';

class HttpService {

  Future<bool> login(String email, String password) async {
    bool ifLogged = false;
    User user = User("",email,password);
    String url = ApiConstants.baseUrl + ApiConstants.loginEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
        body: json.encode({'email': user.email, 'password': user.password}));
    if (res.statusCode == 200){

      bool ifSetTokenSuccess = await getToken(email, password);
      if (ifSetTokenSuccess){
        ifLogged = true;
      }
    }
    return ifLogged;
  }

  Future<bool> getToken(String email, String password) async{
    String url = ApiConstants.baseUrl + ApiConstants.authenticateEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type":"application/json",
          "Accept": "application/json"
        },
        body: json.encode({'nickname': email, 'password': password})
    );
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200){
      final parsedJson = jsonDecode(res.body) as Map;
      if (parsedJson.containsKey('jwtToken')){
        await storage.write(key: 'jwt', value: parsedJson['jwtToken']);
        return true;
      }else{
        return false;
      }
    }else {
      return false;
    }

  }

}
