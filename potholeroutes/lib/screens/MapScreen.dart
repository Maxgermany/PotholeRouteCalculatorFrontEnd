import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:potholeroutes/models/Pothole.dart';
import 'package:potholeroutes/models/PotholeAddress.dart';
import 'package:potholeroutes/models/ServiceRoute.dart';
import 'package:potholeroutes/services/PersistenceService.dart';
import 'package:potholeroutes/services/RestService.dart';
import 'package:potholeroutes/services/GeolocationService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AboutScreen.dart';
import 'RouteScreen.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  _showDialog() async {
    final textController = TextEditingController();
    await showDialog<String>(
      context: context,
      child: Center(
        child: AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                      labelText: 'Neue Kontrakt Nummer',
                      hintText: 'LPZ040-123456'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text('Abbrechen'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: const Text('Ändern'),
                onPressed: () {
                  setState(() {
                    PersistentService().setContractId(textController.text);
                  });

                  Navigator.pop(context);
                })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: const Text("Auftragsübersicht"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {});
            },
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 10))
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<ServiceRoute>(
            future: RestService().fetchRoute(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                ServiceRoute route = snapshot.data;
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          leading: FlatButton(
                            color: Colors.orange[300],
                            onPressed: () {
                              setState(() {
                                _showDialog();
                              });
                            },
                            child: const Text('Ändern'),
                          ),
                          title: FutureBuilder<String>(
                            future: SharedPreferences.getInstance()
                                .then((value) => value.getString('contractId')),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(snapshot.data);
                              } else {
                                return Text("Bitte Kontrakt Nr. eingeben");
                              }
                            },
                          ),
                          subtitle: Text("Aktuelle Kontrakt Nr."),
                        ),
                      ),
                      Card(
                        clipBehavior: Clip.antiAlias,
                        child: SizedBox(
                            height: MediaQuery.of(context).size.width,
                            child: MapWidget()),
                      ),
                      FutureBuilder(
                        future: GeolocationService().fetchPotholeAddress(route.potholes.elementAt(0).coordinate),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if(snapshot.hasData) {
                            PotholeAddress address = snapshot.data;
                            
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                leading: FlatButton(
                                    color: Colors.green[300],
                                    onPressed: () {
                                      setState(() {
                                        route.potholes.removeAt(0);
                                      });
                                    },
                                    child: Icon(Icons.check)),
                                title: const Text("Nächstes Schlagloch"),
                                subtitle: Text(address.getStreetName()),  
                              )
                            );
                          } else {
                            return Card(
                              clipBehavior: Clip.antiAlias,
                              child: ListTile(
                                leading: FlatButton(
                                  color: Colors.green[300],
                                  onPressed: () {

                                  },
                                  child: Icon(Icons.check)
                                ),
                                title: Center(child: const CircularProgressIndicator()),
                              ),
                            );
                          }
                        }
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text('Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ))),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('Karte'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.arrow_forward),
            title: Text('Vollständige Route'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RouteWidget()));
            },
          ),
          ListTile(
              leading: Icon(Icons.info),
              title: Text('Einstellungen'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutWidget()));
              })
        ],
      )),
    );
  }
}

class MapWidget extends StatefulWidget {
  MapWidget({Key key}) : super(key: key);

  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: FutureBuilder<ServiceRoute>(
          future: RestService().fetchRoute(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              ServiceRoute route = snapshot.data;
              return FlutterMap(
                options: new MapOptions(
                  center: LatLng(
                      route.potholes.elementAt(0).coordinate.latitude,
                      route.potholes.elementAt(0).coordinate.longitude),
                  zoom: 15.0,
                  maxZoom: 18.0,
                  minZoom: 10.0,
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                    markers: <Marker>[
                      for (Pothole pothole in route.potholes)
                        Marker(
                          width: 80.0,
                          height: 80.0,
                          point: LatLng(pothole.coordinate.latitude,
                              pothole.coordinate.longitude),
                          builder: (ctx) => new Container(
                            child: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
