import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../entity/geo_object.dart';
import '../repository/geo_objects_repository.dart';

part 'geo_objects_cubit.freezed.dart';

@injectable
class GeoObjectsCubit extends Cubit<GeoObjectsState> {
  final GeoObjectsRepository _geoObjectsRepository;

  GeoObjectsCubit(
    this._geoObjectsRepository,
  ) : super(const GeoObjectsState.loading());

  Future<void> loadObjects() async {
    final items = await _geoObjectsRepository.getObjects();
    emit(
      GeoObjectsState.ready(
        items,
      ),
    );
  }
}

@freezed
class GeoObjectsState with _$GeoObjectsState {
  const factory GeoObjectsState.loading() = _Loading;

  const factory GeoObjectsState.ready(
    List<GeoObject> objects,
  ) = _Ready;
}
