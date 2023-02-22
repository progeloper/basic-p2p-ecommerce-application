import 'package:flutter/material.dart';

class CustomSquareWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  final double dimension;
  const CustomSquareWidget({
    Key? key,
    required this.child,
    required this.onPressed,
    required this.color,
    required this.dimension,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: dimension,
        width: dimension,
        decoration: ShapeDecoration(
          color: color,
            shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
          side: const BorderSide(color: Colors.grey, width: 1),
        )),
        child: child,
      ),
    );
  }
}
