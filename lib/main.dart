import 'package:flutter/material.dart';
import 'package:preload_image/basic/basic_page.dart';
import 'package:preload_image/pre_cached/preload_cached_page.dart';
import 'package:preload_image/pre_image_network/preload_page.dart';


void main() {
  runApp(
    const MaterialApp(
      home: HomeScreen(),
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const String imageURL = 'http://cdn.nsu.smartkids.uangel.com:8080/webdav2/tomo2/AVT/202207/avtc_13419_07181205044.jpg';
  static const double standardHeight = 200;
  static const double defaultWidth = 300;
  static const double defaultHeight = 300;
  static const double minWidth = 200;
  static const double maxWidth = 500;
  static const double loadedTextHeight = 100;

  static Widget errorBox() => Container(
    width: defaultWidth,
    height: defaultHeight,
    decoration: const BoxDecoration(
      color: Color.fromRGBO(105, 40, 233, 1),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(32),
        topRight: Radius.circular(32),
      ),
    ),
    child: const Icon(Icons.error, color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BasicPage()));
                },
                child: const Text('Basic'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PreloadPage()));
                },
                child: const Text('Dynamic'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PreloadCachedPage()));
                },
                child: const Text('Dynamic cached'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
