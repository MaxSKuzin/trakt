import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
      await installOfflineMapTiles("assets/cache.db");
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
    _controller.setMapLanguage('ru');
    _controller.onSymbolTapped.add(
      (symbol) async {
        showBarModalBottomSheet(
          context: context,
          builder: (context) => SafeArea(
            child: Container(
              height: 100,
            ),
          ),
        );
      },
    );
    if (_controller.symbolManager != null) {
      _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }

  @override
  ValueListenable<bool> get tilesLoaded => _tilesLoaded;

  Future<void> _objectsListener(List<GeoObject> items) async {
    for (var item in items) {
      final file = await _geoObjectsService.getFile(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/How_to_use_icon.svg/2214px-How_to_use_icon.svg.png');
      final data = await file.readAsBytes();
      _controller.addImage('filePath', data);
      _controller.addSymbol(
        SymbolOptions(
          iconOffset: const Offset(0, -550),
          iconImage: 'filePath',
          iconSize: 0.05,
          geometry: item.position,
          textField: item.title,
        ),
      );
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
