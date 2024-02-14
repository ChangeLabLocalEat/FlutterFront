import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:local_eat/models/point.dart';


class MapRepository {
  final String url;

  MapRepository([String? url]) : url = url ?? "https://backend-localeat.azurewebsites.net/locations/";

  Future<List<Point>> getPointNearby(LatLng center, double radius, String jwtToken) async {
    List<Point> tempPoints = [];
      print("$url${center.longitude}/${center.latitude}/$radius");
      final response = await http.get(
        Uri.parse("$url${center.longitude}/${center.latitude}/$radius",),
        headers: {"Content-Type": "application/json", HttpHeaders.authorizationHeader: jwtToken},
      );
      List<dynamic> jsonBody = jsonDecode(response.body);
      for (var i = 0; i < jsonBody.length; i++) {
        try {
          final toParse = jsonBody[i]["position"]["coordinates"];
          double longitude = toParse[0] is String ? double.parse(toParse[0]) : toParse[0];
          double latitude = toParse[1] is String ? double.parse(toParse[1]) : toParse[1];
          String title = jsonBody[i]["title"];
          String pointtype = jsonBody[i]["pointtype"];
          List<String> tags = jsonBody[i]["tags"].cast<String>();
          tempPoints.add(Point(latitude: latitude, longitude: longitude, title: title, pointtype: pointtype, tags: tags));
        } catch (e) {
          print(e);
        }
      }
    return tempPoints;
  }
}
