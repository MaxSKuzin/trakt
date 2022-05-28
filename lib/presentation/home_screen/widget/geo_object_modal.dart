import 'package:fading_edge_scrollview/fading_edge_scrollview.dart';
import 'package:flutter/material.dart';

import '../../../domain/entity/geo_object.dart';
import '../../design/cached_swiper.dart';

class GeoObjectModal extends StatelessWidget {
  final GeoObject item;

  const GeoObjectModal({
    Key? key,
    required this.item,
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
