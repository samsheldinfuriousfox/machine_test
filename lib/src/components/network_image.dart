import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  /* final double size; */
  final String? imageUrl;

  const CustomNetworkImage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl ??
          "https://www.unfe.org/wp-content/uploads/2019/04/SM-placeholder.png",
      fit: BoxFit.cover,
      progressIndicatorBuilder: (context, url, progress) => Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: const CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: const Icon(
          Icons.error,
          color: Colors.red,
          size: 15,
        ),
      ),
    );
  }
}
