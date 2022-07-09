import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../generated/assets.gen.dart';
import 'widget/geo_object_modal.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/service/geo_objects_service.dart';
import '../../injection.dart';
import '../../logger.dart';

class MapWMImpl extends WidgetModel implements MapWM {
  static const minZoomForUserLocation = 15.0;
  static const symbolDataKey = 'data';

  final GeoObjectsService _geoObjectsService;
  final _tilesLoaded = ValueNotifier(false);
  bool _isInitialized = false;
  late StreamSubscription _objectsSubscription;

  late MapboxMapController _controller;

  factory MapWMImpl.create(BuildContext context) {
    return MapWMImpl._(getIt.get<GeoObjectsService>());
  }

  MapWMImpl._(this._geoObjectsService);

  @override
  void initWidgetModel() {
    _loadTiles();
    _geoObjectsService.loadObjects();

    super.initWidgetModel();
  }

  Future<void> _loadTiles() async {
    try {
      await installOfflineMapTiles(Assets.caches.cache);
      _tilesLoaded.value = true;
    } catch (err) {
      logger.e(err);
    }
  }

  @override
  void dispose() {
    _objectsSubscription.cancel();

    super.dispose();
  }

  @override
  String get accessToken => dotenv.env['MAPBOX_SECRET_KEY']!;

  @override
  void onMapCreated(MapboxMapController controller) {
    _isInitialized = true;
    _controller = controller;
    _controller.setMapLanguage('ru');
    _controller.onSymbolTapped.add(
      (symbol) async {
        final item = symbol.data?[symbolDataKey] as GeoObject?;
        if (item == null) {
          return;
        }
        showBarModalBottomSheet(
          context: context,
          builder: (context) => GeoObjectModal(
            item: item,
            onLatLngTap: null,
          ),
        );
      },
    );
    if (_controller.symbolManager != null) {
      _objectsSubscription = _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }

  @override
  ValueListenable<bool> get tilesLoaded => _tilesLoaded;

  Future<void> _objectsListener(List<GeoObject> items) async {
    for (var item in items) {
      final fileMountain = await _geoObjectsService.getFile(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Mountain_Icon.svg/1200px-Mountain_Icon.svg.png');
      final data = await fileMountain.readAsBytes();
      _controller.addImage('filePath', data);
      _controller.addSymbol(
        SymbolOptions(
          iconOffset: const Offset(0, -550),
          iconImage: 'filePath',
          iconSize: 0.1,
          geometry: item.position,
          textField: item.title,
        ),
        {
          symbolDataKey: item,
        },
      );
    }
  }

  @override
  void onStyleCreated() {
    if (_controller.symbolManager != null) {
      _objectsSubscription = _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }

  @override
  Future<void> onLocationButtonTap([bool doubleTapped = false]) async {
    if (!_isInitialized) {
      return;
    }
    final userLocation = await _controller.requestMyLocationLatLng();
    final zoom = _controller.cameraPosition?.zoom ?? minZoomForUserLocation;
    if (userLocation != null) {
      await _controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          userLocation,
          zoom < minZoomForUserLocation || doubleTapped ? minZoomForUserLocation : zoom,
        ),
      );
    }
  }

  @override
  EdgeInsets get viewPadding => MediaQuery.of(context).viewPadding;

  @override
  EdgeInsets get viewInsets => MediaQuery.of(context).viewInsets;

  @override
  Size get screenSize => MediaQuery.of(context).size;
}

abstract class MapWM implements IWidgetModel {
  void onMapCreated(MapboxMapController controller);

  String get accessToken;

  ValueListenable<bool> get tilesLoaded;

  void onStyleCreated();

  Future<void> onLocationButtonTap([bool doubleTapped = false]);

  EdgeInsets get viewPadding;

  EdgeInsets get viewInsets;

  Size get screenSize;
}
