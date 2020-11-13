import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class RouteWidget extends StatefulWidget{
  RouteWidget({Key key}) : super(key: key);

  @override
  _RouteWidgetState createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {

  final potholes = [{"width": 100, "length": 50, "depth": 30, "langitude": 51.2345, "longitude": 52.1234}, {"width": 10, "length": 20, "depth": 5, "langitude": 51.2345, "longitude": 52.1234}, {"width": 23, "length": 23, "depth": 23, "langitude": 51.2345, "longitude": 52.1234}, {"width": 100, "length": 50, "depth": 30, "langitude": 51.2345, "longitude": 52.1234}];

  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route"),
      ),
      body: new ListView.builder(
        itemCount: potholes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text((index + 1).toString() + ". Schlagloch"),
            subtitle: Text("Maße: " + potholes[index]["width"].toString() + " * " + potholes[index]["length"].toString() + " * " + potholes[index]["depth"].toString())
          );
        },
      ),
    );
  }
}
