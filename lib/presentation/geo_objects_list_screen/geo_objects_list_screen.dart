import 'package:flutter/material.dart';
import 'package:pmobi_mwwm/pmobi_mwwm.dart';

import '../design/cached_swiper.dart';
import 'geo_objects_list_wm.dart';

class GeoObjectsListScreenScreen extends PmWidget<GeoObjectsListWM, void> {
  const GeoObjectsListScreenScreen({Key? key}) : super(GeoObjectsListWMImpl.create);

  @override
  Widget build(GeoObjectsListWM wm) {
    return Scaffold(
      appBar: AppBar(),
      body: AnimatedList(
        key: wm.listKey,
        padding: const EdgeInsets.only(
          bottom: 10,
          top: 10,
        ),
        itemBuilder: (_, index, animation) {
          final item = wm.getItem(index);
          return SizeTransition(
            sizeFactor: animation,
            child: FadeTransition(
              opacity: animation,
              child: GestureDetector(
                onTap: () => wm.onCardTap(index),
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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              textAlign: TextAlign.start,
                              style: wm.theme.textTheme.headline6,
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
