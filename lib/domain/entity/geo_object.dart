import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

part 'geo_object.freezed.dart';

@freezed
class GeoObject with _$GeoObject {
  const factory GeoObject.monument({
    required String id,
    required List<String> images,
    required LatLng position,
    required String title,
    required String description,
    required String mapIconUrl,
    DateTime? dateOfCreation,
  }) = Monument;

  const factory GeoObject.mountain({
    required String id,
    required List<String> images,
    required LatLng position,
    required String title,
    required String description,
    required String mapIconUrl,
  }) = Mountain;
}
