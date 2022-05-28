import 'package:auto_route/auto_route.dart';

import 'geo_objects_list_screen/geo_objects_list_screen.dart';
import 'main_wrapper/main_wrapper.dart';
import 'map_screen/map_screen.dart';

@AdaptiveAutoRouter(
  routes: [
    AdaptiveRoute(
      page: MainWrapper,
      initial: true,
      children: [
        AdaptiveRoute(
          page: MapScreen,
          initial: true,
        ),
        AdaptiveRoute(
          page: GeoObjectsListScreenScreen,
        ),
      ],
    ),
  ],
)
class $AppRouter {}
