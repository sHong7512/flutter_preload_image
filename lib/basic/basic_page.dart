import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:preload_image/main.dart';

class BasicPage extends StatelessWidget {
  const BasicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('image asset'),
                Image.asset(
                  'assets/press_image.png',
                  color: Colors.blue,
                  width: HomeScreen.defaultWidth,
                  height: HomeScreen.defaultHeight,
                  fit: BoxFit.fill,
                ),
                const Text('cached Network Image'),
                CachedNetworkImage(
                  width: HomeScreen.defaultWidth,
                  height: HomeScreen.defaultHeight,
                  imageUrl: HomeScreen.imageURL,
                  errorWidget: (context, url, error) => HomeScreen.errorBox(),
                  fit: BoxFit.fill,
                ),
                const Text('cached Network ImageBuilder'),
                CachedNetworkImage(
                  imageUrl: HomeScreen.imageURL,
                  imageBuilder: (context, imageProvider) => Container(
                    width: HomeScreen.defaultWidth,
                    height: HomeScreen.defaultHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                      image: DecorationImage(image: imageProvider, fit: BoxFit.fill),
                    ),
                  ),
                  errorWidget: (context, url, error) => HomeScreen.errorBox(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
