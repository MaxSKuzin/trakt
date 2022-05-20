import 'package:injectable/injectable.dart';

import '../entity/geo_object.dart';
import '../repository/geo_objects_repository.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

@injectable
class GeoObjectsService extends PmService {
  final GeoObjectsRepository _geoObjectsRepository;

  GeoObjectsService(
    this._geoObjectsRepository,
    ErrorHandler errorHandler,
  ) : super(errorHandler);

  Stream<List<GeoObject>> get objectsStream => _geoObjectsRepository.objectsStream;

  Future<void> loadObjects() async {
    try {
      await _geoObjectsRepository.loadObjects();
    } catch (err) {
      handleError(err);
    }
  }
}
