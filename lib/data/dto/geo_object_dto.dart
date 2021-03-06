import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import '../../domain/entity/geo_object.dart';

part 'geo_object_dto.freezed.dart';
part 'geo_object_dto.g.dart';

// @Freezed(unionKey: 'type')
@freezed
class GeoObjectDto with _$GeoObjectDto {
  @HiveType(typeId: 1)
  const factory GeoObjectDto.monument({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> images,
    @HiveField(2) required double latitude,
    @HiveField(3) required double longitude,
    @HiveField(4) required String title,
    @HiveField(5) required String description,
    @HiveField(6) required String mapIconUrl,
    @HiveField(7) DateTime? dateOfCreation,
  }) = _MonumentDto;

  @HiveType(typeId: 2)
  const factory GeoObjectDto.mountain({
    @HiveField(0) required String id,
    @HiveField(1) required List<String> images,
    @HiveField(2) required double latitude,
    @HiveField(3) required double longitude,
    @HiveField(4) required String title,
    @HiveField(5) required String description,
    @HiveField(6) required String mapIconUrl,
  }) = _MountainDto;

  const GeoObjectDto._();

  factory GeoObjectDto.fromJson(Map<String, dynamic> json) => _$GeoObjectDtoFromJson(json);

  factory GeoObjectDto.fromDomain(GeoObject object) => object.map(
        monument: (value) => GeoObjectDto.monument(
          id: value.id,
          images: value.images,
          latitude: value.position.latitude,
          longitude: value.position.latitude,
          title: value.title,
          description: value.description,
          mapIconUrl: value.mapIconUrl,
          dateOfCreation: value.dateOfCreation,
        ),
        mountain: (value) => GeoObjectDto.mountain(
          id: value.id,
          images: value.images,
          latitude: value.position.latitude,
          longitude: value.position.latitude,
          title: value.title,
          description: value.description,
          mapIconUrl: value.mapIconUrl,
        ),
      );

  GeoObject toDomain() => map(
        monument: (value) => GeoObject.monument(
          id: value.id,
          images: value.images,
          position: LatLng(
            value.latitude,
            value.longitude,
          ),
          title: value.title,
          description: value.description,
          mapIconUrl: value.mapIconUrl,
          dateOfCreation: value.dateOfCreation,
        ),
        mountain: (value) => GeoObject.mountain(
          id: value.id,
          images: value.images,
          position: LatLng(
            value.latitude,
            value.longitude,
          ),
          title: value.title,
          description: value.description,
          mapIconUrl: value.mapIconUrl,
        ),
      );
}
