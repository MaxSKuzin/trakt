import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import 'home_screen_wm.dart';

class HomeScreen extends PmWidget<HomeWM, void> {
  const HomeScreen({Key? key}) : super(HomeWMImpl.create);

  @override
  Widget build(HomeWM wm) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<bool>(
        valueListenable: wm.tilesLoaded,
        builder: (_, value, child) => value ? child! : const CircularProgressIndicator(),
        child: MapboxMap(
          myLocationTrackingMode: MyLocationTrackingMode.Tracking,
          accessToken: wm.accessToken,
          onMapCreated: wm.onMapCreated,
          annotationOrder: const [
            AnnotationType.symbol,
          ],
          onStyleLoadedCallback: wm.onStyleCreated,
          initialCameraPosition: const CameraPosition(
            zoom: 10,
            target: LatLng(53.3473, 83.7850),
          ),
        ),
      ),
    );
  }
}
