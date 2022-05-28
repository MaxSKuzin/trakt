import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'widget/geo_object_modal.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/service/geo_objects_service.dart';
import '../../injection.dart';
import '../../logger.dart';

class HomeWMImpl extends WidgetModel implements HomeWM {
  static const minZoomForUserLocation = 15.0;
  static const symbolDataKey = 'data';

  final GeoObjectsService _geoObjectsService;
  final _tilesLoaded = ValueNotifier(false);
  bool _isInitialized = false;

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
          builder: (context) => GeoObjectModal(item: item),
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
        {
          symbolDataKey: item,
        },
      );
    }
  }

  @override
  void onStyleCreated() {
    if (_controller.symbolManager != null) {
      _geoObjectsService.objectsStream.listen(_objectsListener);
    }
  }

  @override
  Future<void> onLocationButtonTap() async {
    if (!_isInitialized) {
      return;
    }
    final userLocation = await _controller.requestMyLocationLatLng();
    final zoom = _controller.cameraPosition?.zoom ?? minZoomForUserLocation;
    if (userLocation != null) {
      await _controller.animateCamera(
        CameraUpdate.newLatLngZoom(
          userLocation,
          zoom < minZoomForUserLocation ? minZoomForUserLocation : zoom,
        ),
      );
    }
  }

  @override
  EdgeInsets get viewPadding => MediaQuery.of(context).viewPadding;

  @override
  Size get screenSize => MediaQuery.of(context).size;
}

abstract class HomeWM implements IWidgetModel {
  void onMapCreated(MapboxMapController controller);

  String get accessToken;

  ValueListenable<bool> get tilesLoaded;

  void onStyleCreated();

  Future<void> onLocationButtonTap();

  EdgeInsets get viewPadding;

  Size get screenSize;
}