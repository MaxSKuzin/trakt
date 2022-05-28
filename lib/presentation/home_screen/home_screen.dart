import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import 'home_screen_wm.dart';

class HomeScreen extends PmWidget<HomeWM, void> {
  const HomeScreen({Key? key}) : super(HomeWMImpl.create);

  @override
  Widget build(HomeWM wm) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: wm.onLocationButtonTap,
        child: const Icon(
          Icons.gps_fixed_rounded,
          size: 32,
        ),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: wm.tilesLoaded,
        builder: (_, value, child) => value ? child! : const CircularProgressIndicator(),
        child: MapboxMap(
          myLocationTrackingMode: MyLocationTrackingMode.Tracking,
          trackCameraPosition: true,
          accessToken: wm.accessToken,
          onMapCreated: wm.onMapCreated,
          compassViewMargins: Point(wm.screenSize.width - 50, wm.viewPadding.top),
          logoViewMargins: Point(10, wm.viewPadding.bottom),
          attributionButtonMargins: const Point(-10, -10),
          myLocationEnabled: true,
          annotationOrder: const [
            AnnotationType.symbol,
            AnnotationType.fill,
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
