import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget assetImage({
  required String image,
  double? height,
  double? width,
  double? scale,
  Color? color,
  BoxFit? fit,
}) {
  return Image.asset(
    image,
    height: height,
    width: width,
    scale: scale,
    color: color,
    fit: fit,
  );
}

Widget networkImage({
  required String image,
  double? height,
  double? width,
  double scale = 1.0,
  Color? color,
  BoxFit? fit,
}) {
  if (image.isEmpty) {
    return Container(
      height: height,
      width: width,
      color: Colors.grey.withOpacity(0.2),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: (height ?? width ?? 40) * 0.4,
      ),
    );
  }

  return CachedNetworkImage(
    imageUrl: image,
    height: height,
    width: width,
    fit: fit,
    color: color,
    placeholder: (context, url) => Container(
      height: height,
      width: width,
      color: Colors.grey.withOpacity(0.1),
      alignment: Alignment.center,
      child: const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    ),
    errorWidget: (context, url, error) => Container(
      height: height,
      width: width,
      color: Colors.grey.withOpacity(0.2),
      alignment: Alignment.center,
      child: Icon(
        Icons.broken_image,
        color: Colors.grey,
        size: (height ?? width ?? 40) * 0.4,
      ),
    ),
  );
}
