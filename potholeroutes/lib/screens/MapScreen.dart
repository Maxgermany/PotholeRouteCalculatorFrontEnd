import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'AboutScreen.dart';
import 'RouteScreen.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
        title: const Text("Heutige Route"),
        actions: [
          Icon(Icons.refresh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10)
          )
        ],
      ),
      body: new Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width * 1.6,
            child: new MapWidget()
          ),
          ListTile(
            leading: const Icon(Icons.adjust),
            title: const Text("Nächstes Schlagloch"),
            subtitle: const Text("Maße: 0,5 * 0,3 * 0,1"),
          )
        ]
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                )
              )
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Karte')
            ),
            ListTile(
              leading: Icon(Icons.arrow_forward),
              title: Text('Vollständige Route'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RouteWidget()));
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Über'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AboutWidget()));
              }
            )
          ],
        )
      ),
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
    return new FlutterMap(
      options: new MapOptions(
        center: LatLng(51.5, -0.09),
        zoom: 13.0,
      ),
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        new MarkerLayerOptions(
          markers: [
            new Marker(
              width: 80.0,
              height: 80.0,
              point: LatLng(51.5, -0.09),
              builder: (ctx) => new Container(
                child: new FlutterLogo(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
