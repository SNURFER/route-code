import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'specific_pos_map.dart';

class LocationWidget extends StatelessWidget {
  double longitude = 0;
  double latitude = 0;

  LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("위치 검색")
        ),
        body: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '위도',

              ),
              onChanged: (newText){
                longitude = double.parse(newText);
                print(longitude);
              },
            ),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '경도',
              ),
              onChanged: (newText){
                latitude = double.parse(newText);
                print(latitude);
              },
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SpecificPosMap(pos: LatLng(longitude, latitude)))
                );
              },
              child: Container(
                width: 200,
                height: 50,
                alignment: Alignment.center,
                child: Text("해당 위치 지도 표시", textAlign: TextAlign.center,),
              ),
            )

          ],
        )

    );
  }
}