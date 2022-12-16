import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:preload_image/main.dart';
import 'package:preload_image/pre_cached/loaded_cached_page.dart';

class PreloadPage extends StatefulWidget {
  const PreloadPage({Key? key}) : super(key: key);

  @override
  State<PreloadPage> createState() => _PreloadPageState();
}

class _PreloadPageState extends State<PreloadPage> {
  int loadCount = 0;
  final int loadLimit = 5;

  @override
  Widget build(BuildContext context) {
    Image networkImage = Image.network(height: HomeScreen.standardHeight, HomeScreen.imageURL);
    networkImage.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          final imageSize = Size(image.image.width.toDouble(), image.image.height.toDouble());
          log('Fresh image size w : ${imageSize.width} h : ${imageSize.height}');

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (imageSize.width > 0 && imageSize.height > 0) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => LoadedCachedPage(
                    dynamicImageWidth: fixWidth(imageSize, HomeScreen.standardHeight),
                  ),
                ),
              );
            } else if (loadCount > loadLimit) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoadedCachedPage(dynamicImageWidth: 0)),
              );
            }
          });

          if (loadCount <= loadLimit) {
            loadCount++;
            setState(() {});
          }
        },
      ),
    );

    return Scaffold(
      body: Opacity(opacity: 0, child: networkImage),
    );
  }

  double fixWidth(Size imageSize, double standardHeight) {
    double fixedDynamicWidth = imageSize.width * standardHeight / imageSize.height;
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
