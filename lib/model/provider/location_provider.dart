import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../ui/constants/app_colors.dart';

// class LocationProvider with ChangeNotifier {
//   String? _location;
//
//   String? get location => _location;
//
//   void setLocation(String location) {
//     _location = location;
//     notifyListeners();
//   }
//   Future<bool> checkPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
//     }
//     return true;
//   }
//
//   Future<Position> getCurrentLocation() async {
//     return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   }
// }



class LocationProvider with ChangeNotifier {
  String? _location;
  LatLng? _coordinates;
  String? _errorMessage;
  MapType _mapType = MapType.normal; // Default map type

  // Getters
  String? get location => _location;
  LatLng? get coordinates => _coordinates;
  String? get errorMessage => _errorMessage;
  MapType get mapType => _mapType; // Getter for map type

  // Setter for location
  set location(String? loc) {
    _location = loc;
    notifyListeners(); // Notify listeners whenever location changes
  }

  // Setter for MapType
  void setMapType(MapType mapType) {
    _mapType = mapType;
    notifyListeners(); // Notify listeners whenever the map type changes
  }


  // Future<bool> checkPermission() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     return permission == LocationPermission.whileInUse || permission == LocationPermission.always;
  //   }
  //   return true;
  // }

  Future<void> getCoordinatesFromAddress(BuildContext context) async {
    if (_location != null) {
      try {
        List<Location> locations = await locationFromAddress(_location!);
        if (locations.isNotEmpty) {
          _coordinates = LatLng(locations[0].latitude, locations[0].longitude);
          _errorMessage = null; // Reset error message
          print('***************Location Coordinates: Latitude***** = ${locations[0].latitude}, Longitude = ${locations[0].longitude}');
        } else {
          _errorMessage = 'Unable to find location';
        }
      } catch (e) {
        _errorMessage = 'Unable to find location';
      }
      notifyListeners(); // Notify listeners to update UI
    }
  }


  Future<void> findCurrentLocation(BuildContext context) async {
    // First check for permission
    bool hasPermission = await checkPermission();

    if (!hasPermission) {
      // Request permission again
      hasPermission = await requestPermission();
    }

    if (hasPermission) {
      // Permission granted, get current location
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _coordinates = LatLng(position.latitude, position.longitude);
      _errorMessage = null; // Reset error message
      print('Current Location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');
      notifyListeners(); // Notify listeners to update UI
    } else {
      // Permission denied again, show SnackBar
      _errorMessage = 'Location permission denied. Please enable it in settings.';
      notifyListeners(); // Notify listeners to update UI

      // Show SnackBar for 3 seconds
      Flushbar(
            title: "Permission Denied",
            message: "Please go to the setting and enable Location permission",
            duration: const Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.TOP,
            flushbarStyle: FlushbarStyle.GROUNDED,
            backgroundColor: AppColors.accentColor);

    }
  }

  Future<bool> checkPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return false;
    }
    return true;
  }

  Future<bool> requestPermission() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  // Future<void> findCurrentLocation(BuildContext context) async {
  //   if (await checkPermission()) {
  //     Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //     _coordinates = LatLng(position.latitude, position.longitude);
  //     _errorMessage = null; // Reset error message
  //     print('Current Location: Latitude = ${position.latitude}, Longitude = ${position.longitude}');
  //     notifyListeners(); // Notify listeners to update UI
  //   } else {
  //     _errorMessage = 'Location permission denied. Please enable it in settings.';
  //     notifyListeners(); // Notify listeners to update UI
  //   }
  // }
}