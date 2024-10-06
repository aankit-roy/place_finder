import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_finder/model/data_model/location_data.dart';

import 'package:place_finder/model/provider/location_provider.dart';
import 'package:provider/provider.dart';

import '../constants/app_colors.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  BitmapDescriptor? customIcon;
  @override
  void initState() {
    super.initState();
    _getCoordinates();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocationProvider>(context);

    if (provider.errorMessage != null) {
      NotificationFlushbar().show(context);
    }
    // Defer showing the SnackBar until the next frame
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (provider.errorMessage != null) {
    //     _showSnackbar(provider.errorMessage!);
    //   }
    // });

    return Scaffold(
      appBar: AppBar(title: Text(provider.location!)),
      body: provider.coordinates == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: provider.coordinates!,
                zoom: 14,
              ),
              markers: {
                Marker(
                    markerId: MarkerId('userLocation'),
                    position: provider.coordinates!),
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _findCurrentLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }

  void _getCoordinates() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    provider.getCoordinatesFromAddress(context);
  }

  void _findCurrentLocation() {
    final provider = Provider.of<LocationProvider>(context, listen: false);
    provider.findCurrentLocation(context);
  }

  Flushbar<dynamic> NotificationFlushbar() {
    return Flushbar(
        title:  "Permission Denied",
        message:  "Please go to the setting and enable Location permission",
        duration:  const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        backgroundColor: AppColors.accentColor
    );
  }
}
