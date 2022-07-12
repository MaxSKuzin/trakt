import '../entity/geo_object.dart';

abstract class GeoObjectsRepository {
  Future<List<GeoObject>> getObjects();
}
