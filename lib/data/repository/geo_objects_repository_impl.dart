import 'package:injectable/injectable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/repository/geo_objects_repository.dart';
import '../dto/geo_object_dto.dart';
import '../source/local/hive_source.dart';

@LazySingleton(as: GeoObjectsRepository)
class GeoObjectsRepositoryImpl implements GeoObjectsRepository {
  final HiveSource _hiveSource;

  const GeoObjectsRepositoryImpl(this._hiveSource);

  @override
  Future<List<GeoObject>> getObjects() async {
    return [
      const GeoObject.monument(
        id: '0',
        images: [
          'https://www.russiadiscovery.ru/upload/files/files/Kavkazskie_gory.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Damavand_in_winter.jpg/220px-Damavand_in_winter.jpg',
          'https://asiamountains.net/upload/slide/slide-1960x857-07.jpg',
        ],
        position: LatLng(53.3473, 83.5850),
        title: 'Monument 1',
        description: 'Monument 1 description',
        mapIconUrl:
            'https://w7.pngwing.com/pngs/393/606/png-transparent-computer-icons-mountain-mountain-angle-white-text.png',
      ),
      const GeoObject.monument(
        id: '1',
        images: [],
        position: LatLng(53.5473, 83.7850),
        title: 'Monument 2',
        description: 'Monument 2 description',
        mapIconUrl:
            'https://w7.pngwing.com/pngs/393/606/png-transparent-computer-icons-mountain-mountain-angle-white-text.png',
      ),
      const GeoObject.mountain(
        id: '2',
        images: [
          'https://www.russiadiscovery.ru/upload/files/files/Kavkazskie_gory.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Damavand_in_winter.jpg/220px-Damavand_in_winter.jpg',
          'https://asiamountains.net/upload/slide/slide-1960x857-07.jpg',
        ],
        position: LatLng(53.2473, 83.7850),
        title: 'Mountain 1',
        description:
            'Mountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 descriptionMountain 1 description',
        mapIconUrl:
            'https://w7.pngwing.com/pngs/393/606/png-transparent-computer-icons-mountain-mountain-angle-white-text.png',
      ),
      const GeoObject.mountain(
        id: '3',
        images: [
          'https://www.russiadiscovery.ru/upload/files/files/Kavkazskie_gory.jpg',
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3d/Damavand_in_winter.jpg/220px-Damavand_in_winter.jpg',
          'https://asiamountains.net/upload/slide/slide-1960x857-07.jpg',
        ],
        position: LatLng(53.3473, 84.0),
        title: 'Mountain 2',
        description: 'Mountain 2 description',
        mapIconUrl:
            'https://w7.pngwing.com/pngs/393/606/png-transparent-computer-icons-mountain-mountain-angle-white-text.png',
      ),
    ];
  }

  @override
  Future<void> addObjectToFavorites(GeoObject object) => _hiveSource.addObjectToFavorites(
        GeoObjectDto.fromDomain(object),
      );

  @override
  Stream<List<GeoObject>> get favoriteaObjectsStream => _hiveSource.favoritesObjectsListenable.map(
        (items) => items.map((e) => e.toDomain()).toList(),
      );

  @override
  Future<void> removeObjectToFavorites(GeoObject object) => _hiveSource.removeObjectFromFavorites(
        GeoObjectDto.fromDomain(object),
      );
}
