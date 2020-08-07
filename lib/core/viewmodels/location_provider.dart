
import 'package:flutter/material.dart';
import 'package:resto_rw/core/utils/location_utils.dart';
import 'package:resto_rw/injector.dart';

class LocationProvider extends ChangeNotifier {
  //* ------------------------------
  //* This is side of property data
  //* ------------------------------

  //* Location Address
  String _address;
  String get address => _address;

  //* Location Coordinate
  double _latitude;
  double get latitude => _latitude;
  double _longitude;
  double get longitude => _longitude;

  //* Depedency Injection
  LocationUtils locationUtils = locator<LocationUtils>();

  //* ------------------
  //* Function Field
  //* ------------------

  /// Function to load location from GPS and Adress
  void loadLocation() async {
    await locationUtils.getLocation();

    _address = await locationUtils.getAddress();
    _latitude = locationUtils.latitude;
    _longitude = locationUtils.longitude;
    notifyListeners();
  }
}