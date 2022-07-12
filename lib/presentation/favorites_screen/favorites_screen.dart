import 'package:flutter/material.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';
import '../../domain/entity/geo_object.dart';
import 'favorites_screen_wm.dart';

import '../design/cached_swiper.dart';

class FavoritesScreen extends PmWidget<FavoritesScreenWM, void> {
  const FavoritesScreen({Key? key}) : super(FavoritesScreenWMImpl.create);

  @override
  Widget build(FavoritesScreenWM wm) {
    return Scaffold(
      appBar: AppBar(),
      body: ValueListenableBuilder<List<GeoObject>>(
        valueListenable: wm.favoriteObjects,
        builder: (_, value, __) => ListView.builder(
          padding: const EdgeInsets.only(
            bottom: 10,
            top: 10,
          ),
          itemCount: value.length,
          itemBuilder: (_, index) {
            final item = value[index];
            return FavoriteItemWidget(
              item: item,
              onTap: wm.onItemTap,
              onFavoriteIconTap: wm.onFavoriteIconTap,
            );
          },
        ),
      ),
    );
  }
}

class FavoriteItemWidget extends StatelessWidget {
  final GeoObject item;
  final Function(GeoObject item) onTap;
  final Function(GeoObject item) onFavoriteIconTap;

  const FavoriteItemWidget({
    Key? key,
    required this.item,
    required this.onTap,
    required this.onFavoriteIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(item),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 10,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedSwiper(
              height: 200,
              imageUrls: item.images,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(
                  8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Flexible(
                          child: Text(
                            item.description,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => onFavoriteIconTap(item),
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: Theme.of(context).errorColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
