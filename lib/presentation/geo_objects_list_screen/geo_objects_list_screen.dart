import 'package:flutter/material.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import 'geo_objects_list_wm.dart';

class GeoObjectsListScreenScreen extends PmWidget<GeoObjectsListWM, void> {
  const GeoObjectsListScreenScreen({Key? key}) : super(GeoObjectsListWMImpl.create);

  @override
  Widget build(GeoObjectsListWM wm) {
    return const Scaffold();
  }
}
