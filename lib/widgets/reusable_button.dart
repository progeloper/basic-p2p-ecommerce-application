import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ReusableButton extends StatelessWidget {
  final Function() callback;
  final bool isLoading;
  final Color color;
  final Widget child;
  const ReusableButton(
      {Key? key,
      required this.callback,
      required this.isLoading,
      required this.color,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: callback,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          fixedSize: Size(
            screenSize.width * 0.5,
            40,
          ),
        ),
        child: !isLoading
            ? child
            : const Padding(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }
}
// Container(
// padding: const EdgeInsets.symmetric(
// horizontal: 38, vertical: 16),
// width: MediaQuery.of(context).size.width/2,
// decoration: BoxDecoration(
// color: color,
// borderRadius: const BorderRadius.all(
// Radius.circular(8),
// ),
// ),
// child: isLoading? const CircularProgressIndicator(
// color: Colors.white,
// ) : Center(child: child),
// ),
