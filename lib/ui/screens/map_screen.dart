import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(provider.location!),
        actions: [
          PopupMenuButton<MapType>(
            onSelected: (mapType) {
              // You can set a map type setter in provider if you want to save it there
              provider.setMapType(mapType);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: MapType.normal, child: Text('Normal')),
              const PopupMenuItem(
                  value: MapType.satellite, child: Text('Satellite')),
              const PopupMenuItem(
                  value: MapType.terrain, child: Text('Terrain')),
              const PopupMenuItem(value: MapType.hybrid, child: Text('Hybrid')),
            ],
          ),
        ],
      ),
      body: provider.coordinates == null
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: provider.coordinates!,
                    zoom: 14,
                  ),
                  mapType: provider.mapType,
                  markers: {
                    Marker(
                        markerId: const MarkerId('userLocation'),
                        position: provider.coordinates!),
                  },
                ),
                Positioned(
                  bottom: 40.sp,
                  left: 30.sp,
                  child: FloatingActionButton.extended(
                    onPressed: () => provider
                        .findCurrentLocation(context), // Call provider method
                    label: const Text("Current Location",style: TextStyle(color: AppColors.whiteColor),),
                    icon: const Icon(Icons.my_location,color: AppColors.whiteColor,),
                    backgroundColor: AppColors.buttonColor,
                  ),
                ),
              ],
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
        title: "Permission Denied",
        message: "Please go to the setting and enable Location permission",
        duration: const Duration(seconds: 3),
        flushbarPosition: FlushbarPosition.TOP,
        flushbarStyle: FlushbarStyle.GROUNDED,
        backgroundColor: AppColors.accentColor);
  }
}
