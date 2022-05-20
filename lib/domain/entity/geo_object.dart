import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mapbox_gl/mapbox_gl.dart';

part 'geo_object.freezed.dart';

@freezed
class GeoObject with _$GeoObject {
  const factory GeoObject.monument({
    required LatLng position,
    required String title,
    required String description,
    String? imageLink,
    DateTime? dateOfCreation,
  }) = Monument;

  const factory GeoObject.mountain({
    required LatLng position,
    required String title,
    required String description,
    String? imageLink,
  }) = Mountain;
}
