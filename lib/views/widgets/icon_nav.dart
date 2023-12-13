import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final bool isSelected;

  const CustomIcon({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SvgPicture.asset('assets/images/barrita.svg'),
      ],
    );
  }
}
