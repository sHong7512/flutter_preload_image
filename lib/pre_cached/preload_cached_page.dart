import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:preload_image/main.dart';
import 'package:preload_image/pre_cached/loaded_cached_page.dart';

class PreloadCachedPage extends StatefulWidget {
  const PreloadCachedPage({Key? key}) : super(key: key);

  @override
  State<PreloadCachedPage> createState() => _PreloadCachedPageState();
}

class _PreloadCachedPageState extends State<PreloadCachedPage> {
  @override
  Widget build(BuildContext context) {
    final networkImage = CachedNetworkImage(
      imageUrl: HomeScreen.imageURL,
      imageBuilder: (context, imageProvider) {
        imageProvider.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (ImageInfo image, bool synchronousCall) {
              final imageSize = Size(image.image.width.toDouble(), image.image.height.toDouble());
              log('Fresh image size w : ${imageSize.width} h : ${imageSize.height}');

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (imageSize.width > 0 && imageSize.height > 0) {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => LoadedCachedPage(dynamicImageWidth: fixWidth(imageSize)),
                    ),
                  );
                }
              });
            },
          ),
        );
        return Container(
          height: HomeScreen.standardHeight,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
          ),
        );
      },
      errorWidget: (context, url, error) => HomeScreen.errorBox(),
    );

    return Scaffold(
      body: Opacity(opacity: 0, child: networkImage),
    );
  }

  double fixWidth(Size imageSize) {
    double fixedDynamicWidth = imageSize.width * HomeScreen.standardHeight / imageSize.height;
    log('fixed width : $fixedDynamicWidth');

    if (fixedDynamicWidth < HomeScreen.minWidth) {
      fixedDynamicWidth = HomeScreen.minWidth;
      log('refixed width : $fixedDynamicWidth');
    } else if (fixedDynamicWidth > HomeScreen.maxWidth) {
      fixedDynamicWidth = HomeScreen.maxWidth;
      log('refixed width : $fixedDynamicWidth');
    }
    return fixedDynamicWidth;
  }
}
