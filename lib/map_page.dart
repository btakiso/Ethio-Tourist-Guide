import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'widgets/shared_bottom_nav_bar.dart'; // Import the shared bottom navigation bar widget

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map')),
      body: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          center: LatLng(9.145, 40.489673),
          zoom: 6.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
      ),
      bottomNavigationBar: SharedBottomNavBar(selectedIndex: 0, onItemTapped: (int ) {  },), // Use the shared bottom navigation bar with the Map page index
    );
  }
}