import 'package:flutter/material.dart';

class HomeButtonDesign extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.quadraticBezierTo(size.width * 0.0630625, size.height * 0.1256167,
        size.width * 0.2500000, size.height * 0.1666667);
    path0.cubicTo(
        size.width * 0.3493125,
        size.height * 0.1788667,
        size.width * 0.5939500,
        size.height * 0.1982833,
        size.width * 0.8125000,
        size.height * 0.2533333);
    path0.quadraticBezierTo(size.width * 0.9684000, size.height * 0.3009000,
        size.width, size.height * 0.5000000);
    path0.lineTo(size.width, size.height);
    path0.quadraticBezierTo(size.width * 0.9684000, size.height * 0.8809333,
        size.width * 0.8125000, size.height * 0.8333333);
    path0.cubicTo(
        size.width * 0.5928375,
        size.height * 0.7798667,
        size.width * 0.3504250,
        size.height * 0.7574167,
        size.width * 0.2500000,
        size.height * 0.7502667);
    path0.quadraticBezierTo(size.width * 0.0616375, size.height * 0.7112333, 0,
        size.height * 0.5002667);
    path0.lineTo(0, 0);

    path0.close();
    return path0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
