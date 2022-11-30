import 'package:csun_user/models/active_nearby_available_drivers.dart';

class GeoFireAssistant{
  static List<ActiveNearbyAvailableDrivers> activeNearbyAvailableDriversList = [];

  static void deleteOfflineDriverFromList(String driverId){
    int indexNumber = activeNearbyAvailableDriversList.indexWhere((element) => (element.driverId == driverId));
    activeNearbyAvailableDriversList.removeAt(indexNumber);
  }

  static void updateAvailableDriverLocation(ActiveNearbyAvailableDrivers driverWhoMoved){
    int indexNumber = activeNearbyAvailableDriversList.indexWhere((element) => (element.driverId == driverWhoMoved.driverId));

    activeNearbyAvailableDriversList[indexNumber].locationLatitude = driverWhoMoved.locationLatitude;
    activeNearbyAvailableDriversList[indexNumber].locationLongitude = driverWhoMoved.locationLongitude;
  }
}