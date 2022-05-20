import 'package:injectable/injectable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:rxdart/subjects.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/repository/geo_objects_repository.dart';

@LazySingleton(as: GeoObjectsRepository)
class GeoObjectsRepositoryImpl implements GeoObjectsRepository {
  final _geoObjectsSubject = BehaviorSubject.seeded(<GeoObject>[]);

  @override
  Future<void> loadObjects() async {
    _geoObjectsSubject.add([
      const GeoObject.monument(
        position: LatLng(53.3473, 83.5850),
        title: 'Monument 1',
        description: 'Monument 1 description',
      ),
      const GeoObject.monument(
        position: LatLng(53.5473, 83.7850),
        title: 'Monument 2',
        description: 'Monument 2 description',
      ),
      const GeoObject.mountain(
        position: LatLng(53.2473, 83.7850),
        title: 'Mountain 1',
        description: 'Mountain 1 description',
      ),
      const GeoObject.mountain(
        position: LatLng(53.3473, 84.0),
        title: 'Mountain 2',
        description: 'Mountain 2 description',
      ),
    ]);
  }

  @override
  Stream<List<GeoObject>> get objectsStream => _geoObjectsSubject.stream.distinct().asBroadcastStream();
}
