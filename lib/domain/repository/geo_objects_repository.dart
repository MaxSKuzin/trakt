import '../entity/geo_object.dart';

abstract class GeoObjectsRepository {
  Future<List<GeoObject>> getObjects();

  Stream<List<GeoObject>> get favoriteaObjectsStream;

  Future<void> addObjectToFavorites(GeoObject object);

  Future<void> removeObjectToFavorites(GeoObject object);
}
