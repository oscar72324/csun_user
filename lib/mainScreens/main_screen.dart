import 'dart:async';
import 'package:csun_user/assistants/geofire_assistant.dart';
import 'package:csun_user/mainScreens/search_places_screen.dart';
import 'package:csun_user/models/active_nearby_available_drivers.dart';
import 'package:csun_user/page/safety_escort.dart';
import 'package:csun_user/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../widgets/navigation_drawer_widget.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';
import '../infoHandler/app_info.dart';
import '../widgets/my_drawer.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _center = CameraPosition(
    target: LatLng(34.24138, -118.52946),
    zoom: 14.4746,
  );

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  double searchLocationContainerHeight = 220;

  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;
  bool? locationPermissionStatus;
  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoordinatesList = [];
  Set<Polyline> polyLineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circleSet = {};

  String userName = "Your Name";
  String userEmail = "Your Email";

  bool openNavigationDrawer = true;
  bool activeNearbyDriverKeysLoaded = false;

  bool checkSafetyEscortBannerTime = false;
  bool checkWeekdayShuttleBannerTime = false;
  bool checkWeekendShuttleBannerTime = false;

  blackThemeGoogleMap() {
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

  Future<bool> checkIfLocationPermissionAllowed() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationPermissionStatus = false;
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationPermissionStatus = false;
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      locationPermissionStatus = false;
      return false;
    }
    locationPermissionStatus = true;
    return true;
  }

  locateUserPosition() async {
    final hasPermission = await checkIfLocationPermissionAllowed();

    if (!hasPermission) {
      openAppSettings();
    }

    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    // newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    // String humanReadableAddress = await AssistantMethods.searchAddressForGeographicCoordinates(userCurrentPosition!, context);
    // print("this is your address = " + humanReadableAddress);
    await AssistantMethods.searchAddressForGeographicCoordinates(
        userCurrentPosition!, context);

    userName = userModelCurrentInfo!.name!;
    userEmail = userModelCurrentInfo!.email!;

    initializeGeofireListener();
  }

  initializeGeofireListener(){
    Geofire.initialize("activeDrivers");

    Geofire.queryAtLocation(userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!.listen((map) {
        print(map);
        if (map != null) {
          var callBack = map['callBack'];

          //latitude will be retrieved from map['latitude']
          //longitude will be retrieved from map['longitude']

          switch (callBack) {
            // when a driver becomes active
            case Geofire.onKeyEntered:
              ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
              activeNearbyAvailableDriver.locationLatitude = map['latitude'];
              activeNearbyAvailableDriver.locationLongitude = map['longitude'];
              activeNearbyAvailableDriver.driverId = map['key'];

              GeoFireAssistant.activeNearbyAvailableDriversList.add(activeNearbyAvailableDriver);

              if(activeNearbyDriverKeysLoaded == true){
                displayActiveDriversOnUsersMap();
              }
              break;

            // when a driver goes offline (inactive)
            case Geofire.onKeyExited:
              GeoFireAssistant.deleteOfflineDriverFromList(map['key']);
              displayActiveDriversOnUsersMap();
              break;

            // when a driver moves, update driver location
            case Geofire.onKeyMoved:
              ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
              activeNearbyAvailableDriver.locationLatitude = map['latitude'];
              activeNearbyAvailableDriver.locationLongitude = map['longitude'];
              activeNearbyAvailableDriver.driverId = map['key'];

              GeoFireAssistant.updateAvailableDriverLocation(activeNearbyAvailableDriver);

              displayActiveDriversOnUsersMap();
              break;

            // display online active drivers on the user map
            case Geofire.onGeoQueryReady:
              displayActiveDriversOnUsersMap();
              break;
          }
        }
        setState(() {});
      }
    );
  }

  displayActiveDriversOnUsersMap(){
    setState((){
      markersSet.clear();
      circleSet.clear();

      Set<Marker> driversMarkerSet = Set<Marker>();

      for(ActiveNearbyAvailableDrivers eachDriver in GeoFireAssistant.activeNearbyAvailableDriversList){
        LatLng eachDriverActivePosition = LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);

        Marker marker = Marker(
          markerId: MarkerId(eachDriver.driverId!),
          position: eachDriverActivePosition,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
          rotation: 360,
          );

          driversMarkerSet.add(marker);
      }

      setState(() {
        markersSet = driversMarkerSet;
      });
    });
  }

  checkTimeForSafetyReminders(){
    var dt = DateTime.now();
    int checkDay = checkDayForShuttle();

    if(checkDay == 0){
      if(dt.hour > 7){
        checkWeekdayShuttleBannerTime = true;
        if(dt.hour > 19){
          checkSafetyEscortBannerTime = true;
        }
        if(dt.hour > 21){
          checkWeekdayShuttleBannerTime = false;
        }
      }
      else{
        checkWeekdayShuttleBannerTime = false;
        checkSafetyEscortBannerTime = false;
      }
    }
    else if(checkDay == 1){
      checkSafetyEscortBannerTime = false;
      if(dt.hour > 7){
        checkWeekdayShuttleBannerTime = true;
        if(dt.hour > 16.5){
          checkWeekdayShuttleBannerTime = false;
        }
      }
      else{
        checkWeekdayShuttleBannerTime = false;
      }
    }
    else{
      checkSafetyEscortBannerTime = false;
      if(dt.hour > 7){
        checkWeekendShuttleBannerTime = true;
      }
    }
  }

  int checkDayForShuttle(){
    var dt = DateTime.now();

    if((dt.weekday == DateTime.monday) || (dt.weekday == DateTime.tuesday) || (dt.weekday == DateTime.wednesday) || (dt.weekday == DateTime.thursday)){
      return 0;
    }
    else if(dt.weekday == DateTime.friday){
      return 1;
    }
    else{
      return 2;
    }
  }

  @override
  void initState() {
    super.initState();

    locateUserPosition();

    checkTimeForSafetyReminders();
    if(checkWeekdayShuttleBannerTime){
      WidgetsBinding.instance.addPostFrameCallback((_) => showWeekdayShuttleBanner());
    }

    if(checkWeekendShuttleBannerTime){
      WidgetsBinding.instance.addPostFrameCallback((_) => showWeekendShuttleBanner());
    }

    if(checkSafetyEscortBannerTime){
      WidgetsBinding.instance.addPostFrameCallback((_) => showSafetyEscortBanner());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      key: sKey,

      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {
            sKey.currentState!.openDrawer();
          },
        ),
        // automaticallyImplyLeading: false,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: Container(
        width: 310,
        child: Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.red),
          child: MyDrawer(
            name: userName,
            email: userEmail,
          ),
        ),
      ),
      endDrawer: NavigationDrawerWidget(),
      body: Stack(
        children: [
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingOfMap),
            mapType: MapType.normal,
            myLocationEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            initialCameraPosition: _center,
            polylines: polyLineSet,
            markers: markersSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

                // for black theme Google Map
                blackThemeGoogleMap();

                setState(() {
                  bottomPaddingOfMap = 240;
                });
                // locateUserPosition();
              },
            ),

          // custom hamburger button
          // Positioned(
          //   top: 40,
          //   left: 22,
          //   child: GestureDetector(
          //     onTap: () {
          //       if (openNavigationDrawer) {
          //         sKey.currentState!.openDrawer();
          //       } else {
          //         // restart-refresh-minimize app
          //         SystemNavigator.pop();
          //       }
          //     },
          //     child: CircleAvatar(
          //       backgroundColor: Colors.red,
          //       child: Icon(
          //         openNavigationDrawer ? Icons.menu : Icons.close,
          //         color: Colors.white,
          //       ),
          //     ),
          //   ),
          // ),

          // search bar UI
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 120),
              child: Container(
                height: searchLocationContainerHeight,
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                  child: Column(
                    children: [
                      //from
                      Row(
                        children: [
                          const Icon(
                            Icons.add_location_alt_outlined,
                            color: Colors.grey,
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "From",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Text(
                                Provider.of<AppInfo>(context).userPickUpLocation !=null
                                    ? "${(Provider.of<AppInfo>(context).userPickUpLocation!.locationName!).substring(0, 24)}..."
                                    : "Not getting address",
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),
                        ],
                      ),

                        const SizedBox(height: 10),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),

                      // to location
                      GestureDetector(
                        onTap: () async {
                          // go to search places screen
                          var responseFromSearchScreen = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (c) => SearchPlacesScreen()));

                          if (responseFromSearchScreen == "obtainedDropOff") {
                            setState(() {
                              openNavigationDrawer = false;
                            });

                            // draw routes - draw polylines
                            await drawPolylineFromOriginToDestination();
                          }
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.add_location_alt_outlined,
                                color: Colors.grey),
                            const SizedBox(width: 12.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "To",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                                Text(
                                  Provider.of<AppInfo>(context)
                                              .userDropOffLocation !=
                                          null
                                      ? (Provider.of<AppInfo>(context)
                                          .userDropOffLocation!
                                          .locationName!)
                                      : "Where to?",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // shuttle button
                      const SizedBox(height: 10),
                      const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 16,
                      ),

                        ElevatedButton(
                          child: const Text("Start route"),
                          onPressed: () {
                            // on press
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }

  Future<void> drawPolylineFromOriginToDestination() async {
    var originPosition =
        Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
    var destinationPosition =
        Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

    var originLatLng = LatLng(
        originPosition!.locationLatitude!, originPosition!.locationLongitude!);
    var destinationLatLng = LatLng(destinationPosition!.locationLatitude!,
        destinationPosition!.locationLongitude!);

    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProgressDialog(message: "Please wait..."),
    );

    var directionDetailsInfo =
        await AssistantMethods.obtainOriginToDestinationDirectionDetails(
            originLatLng, destinationLatLng);

    Navigator.pop(context);

    // print("Points = ${directionDetailsInfo!.e_points}");

    PolylinePoints pPoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointsResultList =
        pPoints.decodePolyline(directionDetailsInfo!.e_points!);

    pLineCoordinatesList.clear();

    if (decodedPolyLinePointsResultList.isNotEmpty) {
      decodedPolyLinePointsResultList.forEach((PointLatLng pointLatLng) {
        pLineCoordinatesList
            .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polyLineSet.clear();

    setState(() {
      Polyline polyline = Polyline(
        color: Colors.redAccent,
        polylineId: const PolylineId("PolylineID"),
        jointType: JointType.round,
        points: pLineCoordinatesList,
        startCap: Cap.roundCap,
        endCap: Cap.roundCap,
        geodesic: true,
      );
      polyLineSet.add(polyline);
    });
    LatLngBounds boundsLatLng;
    if ((originLatLng.latitude > destinationLatLng.latitude) &&
        (originLatLng.longitude > destinationLatLng.longitude)) {
      boundsLatLng =
          LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
    } else if (originLatLng.longitude > destinationLatLng.longitude) {
      boundsLatLng = LatLngBounds(
          southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, originLatLng.longitude));
    } else if (originLatLng.latitude > destinationLatLng.latitude) {
      boundsLatLng = LatLngBounds(
          southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
          northeast:
              LatLng(originLatLng.latitude, destinationLatLng.longitude));
    } else {
      boundsLatLng =
          LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
    }

    newGoogleMapController!
        .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));

    Marker originMarker = Marker(
      markerId: const MarkerId("originID"),
      infoWindow: InfoWindow(
        title: originPosition.locationName,
        snippet: "Origin",
      ),
      position: originLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
    );

    Marker destinationMarker = Marker(
      markerId: const MarkerId("destinationID"),
      infoWindow: InfoWindow(
        title: destinationPosition.locationName,
        snippet: "Destination",
      ),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    );

    setState(() {
      markersSet.add(originMarker);
      markersSet.add(destinationMarker);
    });

    Circle originCircle = Circle(
      circleId: const CircleId("originID"),
      fillColor: Colors.grey,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: originLatLng,
    );

    Circle destinationCircle = Circle(
      circleId: const CircleId("destinationID"),
      fillColor: Colors.red,
      radius: 12,
      strokeWidth: 3,
      strokeColor: Colors.white,
      center: destinationLatLng,
    );

    setState(() {
      circleSet.add(originCircle);
      circleSet.add(destinationCircle);
    });
  }

  void showSafetyEscortBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text("Don't walk alone!\nContact Matador Patrol for a safety escort"),
        contentTextStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          child: Icon(Icons.directions_walk_rounded),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Dismiss"),
              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
          ),
          ElevatedButton(
            child: const Text("Call"),
              onPressed: (){

              },
          ),
        ],
      ),
    );
  }

  void showWeekdayShuttleBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text("The housing shuttle can bring you to/from the dorms, F10 parking lot,k and campus"),
        contentTextStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          child: Icon(Icons.directions_bus_filled_rounded),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Dismiss"),
              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
          ),
          ElevatedButton(
            child: const Text("See Route"),
              onPressed: (){

              },
          ),
        ],
      ),
    );
  }

  void showWeekendShuttleBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: const Text("The shuttle is not running today"),
        contentTextStyle: const TextStyle(
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          child: Icon(Icons.bus_alert_rounded),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Dismiss"),
              onPressed: (){
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
          ),
        ],
      ),
    );
  }
}
