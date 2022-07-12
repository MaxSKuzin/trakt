import 'package:collection/collection.dart';
import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/cubit/favorite_cubit.dart';

import '../../domain/entity/geo_object.dart';
import 'cached_swiper.dart';

class GeoObjectModalWidget extends StatelessWidget {
  final FavoriteObjectsCubit favoriteObjectsCubit;
  final GeoObject item;
  final Function()? onLatLngTap;

  const GeoObjectModalWidget({
    Key? key,
    required this.item,
    required this.onLatLngTap,
    required this.favoriteObjectsCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final span = TextSpan(
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 18,
          ),
      text: item.description,
    );

    final textPainter = TextPainter(
      text: span,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    );

    textPainter.layout(maxWidth: MediaQuery.of(context).size.width);

    final height = textPainter.didExceedMaxLines ? MediaQuery.of(context).size.height * 3 / 4 : null;

    return SafeArea(
      child: Container(
        height: height,
        padding: const EdgeInsets.only(
          right: 15,
          left: 15,
          top: 25,
        ),
        child: FadingEdgeScrollView.fromSingleChildScrollView(
          shouldDisposeScrollController: true,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: BlocBuilder<FavoriteObjectsCubit, FavoriteObjectsState>(
                    bloc: favoriteObjectsCubit,
                    builder: (context, state) {
                      final isFavorite = state.items.firstWhereOrNull((element) => item.id == element.id) != null;
                      return IconButton(
                        key: Key('${item.hashCode}'),
                        onPressed: () => isFavorite
                            ? favoriteObjectsCubit.removeFromFavorites(item)
                            : favoriteObjectsCubit.addToFavorites(item),
                        icon: AnimatedSwitcher(
                          duration: const Duration(
                            milliseconds: 300,
                          ),
                          child: Icon(
                            isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                            color: Theme.of(context).errorColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headline5,
                ),
                const SizedBox(
                  height: 15,
                ),
                CachedSwiper(
                  imageUrls: item.images,
                  height: MediaQuery.of(context).size.width - 30,
                  width: MediaQuery.of(context).size.width - 30,
                  borderRadius: BorderRadius.circular(8),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextButton(
                    onPressed: onLatLngTap,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.location_on,
                        ),
                        Text(
                            '${item.position.latitude.toStringAsFixed(2)} ${item.position.longitude.toStringAsFixed(2)}'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 18,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
