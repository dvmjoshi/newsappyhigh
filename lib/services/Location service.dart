import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Position _currentPosition;
  String _currentAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    _currentAddress;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_currentPosition != null) Text(_currentAddress),
          FlatButton(
            child: Text("Get location"),
            onPressed: () {
              _getCurrentLocation();
            },
          ),
        ],
      ),
    );
  }

  _getCurrentLocation() {
    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

      _getAddressFromLatLng();
    }).catchError((e) {
      Text("Wait");
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.isoCountryCode} ,${place.country}";
      });
    } catch (e) {
      Text("Wait");
    }
  }
}
