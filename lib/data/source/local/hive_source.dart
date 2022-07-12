import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/subjects.dart';
import '../../dto/geo_object_dto.dart';

@preResolve
@singleton
class HiveSource {
  final _favoritesOnjectsSubject = BehaviorSubject.seeded(<GeoObjectDto>[]);
  final _favoritesObjectsBoxName = 'favorites';
  late final Box<GeoObjectDto> _favoritesObjectsBox;

  @factoryMethod
  static Future<HiveSource> create() async {
    final instance = HiveSource._();
    await instance._initialize();
    return instance;
  }

  HiveSource._();

  Future<void> _initialize() async {
    await Hive.initFlutter();

    Hive
      ..registerAdapter(MonumentDtoAdapter())
      ..registerAdapter(MountainDtoAdapter());

    _favoritesObjectsBox = await Hive.openBox(_favoritesObjectsBoxName);
    _favoritesObjectsBox.listenable().addListener(_favoritesObjectsListener);
  }

  List<GeoObjectDto> getFavoritesObjects() {
    _favoritesObjectsBox.listenable();
    return _favoritesObjectsBox.values.toList();
  }

  Stream<List<GeoObjectDto>> get favoritesObjectsListenable => _favoritesOnjectsSubject.asBroadcastStream();

  Future<void> addObjectToFavorites(GeoObjectDto object) async {
    await _favoritesObjectsBox.add(object);
  }

  void _favoritesObjectsListener() {
    _favoritesOnjectsSubject.add(
      _favoritesObjectsBox.values.toList(),
    );
  }
}
