import 'dart:async';

import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/service/geo_objects_service.dart';
import '../../injection.dart';
import '../map_screen/widget/geo_object_modal.dart';

class GeoObjectsListWMImpl extends WidgetModel implements GeoObjectsListWM {
  final GeoObjectsService _geoObjectsService;
  final _key = GlobalKey<AnimatedListState>();
  final _items = <GeoObject>[];
  late final StreamSubscription _ojectsSubscription;

  factory GeoObjectsListWMImpl.create(BuildContext context) {
    return GeoObjectsListWMImpl._(getIt.get<GeoObjectsService>());
  }

  GeoObjectsListWMImpl._(this._geoObjectsService);

  @override
  void initWidgetModel() {
    _ojectsSubscription = _geoObjectsService.objectsStream.listen(_objectsListener);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _ojectsSubscription.cancel();

    super.dispose();
  }

  @override
  Key get listKey => _key;

  Future<void> _objectsListener(List<GeoObject> objects) async {
    for (var element in objects) {
      _items.add(element);
      _key.currentState?.insertItem(_items.length - 1);
    }
  }

  @override
  GeoObject getItem(int index) => _items.elementAt(index);

  @override
  Future<void> onCardTap(int index) => showBarModalBottomSheet(
        context: context,
        builder: (context) => GeoObjectModal(
          item: getItem(
            index,
          ),
        ),
      );
}

abstract class GeoObjectsListWM implements IWidgetModel {
  Key get listKey;

  GeoObject getItem(int index);

  Future<void> onCardTap(int index);
}
