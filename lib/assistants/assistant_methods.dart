import 'package:csun_user/assistants/request_assistant.dart';
import 'package:csun_user/global/global.dart';
import 'package:csun_user/global/map_key.dart';
import 'package:csun_user/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';

class AssistantMethods {
  // static Future<String> searchAddressForGeographicCoordinates(
  //     Position position) async {
  //   String apiUrl =
  //       "https://maps.googleapis.com/maps/api/geocode/json?LatLng=${position.latitude},${position.longitude}&key=$mapKey";
  //   String humanReadableAddress = "";

  //   var requestResponse = await RequestAssistant.receiveRequest(apiUrl);
  //   if (requestResponse != "Failed") {
  //     humanReadableAddress = requestResponse["results"][0]["formatted_address"];
  //   }

  //   return humanReadableAddress;
  // }

  static void readCurrentOnlineUserInfo() {
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}
