

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:latlong2/latlong.dart';
import 'package:local_eat/models/point.dart';
import 'package:local_eat/repositories/MapRepository.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Point> points = [
  ];
  MapRepository mapRepository = MapRepository("http://localhost:8000/locations/");


  @override
  void initState() {
    mapRepository.getPointNearby(const LatLng(45.759681, 4.855772), 1000,"a").then((value) => setState(() {
      points = value;
    }));
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
            onPressed:  () {
              print("test");
              mapRepository.getPointNearby(const LatLng(45.759681, 4.855772), 1000,"a").then((value) => setState(() {
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
