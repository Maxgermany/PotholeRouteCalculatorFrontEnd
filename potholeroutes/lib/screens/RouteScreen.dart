import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:potholeroutes/models/ServiceRoute.dart';
import 'package:potholeroutes/services/RestService.dart';
import 'package:transparent_image/transparent_image.dart';

class RouteWidget extends StatefulWidget {
  RouteWidget({Key key}) : super(key: key);

  @override
  _RouteWidgetState createState() => _RouteWidgetState();
}

class _RouteWidgetState extends State<RouteWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Route"),
      ),
      body: Center(
        child: FutureBuilder<ServiceRoute>(
          future: RestService().fetchRoute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ServiceRoute route = snapshot.data;
              return ListView.builder(
                  itemCount: route.potholes.length,
                  itemBuilder: (context, index) {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                          leading: FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                route.potholes.elementAt(index).image.imageUrl,
                          ),
                          title: Text((index + 1).toString() + ". Schlagloch"),
                          subtitle: Text("Lat: " +
                              route.potholes
                                  .elementAt(index)
                                  .coordinate
                                  .latitude
                                  .toString() +
                              " Lng: " +
                              route.potholes
                                  .elementAt(index)
                                  .coordinate
                                  .longitude
                                  .toString())),
                    );
                  });
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
