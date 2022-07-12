import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import '../../domain/cubit/favorite_cubit.dart';

import '../../domain/cubit/cubit_extension.dart';
import '../../domain/cubit/geo_objects_cubit.dart';
import '../../domain/entity/geo_object.dart';
import '../design/geo_object_modal_widget.dart';

class GeoObjectsListWMImpl extends WidgetModel implements GeoObjectsListWM {
  final GeoObjectsCubit _geoObjectsCubit;
  final FavoriteObjectsCubit _favoriteObjectsCubit;
  final _key = GlobalKey<AnimatedListState>();
  final _items = <GeoObject>[];
  late final StreamSubscription _ojectsSubscription;

  factory GeoObjectsListWMImpl.create(BuildContext context) {
    return GeoObjectsListWMImpl._(
      context.read<GeoObjectsCubit>(),
      context.read<FavoriteObjectsCubit>(),
    );
  }

  GeoObjectsListWMImpl._(
    this._geoObjectsCubit,
    this._favoriteObjectsCubit,
  );

  @override
  void initWidgetModel() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _ojectsSubscription = _geoObjectsCubit.listenStateAsSubject(_objectsListener);
    });

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _ojectsSubscription.cancel();

    super.dispose();
  }

  @override
  Key get listKey => _key;

  Future<void> _objectsListener(GeoObjectsState state) async {
    state.maybeWhen(
      ready: (objects) {
        for (var element in objects) {
          _items.add(element);
          _key.currentState?.insertItem(_items.length - 1);
        }
      },
      orElse: () => false,
    );
  }

  @override
  GeoObject getItem(int index) => _items.elementAt(index);

  @override
  Future<void> onCardTap(int index) => showBarModalBottomSheet(
        context: context,
        builder: (modalContext) => GeoObjectModalWidget(
          favoriteObjectsCubit: _favoriteObjectsCubit,
          item: getItem(
            index,
          ),
          onLatLngTap: () async {
            await modalContext.router.pop();
            context.tabsRouter.setActiveIndex(0);
          },
        ),
      );
}

abstract class GeoObjectsListWM implements IWidgetModel {
  Key get listKey;

  GeoObject getItem(int index);

  Future<void> onCardTap(int index);
}
