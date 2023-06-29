import 'package:flutter/material.dart';
import 'package:hmc_map/location.dart';
import 'package:hmc_map/map.dart';
import 'package:hmc_map/map3.dart';
import 'package:firebase_auth/firebase_auth.dart';



class MainPage extends StatelessWidget {
  final User user;
  const MainPage({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('루트 코드'),
            actions: <Widget>[
            ],
          ),
          body: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('현재위치'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapWidget())
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.location_on),
                title: const Text('위치검색'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LocationWidget() )
                    // MaterialPageRoute(builder: (context) => MapWidget2(pos: LatLng(37.70, 127.586)))
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.map),
                title: const Text('저장된 위치 불러오기'),
                trailing: const Icon(Icons.navigate_next),
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MapWidget3())
                  );
                },
              ),
            ],
          ),
        )
    );
  }

}
