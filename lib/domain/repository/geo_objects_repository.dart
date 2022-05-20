import '../entity/geo_object.dart';

abstract class GeoObjectsRepository {
  Future<void> loadObjects();

  Stream<List<GeoObject>> get objectsStream;
}
