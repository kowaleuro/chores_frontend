import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class MainImage extends StatelessWidget {
  const MainImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Figma Flutter Generator Group1Widget - GROUP
    return SizedBox(
      child: SvgPicture.asset('assets/images/main_menu.svg'),
    );
  }
}