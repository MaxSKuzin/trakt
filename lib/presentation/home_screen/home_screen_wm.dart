import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:path/path.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/service/geo_objects_service.dart';
import '../../injection.dart';
import '../../logger.dart';

class HomeWMImpl extends WidgetModel implements HomeWM {
  final GeoObjectsService _geoObjectsService;
  final _tilesLoaded = ValueNotifier(false);

  late MapboxMapController _controller;

  factory HomeWMImpl.create(BuildContext context) {
    return HomeWMImpl._(getIt.get<GeoObjectsService>());
  }

  HomeWMImpl._(this._geoObjectsService);

  @override
  void initWidgetModel() {
    _loadTiles();
    _geoObjectsService.loadObjects();

    super.initWidgetModel();
  }

  Future<void> _loadTiles() async {
    try {
      await installOfflineMapTiles(join("assets", "cache.db"));
      _tilesLoaded.value = true;
    } catch (err) {
      logger.e(err);
    }
  }

  @override
  String get accessToken => dotenv.env['MAPBOX_SECRET_KEY']!;

  @override
  void onMapCreated(MapboxMapController controller) {
    _controller = controller;
    if (controller.symbolManager != null) {
      _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }

  @override
  ValueListenable<bool> get tilesLoaded => _tilesLoaded;

  void _objectsListener(List<GeoObject> items) {
    for (var item in items) {
      _controller.addSymbol(SymbolOptions(
        geometry: item.position,
        textField: item.title,
      ));
    }
  }

  @override
  void onStyleCreated() {
    if (_controller.symbolManager != null) {
      _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }
}

abstract class HomeWM implements IWidgetModel {
  void onMapCreated(MapboxMapController controller);

  String get accessToken;

  ValueListenable<bool> get tilesLoaded;

  void onStyleCreated();
}
