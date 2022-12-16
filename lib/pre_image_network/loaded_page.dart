import 'package:flutter/material.dart';
import 'package:preload_image/main.dart';

class LoadedPage extends StatelessWidget {
  LoadedPage({Key? key, required this.dynamicImageWidth}) : super(key: key);

  final double dynamicImageWidth;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: dynamicImageWidth != 0 ? dynamicImageWidth : HomeScreen.defaultWidth,
          height: HomeScreen.standardHeight + HomeScreen.loadedTextHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 18, 52, 0.2),
                blurRadius: 30,
                offset: Offset(0, 16),
              ),
              BoxShadow(
                color: Color.fromRGBO(26, 59, 121, 0.2),
                blurRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              eventImage(),
              _menuTextButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget eventImage() {
    return Image.network(
      width: dynamicImageWidth != 0 ? dynamicImageWidth : HomeScreen.defaultWidth,
      height: HomeScreen.standardHeight,
      HomeScreen.imageURL,
    );
  }

  Widget _errorBox() => Container(
        width: dynamicImageWidth != 0 ? dynamicImageWidth : HomeScreen.defaultWidth,
        height: HomeScreen.standardHeight,
        decoration: const BoxDecoration(
          color: Color.fromRGBO(105, 40, 233, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: const Icon(Icons.error, color: Colors.white),
      );

  Widget _menuTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _text(padding: EdgeInsets.only(left: 48), str: 'left'),
        _text(padding: EdgeInsets.only(right: 48), str: 'right')
      ],
    );
  }

  Widget _text({required EdgeInsetsGeometry padding, required String str}) {
    return Container(
      padding: padding,
      height: HomeScreen.loadedTextHeight,
      color: Colors.transparent,
      child: Center(
        child: Text(
          str,
          style: TextStyle(
            color: Color.fromRGBO(89, 89, 89, 1),
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
