import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AboutWidget extends StatefulWidget {
  AboutWidget({Key key}) : super(key: key);

  @override
  _AboutWidgetState createState() => _AboutWidgetState();
}

class _AboutWidgetState extends State<AboutWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Einstellungen"),
        ),
        body: Center(
            child: Column(
          children: [
            ListTile(
              title: Text(
                "Developers",
                style: TextStyle(fontSize: 25),
              ),
            ),
            ListTile(title: Text("Maximus Germer")),
            ListTile(title: Text("Fabian Kubon")),
            ListTile(title: Text("Nils Schröder")),
            Divider(),
            ListTile(
              title: Text(
                "Third Party Software",
                style: TextStyle(fontSize: 25),
              ),
            ),
            ListTile(
              title: Text(
                  'Diese App benutzt zum Anzeigen der Karten OpenStreetMap unter der Verwendung der Lizenz GDP.'),
            )
          ],
        )));
  }
}
