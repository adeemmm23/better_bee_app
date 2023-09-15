import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Location extends StatefulWidget {
  const Location({super.key});

  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final ref = FirebaseDatabase.instance.ref("location");
  BitmapDescriptor mapIcon = BitmapDescriptor.defaultMarker;
  double lat = 0;
  double lon = 0;

  @override
  void initState() {
    super.initState();
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(size: Size(1, 1)),
            'assets/images/location.png')
        .then((onValue) {
      mapIcon = onValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final location = snapshot.data!.snapshot.value as Map;
            if (location['lat'] == "Unknown" || location['lon'] == "Unknown") {
              return const Center(
                child: Text("No location data available"),
              );
            }
            lat = location['lat'];
            lon = location['lon'];
            return GoogleMap(
                compassEnabled: false,
                mapToolbarEnabled: false,
                zoomControlsEnabled: false,
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, lon),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                    markerId: const MarkerId('marker'),
                    position: LatLng(lat, lon),
                    icon: mapIcon,
                  )
                });
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.pop();
        },
        label: const Text('Get Back'),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }
}
