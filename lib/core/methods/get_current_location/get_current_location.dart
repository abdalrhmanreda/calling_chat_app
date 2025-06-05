import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GetCurrentLocation {
  StreamSubscription<Position>? _positionStreamSubscription;

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location service is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return false;
    }

    // Check the location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }

    // Location service is enabled and permission is granted
    return true;
  }

  Future<Position> getCurrentPosition() async {
    bool hasPermission = await checkPermission();
    if (hasPermission) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      return Future.error('Permission Denied');
    }
  }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter:
            10, // سيتم إرسال التحديثات عندما يتحرك المستخدم على الأقل 10 متر
      ),
    );
  }


  void stopPositionStream() {
    _positionStreamSubscription?.cancel();
  }
}
