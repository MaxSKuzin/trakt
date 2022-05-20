import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:path/path.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _tilesLoaded = false;

  @override
  initState() {
    super.initState();
    _copyTilesIntoPlace();
  }

  _copyTilesIntoPlace() async {
    await installOfflineMapTiles(join("assets", "cache.db"));
    setState(() {
      _tilesLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _tilesLoaded
          ? const MapBox()
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class MapBox extends StatelessWidget {
  const MapBox({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      myLocationTrackingMode: MyLocationTrackingMode.Tracking,
      accessToken: dotenv.env['MAPBOX_SECRET_KEY'],
      initialCameraPosition: const CameraPosition(
        zoom: 10,
        target: LatLng(53.3473, 83.7850),
      ),
    );
  }
}
