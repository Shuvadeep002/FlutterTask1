import 'package:flutter/cupertino.dart';

class ScreenSize{
  final double width;
  final double height;

  ScreenSize(this.width, this.height);

  factory ScreenSize.of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenSize(size.width, size.height);
  }
}