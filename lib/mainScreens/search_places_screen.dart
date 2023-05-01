import 'package:csun_user/assistants/request_assistant.dart';
import 'package:csun_user/global/map_key.dart';
import 'package:csun_user/models/predicted_places.dart';
import 'package:csun_user/widgets/place_prediction_tile.dart';
import 'package:flutter/material.dart';

import '../global/global.dart';

class SearchPlacesScreen extends StatefulWidget{
  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen>{

  List<PredictedPlaces> placesPredictedList = [];

  void findPlaceAutoCompleteSearch(String inputText) async{
    // 2 or more input characters
    if(inputText.length > 1){
      String urlAutoCompleteSearch = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$inputText&key=$mapKey&components=country:US";

      var responseAutoCompleteSearch = await RequestAssistant.receiveRequest(urlAutoCompleteSearch);

      if(responseAutoCompleteSearch == "Failed"){
        return;
      }

      if(responseAutoCompleteSearch["status"] == "OK"){
        var placePredictions = responseAutoCompleteSearch["predictions"];

        var placePredictionsList = (placePredictions as List).map((jsonData) => PredictedPlaces.fromJson(jsonData)).toList();
        
        setState(() {
          placesPredictedList = placePredictionsList;
        });
      }
      print("this is response/result: ");
      print(responseAutoCompleteSearch);
    }
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: appThemeBrightness == Brightness.dark ? Colors.black : Colors.white,
      body: Column(
        children: [
          // search place ui
          Container(
            height: 180,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: appThemeBrightness == Brightness.dark ? Colors.black54 : Colors.white54,
                  blurRadius: 8,
                  spreadRadius: 0.5,
                  offset: Offset(0.7, 0.7),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.red,
                        ),
                      ),

                      const Center(
                        child: Text(
                          "Search & Set Drop Off Location",
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Icon(
                        Icons.adjust_sharp,
                        color: appThemeBrightness == Brightness.dark ? Colors.white54 : Colors.black54,
                        ),

                        const SizedBox(height: 18),

                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              onChanged: (valueTyped){
                                findPlaceAutoCompleteSearch(valueTyped);
                              },
                              decoration: InputDecoration(
                                hintText: "Search here...",
                                hintStyle: TextStyle(color: appThemeBrightness == Brightness.dark ? Colors.white70 : Colors.black87),
                                fillColor: appThemeBrightness == Brightness.dark ? Colors.white12 : Colors.black12,
                                filled: true,
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.only(
                                  left: 11.0,
                                  top: 0.0,
                                  bottom: 0.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // idk
                    ],
                  ),
                ],
              ),
            ),
          ),

          // display place predictions result
          (placesPredictedList.isNotEmpty)
          ? Expanded(
            child: ListView.separated(
              itemCount: placesPredictedList.length,
              physics: const ClampingScrollPhysics(),
              itemBuilder: (context, index){
                return PlacePredictionTileDesign(
                  predictedPlaces: placesPredictedList[index],
                );
              },
              separatorBuilder: (BuildContext context, int index){
                return const Divider(
                  height: 1,
                  color: Colors.grey,
                  thickness: 1,
                );
              },
            ),
          )
          : Container(),
        ],
      ),
    );
  }
}