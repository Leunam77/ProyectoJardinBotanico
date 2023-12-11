import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final bool isSelected;

  const CustomIcon({
    Key? key,
    required this.icon,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Icon(icon),
        if (isSelected)
          Positioned(
            top: 0,
            child: SvgPicture.asset('assets/images/barrita.svg'),
          ),
      ],
    );
  }
}
