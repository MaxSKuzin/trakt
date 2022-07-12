import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import '../router.gen.dart';

class SplashScreenWMImpl extends WidgetModel implements SplashScreenWM {
  factory SplashScreenWMImpl.create(BuildContext context) {
    return SplashScreenWMImpl._();
  }

  SplashScreenWMImpl._();

  @override
  void initWidgetModel() {
    _navigateToMainFlowAfterDelay();

    super.initWidgetModel();
  }

  Future<void> _navigateToMainFlowAfterDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    context.router.replace(const MainWrapperRoute());
  }
}

abstract class SplashScreenWM implements IWidgetModel {}
