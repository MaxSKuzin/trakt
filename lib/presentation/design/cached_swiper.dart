import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CachedSwiper extends StatefulWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final List<String> imageUrls;
  final BorderRadius borderRadius;
  final Function()? onTap;
  final Axis? scrollDirection;

  const CachedSwiper({
    required this.imageUrls,
    required this.borderRadius,
    this.scrollDirection,
    this.height,
    this.width,
    Key? key,
    this.fit,
    this.onTap,
  }) : super(key: key);

  @override
  State<CachedSwiper> createState() => _CachedSwiperState();
}

class _CachedSwiperState extends State<CachedSwiper> {
  final _controller = SwiperController();
  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onTap,
      child: SizedBox(
        height: widget.height,
        width: widget.width,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: widget.imageUrls.isNotEmpty
              ? Swiper(
                  scrollDirection: widget.scrollDirection ?? Axis.horizontal,
                  itemCount: widget.imageUrls.length,
                  loop: widget.imageUrls.length > 1,
                  itemBuilder: (context, index) {
                    return CachedNetworkImage(
                      imageUrl: widget.imageUrls[index],
                      height: double.infinity,
                      width: double.infinity,
                      fit: widget.fit ?? BoxFit.cover,
                      progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        padding: const EdgeInsets.all(15),
                        height: double.infinity,
                        width: double.infinity,
                        child: const Icon(Icons.error_outline_rounded),
                      ),
                    );
                  },
                )
              : Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: widget.borderRadius,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text('There are no attached photos'),
                ),
        ),
      ),
    );
  }
}
