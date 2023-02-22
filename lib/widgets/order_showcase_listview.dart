import 'package:amazon_clone/constants/colors.dart';
import 'package:flutter/material.dart';

class OrdersShowcaseListView extends StatelessWidget {
  final String title;
  final List<Widget> children;

  OrdersShowcaseListView(
      {Key? key, required this.title, required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double height = screenSize.height / 4;
    double titleHeight = 25;

    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      height: height,
      width: screenSize.width,
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  '  show more',
                  style: TextStyle(
                    color: activeCyanColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height - titleHeight - 26,
            width: screenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

