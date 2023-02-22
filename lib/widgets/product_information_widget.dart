import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:flutter/material.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String seller;
  Color color;
  ProductInformationWidget(
      {Key? key,
      required this.productName,
      required this.cost,
      required this.seller,
      this.color = Colors.black})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            productName,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 15,
                letterSpacing: 0.8,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: CostWidget(cost: cost, color: color),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Sold by ',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    text: seller,
                    style: const TextStyle(
                      fontSize: 14,
                      color: activeCyanColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
