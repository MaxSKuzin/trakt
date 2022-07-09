import 'package:flutter/material.dart';
import 'splash_screen_wm.dart';
import '../../generated/assets.gen.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

class SplashScreen extends PmWidget<SplashScreenWM, void> {
  const SplashScreen({Key? key}) : super(SplashScreenWMImpl.create);

  @override
  Widget build(SplashScreenWM wm) {
    return Scaffold(
      body: Stack(
        children: [
          Assets.images.splash.image(
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FutureBuilder(
                    future: Future.delayed(
                      const Duration(
                        milliseconds: 200,
                      ),
                    ),
                    builder: (context, snapshot) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: snapshot.connectionState == ConnectionState.done
                          ? Text(
                              'Чуйский тракт - туристический меридиан Сибири',
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  FutureBuilder(
                    future: Future.delayed(
                      const Duration(
                        seconds: 1,
                      ),
                    ),
                    builder: (context, snapshot) => AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: snapshot.connectionState == ConnectionState.done
                          ? Text(
                              'Российское географическое общество',
                              style: Theme.of(context).textTheme.headline6?.copyWith(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                              textAlign: TextAlign.center,
                            )
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
