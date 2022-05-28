import 'package:flutter/material.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

class GeoObjectsListWMImpl extends WidgetModel implements GeoObjectsListWM {
  factory GeoObjectsListWMImpl.create(BuildContext context) {
    return GeoObjectsListWMImpl._();
  }

  GeoObjectsListWMImpl._();
}

abstract class GeoObjectsListWM implements IWidgetModel {}