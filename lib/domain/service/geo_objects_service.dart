import 'dart:io';

import 'package:injectable/injectable.dart';

import '../entity/geo_object.dart';
import '../repository/cache_repository.dart';
import '../repository/geo_objects_repository.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

@injectable
class GeoObjectsService extends PmService {
  final GeoObjectsRepository _geoObjectsRepository;
  final CacheRepository _cacheRepository;

  GeoObjectsService(
    this._geoObjectsRepository,
    this._cacheRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler);

  Stream<List<GeoObject>> get objectsStream => _geoObjectsRepository.objectsStream;

  Future<void> loadObjects() async {
    try {
      await _geoObjectsRepository.loadObjects();
    } catch (err, st) {
      handleError(err, st);
      rethrow;
    }
  }

  Future<File> getFile(String url) async {
    return _cacheRepository.loadFile(url);
  }
}
