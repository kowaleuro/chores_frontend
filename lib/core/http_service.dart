import 'dart:convert';
import 'package:chores/main.dart';
import 'package:chores/models/Chore.dart';
import 'package:chores/models/Place.dart';
import 'package:http/http.dart' as http;

import '../models/User.dart';
import 'api_constants.dart';

class HttpService {

  Future<bool> login(String email, String password) async {
    bool ifLogged = false;
    User user = User("", email, password);
    String url = ApiConstants.baseUrl + ApiConstants.loginEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
        body: json.encode({'email': user.email, 'password': user.password}));
    if (res.statusCode == 200) {
      bool ifSetTokenSuccess = await getToken(email, password);
      if (ifSetTokenSuccess) {
        ifLogged = true;
      }
    }
    return ifLogged;
  }

  Future<bool> getToken(String email, String password) async {
    String url = ApiConstants.baseUrl + ApiConstants.authenticateEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: json.encode({'nickname': email, 'password': password})
    );
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 200) {
      final parsedJson = jsonDecode(res.body) as Map;
      if (parsedJson.containsKey('jwtToken')) {
        await storage.write(key: 'jwt', value: parsedJson['jwtToken']);
        await storage.write(key: 'email', value: email);
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> register(String email, String password, String nickname) async {
    User user = User(nickname, email, password);
    String url = ApiConstants.baseUrl + ApiConstants.registerEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control_Allow_Origin": "*",
        },
        body: json.encode({
          'email': user.email,
          'password': user.password,
          'nickname': user.nickname
        }));
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Place>?> getUserPlaces() async {
    String? email = await storage.read(key: 'email');
    String? token = await storage.read(key: 'jwt');
    String url = ApiConstants.baseUrl + ApiConstants.userPlacesEndpoint;
    final response = await http.get(
        Uri.parse(url).replace(queryParameters: {
          'email': email
        }),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
    );
    if (response.statusCode == 200) {
      var parsed = jsonDecode(response.body)["places"] as List;
      List<Place> placeList = parsed.map((tagJson) => Place.fromJson(tagJson))
          .toList();
      return placeList;
    } else {
      print('error');
      return null;
    }
  }

  Future<bool> createPlace(String placeName) async {
    String? token = await storage.read(key: 'jwt');
    String url = ApiConstants.baseUrl + ApiConstants.createPlaceEndpoint;
    var res = await http.post(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control_Allow_Origin": "*",
          'Authorization': 'Bearer $token'
        },
        body: json.encode({'placeName': placeName})
    );
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> createChore(Chore chore, int placeId) async {
    String? token = await storage.read(key: 'jwt');
    String url = ApiConstants.baseUrl + ApiConstants.createChoreEndpoint;
    var res = await http.post(
        Uri.parse(url).replace(queryParameters: {
          'placeId': placeId
        }.map((key, value) => MapEntry(key, value.toString()))),
        headers: {
          "Accept": "application/json",
          "content-type": "application/json",
          "Access-Control_Allow_Origin": "*",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(chore.toJson())
    );
    print(res.statusCode);
    print(res.body);
    if (res.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  Future<Place?> getPlaceById(int placeId) async {
    String? token = await storage.read(key: 'jwt');
    String url = ApiConstants.baseUrl + ApiConstants.getPlaceByIdEndpoint;
    final response = await http.get(
        Uri.parse(url).replace(queryParameters: {
          'placeId': placeId
        }.map((key, value) => MapEntry(key, value.toString()))),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Place place = Place.fromJson(json);
      return place;
    } else {
      print('error');
      return null;
    }
  }

  Future<Chore?> getChoreById(int choreId) async {
    print('g');
    String? token = await storage.read(key: 'jwt');
    String url = ApiConstants.baseUrl + '/api/v1/place/getChore';
    final response = await http.get(
        Uri.parse(url).replace(queryParameters: {
          'choreId': choreId
        }.map((key, value) => MapEntry(key, value.toString()))),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      Chore chore = Chore.fromJson(json);
      return chore;
    } else {
      print('error');
      return null;
    }
  }
}
