import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import '../main_wrapper/main_wrapper.dart';
import 'map_screen_wm.dart';

class MapScreen extends PmWidget<MapWM, void> {
  const MapScreen({Key? key}) : super(MapWMImpl.create);

  @override
  Widget build(MapWM wm) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: ClipOval(
        child: Material(
          color: wm.theme.colorScheme.background,
          child: InkWell(
            onTap: wm.onLocationButtonTap,
            onDoubleTap: () => wm.onLocationButtonTap(true),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.gps_fixed_rounded,
                size: 32,
              ),
            ),
          ),
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
          logoViewMargins: const Point(
            10,
            MainWrapper.bottomNavigationBarHeight + 50,
          ),
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
