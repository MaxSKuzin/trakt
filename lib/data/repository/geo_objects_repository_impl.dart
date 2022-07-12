import 'package:injectable/injectable.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

import '../../domain/entity/geo_object.dart';
import '../../domain/repository/geo_objects_repository.dart';

@LazySingleton(as: GeoObjectsRepository)
class GeoObjectsRepositoryImpl implements GeoObjectsRepository {
  @override
  Future<List<GeoObject>> getObjects() async {
    return [
      const GeoObject.monument(
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
        images: [],
        position: LatLng(53.5473, 83.7850),
        title: 'Monument 2',
        description: 'Monument 2 description',
        mapIconUrl:
            'https://w7.pngwing.com/pngs/393/606/png-transparent-computer-icons-mountain-mountain-angle-white-text.png',
      ),
      const GeoObject.mountain(
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
}
