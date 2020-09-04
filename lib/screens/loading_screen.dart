//import 'package:clima/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // This is only seems to work upon terminating. I don't know why. "stateful widget lifecycle" video challenge
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?id=2172797&appid=439d4b804bc8187953eb36d2a8c26a02');
    if (response.statusCode == 200) {
      String data = response.body;

      var decoded = jsonDecode(data);

      double temp = decoded['main']['temp'];
      int condition = decoded['weather'][0]['id'];
      String city = decoded['name'];

      print(temp);
      print(condition);
      print(city);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          color: Colors.blue,
          textColor: Colors.black,
          onPressed: () {
            getData();
          },
          child: Text(
            'Get Data',
          ),
        ),
      ],
    );
  }
}
