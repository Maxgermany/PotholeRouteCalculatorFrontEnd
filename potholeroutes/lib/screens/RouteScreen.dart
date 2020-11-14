import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:potholeroutes/models/PotholeAddress.dart';
import 'package:potholeroutes/models/ServiceRoute.dart';
import 'package:potholeroutes/services/GeolocationService.dart';
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
                return FutureBuilder<PotholeAddress>(
                    future: GeolocationService().fetchPotholeAddress(
                        route.potholes.elementAt(0).coordinate),
                    builder: (context, snapshot2) {
                      if (snapshot2.hasData) {
                        PotholeAddress address = snapshot2.data;
                        return ListView.builder(
                            itemCount: route.potholes.length,
                            itemBuilder: (context, index) {
                              return Card(
                                clipBehavior: Clip.antiAlias,
                                child: ListTile(
                                    leading: FadeInImage.memoryNetwork(
                                      placeholder: kTransparentImage,
                                      image: route.potholes
                                          .elementAt(index)
                                          .image
                                          .imageUrl,
                                    ),
                                    title: Text((index + 1).toString() +
                                        ". Schlagloch"),
                                    subtitle: Text(address.address)),
                              );
                            });
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }
}
