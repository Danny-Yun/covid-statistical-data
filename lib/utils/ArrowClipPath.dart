import 'package:flutter/material.dart';

enum ArrowDirection { UP, MIDDLE, DOWN }

class ArrowClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 20);
    path.lineTo(size.width * 0.5, 0);
    path.lineTo(size.width, size.height);
    path.close();
    return path;
  }

  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
