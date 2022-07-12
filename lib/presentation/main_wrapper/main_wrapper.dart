import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/cubit/favorite_cubit.dart';
import '../../domain/cubit/geo_objects_cubit.dart';

import '../../injection.dart';
import '../router.gen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({Key? key}) : super(key: key);

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final _geoObjectsCubit = getIt.get<GeoObjectsCubit>()..loadObjects();
  final _favoriteGeoObjectsCubit = getIt.get<FavoriteObjectsCubit>();
  final routes = [
    const MapScreenRoute(),
    const GeoObjectsListScreenScreenRoute(),
    const FavoritesScreenRoute(),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: _geoObjectsCubit,
        ),
        BlocProvider.value(
          value: _favoriteGeoObjectsCubit,
        ),
      ],
      child: AutoTabsScaffold(
        routes: routes,
        bottomNavigationBuilder: (_, tabsRouter) => AnimatedBottomNavigationBar.builder(
          height: kBottomNavigationBarHeight,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          itemCount: routes.length,
          gapLocation: GapLocation.none,
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
      Icons.favorite_rounded,
    ];

    return Container(
      alignment: Alignment.center,
      child: FaIcon(
        menuItems[index],
        color: isActive ? Colors.white : Colors.white.withOpacity(0.4),
      ),
    );
  }
}
