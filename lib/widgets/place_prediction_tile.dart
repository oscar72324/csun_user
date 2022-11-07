import 'package:csun_user/assistants/request_assistant.dart';
import 'package:csun_user/global/map_key.dart';
import 'package:csun_user/models/predicted_places.dart';
import 'package:csun_user/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';

import '../models/directions.dart';

class PlacePredictionTileDesign extends StatelessWidget{
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  getPlaceDirectionDetails(String? placeId, context) async{
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        message: "Setting up drop-off, please wait..."
      ),
    );

    String placeDirectionDetailsUrl = "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$mapKey";

    var responseApi = await RequestAssistant.receiveRequest(placeDirectionDetailsUrl);
    if(responseApi == "Failed"){
      return;
    }

    if(responseApi["status"] == "OK"){
      Directions directions = Directions();

      directions.locationName = responseApi["result"]["name"];
      directions.locationId = placeId;
      directions.locationLatitude = responseApi["result"]["geometry"]["location"]["lat"];
      directions.locationLongitude = responseApi["result"]["geometry"]["location"]["lng"];

      print("\nlocation name: " + directions.locationName!);
      print("\nlocation lat: " + directions.locationLatitude!.toString());
      print("\nlocation lng: " + directions.locationLongitude.toString());
    }
  }

  @override 
  Widget build(BuildContext context){
    return ElevatedButton(
      onPressed: () {
        getPlaceDirectionDetails(predictedPlaces!.place_id, context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white10,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Icon(
              Icons.add_location,
              color: Colors.grey,
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    predictedPlaces!.secondary_text!,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.white54,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}