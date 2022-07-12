import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../../domain/cubit/favorite_cubit.dart';
import '../../domain/cubit/cache_cubit.dart';
import '../../domain/cubit/cubit_extension.dart';
import '../../injection.dart';
import '../../domain/cubit/geo_objects_cubit.dart';
import '../../generated/assets.gen.dart';
import '../design/geo_object_modal_widget.dart';

import '../../domain/entity/geo_object.dart';
import '../../logger.dart';

class MapWMImpl extends WidgetModel implements MapWM {
  static const minZoomForUserLocation = 15.0;
  static const symbolDataKey = 'data';

  final GeoObjectsCubit _geoObjectsCubit;
  final _tilesLoaded = ValueNotifier(false);
  bool _isInitialized = false;
  late StreamSubscription<GeoObjectsState> _objectsSubscription;
  final FavoriteObjectsCubit _favoriteObjectsCubit;

  late MapboxMapController _controller;

  factory MapWMImpl.create(BuildContext context) {
    return MapWMImpl._(
      context.read<GeoObjectsCubit>(),
      context.read<FavoriteObjectsCubit>(),
    );
  }

  MapWMImpl._(
    this._geoObjectsCubit,
    this._favoriteObjectsCubit,
  );

  @override
  void initWidgetModel() {
    _loadTiles();

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
          builder: (context) => GeoObjectModalWidget(
            favoriteObjectsCubit: _favoriteObjectsCubit,
            item: item,
            onLatLngTap: null,
          ),
        );
      },
    );
    if (_controller.symbolManager != null) {
      _objectsSubscription = _geoObjectsCubit.listenStateAsSubject(_addObjectsOnMap);
    }
  }

  @override
  ValueListenable<bool> get tilesLoaded => _tilesLoaded;

  Future<void> _addObjectsOnMap(GeoObjectsState state) async {
    state.maybeWhen(
      ready: (items) async {
        for (var item in items) {
          final fileCubit = getIt.get<FileCubit>();
          await fileCubit.getFile(item.mapIconUrl);
          final fileMountain = fileCubit.state;
          if (fileMountain == null) {
            return;
          }
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
      },
      orElse: () => null,
    );
  }

  @override
  void onStyleCreated() {
    if (_controller.symbolManager != null) {
      _addObjectsOnMap(_geoObjectsCubit.state);
      _objectsSubscription = _geoObjectsCubit.listenStateAsSubject(_addObjectsOnMap);
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
