import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:geolocator/geolocator.dart';

import 'package:latlong2/latlong.dart';
import 'package:localies_app/services/db_service.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng _defaultLocation = LatLng(28.630777, 77.224372);
  Position? _currentPosition;
  LatLng? _currentLatLng;
  late MapController _mapController;
  List<Marker> _storeMarkers = [];
  double _rotation = 0.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentPosition();
    Future.delayed(Duration.zero, () {
      _fetchStoresLocation(context);
    });
    _mapController = MapController();
  }

  Future<void> _fetchStoresLocation(BuildContext context) async {
    final Size _size = MediaQuery.of(context).size;
    final stores = await DbService.getStores();
    setState(() {
      _storeMarkers = stores.map((store) {
        return Marker(
          width: _size.width * 0.08,
          height: _size.height * 0.04,
          point: LatLng(store.latitude, store.longitude),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.store,
              color: Colors.white,
              size: _size.width * 0.06,
            ),
          ),
        );
      }).toList();
    });
  }

  double _randomizeMarkersFromCurrentLocation(double value) {
    final random = Random();

    final value = _currentPosition!.longitude +
        (random.nextDouble() - 0.5) * 0.1; // -0.05 to 0.05

    return value;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _getLocationPermission(context);
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

        _currentLatLng =
            LatLng(_currentPosition!.latitude, _currentPosition!.longitude);

        // _mapController.move(_currentLatLng!, 13.0);
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  Future<bool> _getLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Page'),
      ),
      body: _currentPosition == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(
                    _defaultLocation.latitude, _defaultLocation.longitude),
                initialZoom: 14.2,
                initialRotation: _rotation,
              ),
              mapController: _mapController,
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  fallbackUrl: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  additionalOptions: {
                    'id': 'mapbox.streets',
                  },
                ),

                MarkerLayer(
                  markers: [
                    //default location marker
                    Marker(
                      point: LatLng(_defaultLocation.latitude,
                          _defaultLocation.longitude),
                      width: _size.width * 0.08,
                      height: _size.height * 0.04,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: _size.width * 0.06,
                          ),
                        ),
                      ),
                    ),

                    Marker(
                      width: _size.width * 0.08,
                      height: _size.height * 0.04,
                      point: LatLng(_currentPosition!.latitude,
                          _currentPosition!.longitude),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.location_on,
                            color: Colors.white,
                            size: _size.width * 0.06,
                          ),
                        ),
                      ),
                    ),
                    //all store markers
                    ..._storeMarkers,
                  ],
                ),
                // RichAttributionWidget(
                //   attributions: [
                //     TextSourceAttribution(
                //       'OpenStreetMap contributors',
                //       onTap: () => launchUrl(Uri.parse(
                //           'https://openstreetmap.org/copyright')),
                //     ),

                //   ],
                // ),

                Positioned(
                  top: 10,
                  right: 10,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, right: 10),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: MapCompass(
                          animationCurve: Curves.easeInOut,
                          onPressed: () {
                            _mapController.rotate(0.0);
                          },
                          icon: Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                          ),
                          hideIfRotatedNorth: false,
                        ),
                      ),
                      (MapOptions().initialRotation == 0.0)
                          ? Text(
                              'North',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 10,
                  child: Container(
                    // Zoom in button

                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.my_location_outlined,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _mapController.move(_currentLatLng!, 13.0);
                      },
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
