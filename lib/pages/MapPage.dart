import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:local_eat/models/point.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Point> points = [
    Point(latitude: 45.759681, longitude: 4.855772, title: "Lyon"),
    Point(latitude: 48.856613, longitude: 2.352222, title: "Paris"),
    Point(latitude: 43.296482, longitude: 5.36978, title: "Marseille"),
    Point(latitude: 43.610769, longitude: 3.876716, title: "Montpellier"),
    Point(latitude: 43.604652, longitude: 1.444209, title: "Toulouse"),
    Point(latitude: 47.218371, longitude: -1.553621, title: "Nantes"),
    Point(latitude: 44.837789, longitude: -0.57918, title: "Bordeaux"),
    Point(latitude: 48.573405, longitude: 7.752111, title: "Strasbourg"),
    Point(latitude: 50.62925, longitude: 3.057256, title: "Lille"),
    Point(latitude: 49.258329, longitude: 4.031696, title: "Reims"),
    Point(latitude: 49.894067, longitude: 2.295753, title: "Amiens"),
    Point(latitude: 47.322047, longitude: 5.04148, title: "Dijon"),
    Point(latitude: 43.949317, longitude: 4.805528, title: "Nîmes"),
    Point(latitude: 43.710173, longitude: 7.261953, title: "Nice"),
    Point(latitude: 43.124228, longitude: 5.928, title: "Toulon"),
    Point(latitude: 45.764043, longitude: 4.835659, title: "Villeurbanne"),
    Point(latitude: 43.296482, longitude: 5.36978, title: "Aix-en-Provence"),
    Point(latitude: 48.117266, longitude: -1.677792, title: "Rennes"),
    Point(latitude: 43.604652, longitude: 1.444209, title: "Blagnac"),
    Point(latitude: 48.573405, longitude: 7.752111, title: "Schiltigheim"),
  ];

  Future<List<Point>> getPointNearby(LatLng center, double radius) async {
    List<Point> tempPoints = [];
    try {

      final resp = await http.post(Uri.parse("https://backend-localeat.azurewebsites.net/login"),body: {
        "email":"guiletttjulien@gmail.com",
        "password":"jguilet"
      });
      print(resp.body);



      final response = await http.get(Uri.parse("https://backend-localeat.azurewebsites.net/locations/6/4/7"),
          headers: {
            "Content-Type": "application/json",
            HttpHeaders
                .authorizationHeader: jsonDecode(resp.body)["body"]["jwt"]
          });
      print(response.body);
      List<dynamic> jsonBody = jsonDecode(
//         '''
//     [
//     {
//         "_id": {
//             "\$oid": "655e210b458025af823e80da"
//         },
//         "title": "un titre",
//         "pointtype": "un type",
//         "position": {
//             "Location_coordinates": [
//                 "3",
//                 "5"
//             ],
//             "Location_type": "Point"
//         }
//     }
// ]
//     '''??
          response.body);

      for (var i = 0; i < jsonBody.length; i++) {
        final toParse = jsonBody[i]["position"]["Location_coordinates"];
        double longitude = toParse[0] is String ? double.parse(toParse[0]) : toParse[0];
        double latitude = toParse[1] is String ? double.parse(toParse[1]) : toParse[1];
        String title = jsonBody[i]["title"];
        tempPoints.add(Point(latitude: latitude, longitude: longitude, title: title));
      }
    } catch (e) {
      print(e);
    }
    return tempPoints;
  }

  @override
  void initState() {

    // getPointNearby(LatLng(45.759681, 4.855772), 1000).then((value) => setState(() {
    //   points = value;
    // }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: const SearchBar(),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload),
            onPressed: true? null : () {

              getPointNearby(LatLng(45.759681, 4.855772), 1000).then((value) => setState(() {
                points = value;
              }));

            },
          ),],
      ),
      body: FlutterMap(
        options: MapOptions(center: LatLng(45.759681, 4.855772), zoom: 13.0),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          CurrentLocationLayer(
            style: LocationMarkerStyle(
              markerDirection: MarkerDirection.heading,
              marker: const DefaultLocationMarker(
                color: Colors.green,
                child: Icon(
                  Icons.location_on,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(30),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 100,
            ),
          ),
          MarkerLayer(
            rotate: true,
            markers: [
              ...points.map(
                (point) => Marker(
                  anchorPos: AnchorPos.align(AnchorAlign.center),
                  width: 40.0,
                  height: 40.0,
                  point: LatLng(point.latitude, point.longitude),
                  builder: (BuildContext context) {
                    return const Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 20,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
