import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import '../design/geo_object_modal_widget.dart';

import '../../domain/cubit/cubit_extension.dart';
import '../../domain/cubit/favorite_cubit.dart';
import '../../domain/entity/geo_object.dart';

class FavoritesScreenWMImpl extends WidgetModel implements FavoritesScreenWM {
  final FavoriteObjectsCubit _favoriteObjectsCubit;
  final _favoriteObjects = ValueNotifier(<GeoObject>[]);
  late final StreamSubscription _streamSubscription;

  factory FavoritesScreenWMImpl.create(BuildContext context) {
    return FavoritesScreenWMImpl._(context.read<FavoriteObjectsCubit>());
  }

  FavoritesScreenWMImpl._(
    this._favoriteObjectsCubit,
  );

  @override
  void initWidgetModel() {
    _streamSubscription = _favoriteObjectsCubit.listenStateAsSubject(_stateListener);

    super.initWidgetModel();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();

    super.dispose();
  }

  @override
  ValueListenable<List<GeoObject>> get favoriteObjects => _favoriteObjects;

  @override
  Future<void> onItemTap(GeoObject item) => showBarModalBottomSheet(
        context: context,
        builder: (modalContext) => GeoObjectModalWidget(
          favoriteObjectsCubit: _favoriteObjectsCubit,
          item: item,
          onLatLngTap: () async {
            await modalContext.router.pop();
            context.tabsRouter.setActiveIndex(0);
          },
        ),
      );

  void _stateListener(FavoriteObjectsState state) {
    _favoriteObjects.value = state.items;
  }

  @override
  Future<void> onFavoriteIconTap(GeoObject item) => _favoriteObjectsCubit.removeFromFavorites(item);
}

abstract class FavoritesScreenWM implements IWidgetModel {
  ValueListenable<List<GeoObject>> get favoriteObjects;

  Future<void> onItemTap(GeoObject item);

  Future<void> onFavoriteIconTap(GeoObject item);
}
