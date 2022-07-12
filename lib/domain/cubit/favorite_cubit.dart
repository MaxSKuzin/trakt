import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../logger.dart';
import '../entity/geo_object.dart';
import '../repository/geo_objects_repository.dart';

part 'favorite_cubit.freezed.dart';

@injectable
class FavoriteObjectsCubit extends Cubit<FavoriteObjectsState> {
  final GeoObjectsRepository _geoObjectsRepository;
  late final StreamSubscription<List<GeoObject>> _streamSubscription;

  FavoriteObjectsCubit(
    this._geoObjectsRepository,
  ) : super(const FavoriteObjectsState([])) {
    _streamSubscription = _geoObjectsRepository.favoriteaObjectsStream.listen((objects) {
      emit(FavoriteObjectsState([...objects]));
    });
  }

  @override
  Future<void> close() {
    _streamSubscription.cancel();
    return super.close();
  }

  Future<void> addToFavorites(GeoObject object) async {
    try {
      _geoObjectsRepository.addObjectToFavorites(object);
    } catch (err, st) {
      logger.e(err, err, st);
    }
  }

  Future<void> removeFromFavorites(GeoObject object) async {
    try {
      _geoObjectsRepository.removeObjectToFavorites(object);
    } catch (err, st) {
      logger.e(err, err, st);
    }
  }
}

@freezed
class FavoriteObjectsState with _$FavoriteObjectsState {
  const factory FavoriteObjectsState(List<GeoObject> items) = _FavoriteObjectsState;
}
