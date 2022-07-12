import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/cubit/geo_objects_cubit.dart';

import '../../injection.dart';
import '../router.gen.dart';

class MainWrapper extends StatefulWidget {
  static const bottomNavigationBarHeight = 40.0;

  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final _geoObjectsCubit = getIt.get<GeoObjectsCubit>()..loadObjects();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _geoObjectsCubit,
      child: AutoTabsScaffold(
        routes: const [
          MapScreenRoute(),
          GeoObjectsListScreenScreenRoute(),
        ],
        extendBody: true,
        bottomNavigationBuilder: (_, tabsRouter) => AnimatedBottomNavigationBar.builder(
          height: MainWrapper.bottomNavigationBarHeight,
          gapLocation: GapLocation.none,
          leftCornerRadius: 20,
          rightCornerRadius: 20,
          splashRadius: 0,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          itemCount: 2,
          tabBuilder: (index, isActive) => _bottomNavItem(index: index, isActive: isActive),
          activeIndex: tabsRouter.activeIndex,
          onTap: (index) => tabsRouter.setActiveIndex(index),
        ),
      ),
    );
  }

  Widget _bottomNavItem({required int index, required bool isActive}) {
    final menuItems = [
      Icons.map_outlined,
      Icons.list_alt_rounded,
    ];

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
        top: 10,
      ),
      child: FaIcon(
        menuItems[index],
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
      ),
    );
  }
}
