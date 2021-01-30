import 'package:geolocator/geolocator.dart';

class LocationHelper {
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    await Geolocator.getCurrentPosition().then((Position position) {
      latitude=position.latitude;
      longitude=position.longitude;
    }).catchError((e) {
      print(e);
    });
  }
}