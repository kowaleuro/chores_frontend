import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
      Container(
      width: size.height,
          height: double.infinity,
          decoration: const BoxDecoration(
            borderRadius : BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
            ),
            color : Color.fromRGBO(238, 236, 240, 1),
          )
      ),
          child,
        ],
      ),
    );
  }
}
// Figma Flutter Generator Rectangle5Widget - RECTANGLE