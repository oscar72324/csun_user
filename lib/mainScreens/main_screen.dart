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
import 'package:url_launcher/url_launcher_string.dart';

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

  LatLng? UniCampusNE = LatLng(34.254058333192056, -118.52339991065044);
  LatLng? UniCampusSW = LatLng(34.23556440815254, -118.53379222163633);
  var nLat, nLong, sLat, sLong;

  LocationPermission? _locationPermission;
  bool? locationPermissionStatus;
  double bottomPaddingOfMap = 0;

  List<LatLng> pLineCoordinatesList = [];
  Set<Polyline> polyLineSet = {};

  Set<Marker> markersSet = {};
  Set<Circle> circleSet = {};

  String userName = userModelCurrentInfo!.name!;
  String userEmail = userModelCurrentInfo!.email!;

  bool openNavigationDrawer = true;
  bool activeNearbyDriverKeysLoaded = false;
  BitmapDescriptor? activeNearbyIcon;

  bool checkShuttleToggle = false;
  bool checkSafetyEscortBannerTime = false;
  bool checkWeekdayShuttleBannerTime = false;
  bool checkWeekendShuttleBannerTime = false;

  String routeButtonText = "Start route";

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

  checkTimeForSafetyReminders() {
    var dt = DateTime.now();

    if((dt.weekday == DateTime.monday) || (dt.weekday == DateTime.tuesday) || (dt.weekday == DateTime.wednesday) || (dt.weekday == DateTime.thursday)){
      checkWeekendShuttleBannerTime = false;
      if(dt.hour > 7){
        checkWeekdayShuttleBannerTime = true;
        if(dt.hour > 19){
          checkSafetyEscortBannerTime = true;
        }
        if(dt.hour > 21){
          checkWeekdayShuttleBannerTime = false;
        }
        if(dt.hour > 23){
          checkSafetyEscortBannerTime = false;
        }
      }
      else{
        checkWeekdayShuttleBannerTime = false;
        checkSafetyEscortBannerTime = false;
      }
    }
    else if(dt.weekday == DateTime.friday){
      checkWeekendShuttleBannerTime = false;
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

  checkMapBounds(){
    if(UniCampusSW!.latitude <= UniCampusNE!.latitude){
      sLat = UniCampusSW!.latitude;
      nLat = UniCampusNE!.latitude;
    }
    else{
      sLat = UniCampusNE!.latitude;
      nLat = UniCampusSW!.latitude;
    }
    if(UniCampusSW!.longitude <= UniCampusNE!.longitude){
      sLong = UniCampusSW!.longitude;
      nLong = UniCampusNE!.longitude;
    }
    else{
      sLong = UniCampusNE!.longitude;
      nLong = UniCampusSW!.longitude;
    }
  }

  @override
  void initState() {
    super.initState();

    locateUserPosition();
    checkMapBounds();

    checkTimeForSafetyReminders();
    if(checkWeekdayShuttleBannerTime){
      WidgetsBinding.instance.addPostFrameCallback((_) => showWeekdayShuttleBanner());
    }
    else{
      WidgetsBinding.instance.addPostFrameCallback((_) => showWeekendShuttleBanner());
    }

    if(checkSafetyEscortBannerTime){
      WidgetsBinding.instance.addPostFrameCallback((_) => showSafetyEscortBanner());
    }
  }

  @override
  Widget build(BuildContext context) {

    createActiveNearbyDriverIconMarker();

    return Scaffold(
      backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
      extendBodyBehindAppBar: true,
      key: sKey,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person, color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black,),
          onPressed: () {
            sKey.currentState!.openDrawer();
          },
        ),
        // automaticallyImplyLeading: false,
        toolbarHeight: 40,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: SizedBox(
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
            cameraTargetBounds: CameraTargetBounds(LatLngBounds(northeast: LatLng(nLat, nLong), southwest: LatLng(sLat, sLong))),
            polylines: polyLineSet,
            markers: markersSet,
            circles: circleSet,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              appThemeBrightness = MediaQuery.of(context).platformBrightness;

              // for black theme Google Map
              if(appThemeBrightness == Brightness.dark){
                blackThemeGoogleMap();
              }
              
                setState(() {
                  bottomPaddingOfMap = 240;
                });
                // locateUserPosition();
                // Geofire.initialize("activeDrivers");
                // initializeGeofireListener();
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

          // emergency call button
          Positioned(
            bottom: 320,
            left: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed:() async {
                // call 911
                const emergencyCall = 'tel:911';
                if(await canLaunchUrlString(emergencyCall)){
                  await launchUrlString(emergencyCall);
                }
              },
              child: const Icon(
                Icons.contact_phone_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),
          
          // shuttle route toggle button
          Positioned(
            bottom: 320,
            right: 10,
            child: FloatingActionButton(
              backgroundColor: Colors.redAccent,
              onPressed:() {
                if(checkShuttleToggle){
                  hideShuttlePolyline();
                }
                else{
                  drawShuttlePolyline();
                }
              },
              child: const Icon(
                Icons.airport_shuttle_rounded,
                size: 35,
                color: Colors.white,
              ),
            ),
          ),

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
                decoration: BoxDecoration(
                  color: appThemeBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
                  borderRadius: const BorderRadius.only(
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
                      // Row(
                      //   children: [
                      //     const Icon(
                      //       Icons.add_location_alt_outlined,
                      //       color: Colors.grey,
                      //     ),
                      //     const SizedBox(
                      //       width: 12.0,
                      //     ),
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         const Text(
                      //           "From",
                      //           style:
                      //               TextStyle(color: Colors.grey, fontSize: 12),
                      //         ),
                      //         Text(
                      //           Provider.of<AppInfo>(context).userPickUpLocation !=null
                      //               ? "${(Provider.of<AppInfo>(context).userPickUpLocation!.locationName!).substring(0, 24)}..."
                      //               : "Not getting address",
                      //           style: const TextStyle(
                      //               color: Colors.grey, fontSize: 14),
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // ),

                        // const SizedBox(height: 10),
                        // const Divider(
                        //   height: 1,
                        //   thickness: 1,
                        //   color: Colors.grey,
                        // ),
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
                            // await drawPolylineFromOriginToDestination();
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
                                // const Text(
                                //   "To",
                                //   style: TextStyle(
                                //       color: Colors.grey, fontSize: 12),
                                // ),
                                Text(
                                  Provider.of<AppInfo>(context)
                                              .userDropOffLocation !=
                                          null
                                      ? (Provider.of<AppInfo>(context)
                                          .userDropOffLocation!
                                          .locationName!)
                                      : "Search for a location on campus",
                                  style: TextStyle(
                                      // color: Colors.grey,
                                      color: appThemeBrightness == Brightness.dark ? Colors.white : Colors.black,
                                      fontSize: 16,
                                    ),
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
                          child: Text(routeButtonText),
                          onPressed: () {
                            // on press
                            if(routeButtonText == "Start route" || checkShuttleToggle == false){
                              drawShuttlePolyline();
                              setState(() {
                                routeButtonText = "End route";
                              });
                            }
                            else{
                              polyLineSet.clear();
                              markersSet.clear();
                              setState(() {
                                routeButtonText = "Start route";
                              });
                            }
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

  initializeGeofireListener() {
    Geofire.initialize("activeDrivers");

    Geofire.queryAtLocation(userCurrentPosition!.latitude, userCurrentPosition!.longitude, 10)!.listen((map) {
      print(map);

      if (map != null) {
        var callBack = map['callBack'];

        switch (callBack)
        {
          //whenever any driver become active/online
          case Geofire.onKeyEntered:
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistant.activeNearbyAvailableDriversList.add(activeNearbyAvailableDriver);
            if(activeNearbyDriverKeysLoaded == true)
            {
              displayActiveDriversOnUserMap();
            }
            break;

          //whenever any driver become non-active/offline
          case Geofire.onKeyExited:
            GeoFireAssistant.deleteOfflineDriverFromList(map['key']);
            displayActiveDriversOnUserMap();
            break;

          //whenever driver moves - update driver location
          case Geofire.onKeyMoved:
            ActiveNearbyAvailableDrivers activeNearbyAvailableDriver = ActiveNearbyAvailableDrivers();
            activeNearbyAvailableDriver.locationLatitude = map['latitude'];
            activeNearbyAvailableDriver.locationLongitude = map['longitude'];
            activeNearbyAvailableDriver.driverId = map['key'];
            GeoFireAssistant.updateAvailableDriverLocation(activeNearbyAvailableDriver);
            displayActiveDriversOnUserMap();
            break;

          //display those online/active drivers on user's map
          case Geofire.onGeoQueryReady:
            activeNearbyDriverKeysLoaded = true;
            displayActiveDriversOnUserMap();
            break;
        }
      }
      setState(() {});
    });
  }

  displayActiveDriversOnUserMap(){
    setState(() {
      markersSet.clear();
      circleSet.clear();

      Set<Marker> driversMarkerSet = Set<Marker>();

      for(ActiveNearbyAvailableDrivers eachDriver in GeoFireAssistant.activeNearbyAvailableDriversList){
        LatLng eachDriverActivePosition = LatLng(eachDriver.locationLatitude!, eachDriver.locationLongitude!);
        Marker marker = Marker(
          markerId: MarkerId("driver" + eachDriver.driverId!),
          position: eachDriverActivePosition,
          icon: activeNearbyIcon!,
          rotation: 360,
        );

        driversMarkerSet.add(marker);

        // added for test
        print(eachDriver);
      }

      setState(() {
        markersSet = driversMarkerSet;
      });
    });
  }

  createActiveNearbyDriverIconMarker(){
    if(activeNearbyIcon == null){
      ImageConfiguration imageConfiguration = createLocalImageConfiguration(context, size: const Size(2,2));
      BitmapDescriptor.fromAssetImage(imageConfiguration, "images/car.png").then((value){
        activeNearbyIcon = value;
      });
    }
  }

  // Future<void> drawPolylineFromOriginToDestination() async {
  //   var originPosition =
  //       Provider.of<AppInfo>(context, listen: false).userPickUpLocation;
  //   var destinationPosition =
  //       Provider.of<AppInfo>(context, listen: false).userDropOffLocation;

  //   var originLatLng = LatLng(
  //       originPosition!.locationLatitude!, originPosition!.locationLongitude!);
  //   var destinationLatLng = LatLng(destinationPosition!.locationLatitude!,
  //       destinationPosition!.locationLongitude!);

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) =>
  //         ProgressDialog(message: "Please wait..."),
  //   );

  //   var directionDetailsInfo =
  //       await AssistantMethods.obtainOriginToDestinationDirectionDetails(
  //           originLatLng, destinationLatLng);

  //   Navigator.pop(context);

  //   // print("Points = ${directionDetailsInfo!.e_points}");

  //   PolylinePoints pPoints = PolylinePoints();
  //   List<PointLatLng> decodedPolyLinePointsResultList =
  //       pPoints.decodePolyline(directionDetailsInfo!.e_points!);

  //   pLineCoordinatesList.clear();

  //   if (decodedPolyLinePointsResultList.isNotEmpty) {
  //     decodedPolyLinePointsResultList.forEach((PointLatLng pointLatLng) {
  //       pLineCoordinatesList
  //           .add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
  //     });
  //   }
  //   polyLineSet.clear();

  //   setState(() {
  //     Polyline polyline = Polyline(
  //       color: Colors.redAccent,
  //       polylineId: const PolylineId("PolylineID"),
  //       jointType: JointType.round,
  //       points: pLineCoordinatesList,
  //       startCap: Cap.roundCap,
  //       endCap: Cap.roundCap,
  //       geodesic: true,
  //     );
  //     polyLineSet.add(polyline);
  //   });
  //   LatLngBounds boundsLatLng;
  //   if ((originLatLng.latitude > destinationLatLng.latitude) &&
  //       (originLatLng.longitude > destinationLatLng.longitude)) {
  //     boundsLatLng =
  //         LatLngBounds(southwest: destinationLatLng, northeast: originLatLng);
  //   } else if (originLatLng.longitude > destinationLatLng.longitude) {
  //     boundsLatLng = LatLngBounds(
  //         southwest: LatLng(originLatLng.latitude, destinationLatLng.longitude),
  //         northeast:
  //             LatLng(destinationLatLng.latitude, originLatLng.longitude));
  //   } else if (originLatLng.latitude > destinationLatLng.latitude) {
  //     boundsLatLng = LatLngBounds(
  //         southwest: LatLng(destinationLatLng.latitude, originLatLng.longitude),
  //         northeast:
  //             LatLng(originLatLng.latitude, destinationLatLng.longitude));
  //   } else {
  //     boundsLatLng =
  //         LatLngBounds(southwest: originLatLng, northeast: destinationLatLng);
  //   }

  //   newGoogleMapController!
  //       .animateCamera(CameraUpdate.newLatLngBounds(boundsLatLng, 65));

  //   Marker originMarker = Marker(
  //     markerId: const MarkerId("originID"),
  //     infoWindow: InfoWindow(
  //       title: originPosition.locationName,
  //       snippet: "Origin",
  //     ),
  //     position: originLatLng,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
  //   );

  //   Marker destinationMarker = Marker(
  //     markerId: const MarkerId("destinationID"),
  //     infoWindow: InfoWindow(
  //       title: destinationPosition.locationName,
  //       snippet: "Destination",
  //     ),
  //     position: destinationLatLng,
  //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
  //   );

  //   setState(() {
  //     markersSet.add(originMarker);
  //     markersSet.add(destinationMarker);
  //   });

  //   Circle originCircle = Circle(
  //     circleId: const CircleId("originID"),
  //     fillColor: Colors.grey,
  //     radius: 12,
  //     strokeWidth: 3,
  //     strokeColor: Colors.white,
  //     center: originLatLng,
  //   );

  //   Circle destinationCircle = Circle(
  //     circleId: const CircleId("destinationID"),
  //     fillColor: Colors.red,
  //     radius: 12,
  //     strokeWidth: 3,
  //     strokeColor: Colors.white,
  //     center: destinationLatLng,
  //   );

  //   setState(() {
  //     circleSet.add(originCircle);
  //     circleSet.add(destinationCircle);
  //   });
  // }
  
  void drawShuttlePolyline() async {
    setState(() {
      polyLineSet.clear();
      markersSet.clear();
      circleSet.clear();
    });

    checkShuttleToggle = true;

    const Polyline shuttlePolyline = Polyline(
      polylineId: PolylineId('shuttlePolyline'),
      points: [
        LatLng(34.241232, -118.526771),
        LatLng(34.240944, -118.526793),
        LatLng(34.240944, -118.527319),
        LatLng(34.242718, -118.527417),
        LatLng(34.24273, -118.52823),
        LatLng(34.243063, -118.528234),
        LatLng(34.243013, -118.529043),
        LatLng(34.244594, -118.529054),
        LatLng(34.24458, -118.52734),
        LatLng(34.250326, -118.527385),
      ],
      width: 5,
      color: Colors.yellow,
    );
    setState(() {
      polyLineSet.add(shuttlePolyline);
    });
    final Marker spiritPlaza = Marker(
      markerId: const MarkerId('spiritPlaza'),
      infoWindow: const InfoWindow(title: "Spirit Plaza Stop"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: const LatLng(34.241232, -118.526771),
    );

    final Marker f10Parking = Marker(
      markerId: const MarkerId('f10Parking'),
      infoWindow: const InfoWindow(title: "F10 Parking Lot Stop"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      position: const LatLng(34.250326, -118.527385),
    );

    final Marker housingStop = Marker(
      markerId: const MarkerId('housingStop'),
      infoWindow: const InfoWindow(title: "Housing Stop"),
      icon: BitmapDescriptor.defaultMarkerWithHue((BitmapDescriptor.hueRed)),
      position: const LatLng(34.247323, -118.527399),
    );

    setState(() {
      markersSet.add(spiritPlaza);
      markersSet.add(f10Parking);
      markersSet.add(housingStop);
    });
  }

  void hideShuttlePolyline(){
    setState(() {
      polyLineSet.clear();
      markersSet.clear();
      circleSet.clear();
    });

    checkShuttleToggle = false;
  }

  void showSafetyEscortBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("Don't walk alone!\nContact Matador Patrol for a safety escort", style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black)),
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.directions_walk_rounded, color: Colors.white),
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
                // go to the Safety Escort page
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
          ),
        ],
      ),
    );
  }

  void showWeekdayShuttleBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("The housing shuttle can bring you to/from the dorms, F10 parking lot, and campus", style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black)),
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.directions_bus_filled_rounded, color: Colors.white),
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
                drawShuttlePolyline();
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                showHideShuttleRouteBanner();
              },
          ),
        ],
      ),
    );
  }

  void showHideShuttleRouteBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("The housing shuttle route is currently showing", style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black)),
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          child: Icon(Icons.directions_bus_filled_rounded, color: Colors.white),
        ),
        actions: [
          ElevatedButton(
            child: const Text("Hide Route"),
              onPressed: (){
                hideShuttlePolyline();
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
          ),
        ],
      )
    );
  }

  void showWeekendShuttleBanner(){
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        content: Text("The shuttle is not running today", style: TextStyle(color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.white : Colors.black)),
        backgroundColor: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.black87 : Colors.white70,
        elevation: 10,
        forceActionsBelow: true,
        leading: const CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.bus_alert_rounded, color: Colors.white),
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