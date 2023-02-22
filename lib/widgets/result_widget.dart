import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

class ResultWidget extends StatelessWidget {
  final ProductModel product;
  const ResultWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(product: product)));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: screenSize.width / 4,
              height: screenSize.height/7,
              child: Image.network(product.photoUrl, fit: BoxFit.scaleDown,),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Text(
                product.productName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width / 5,
                  child: FittedBox(
                    child: RatingStarWidget(
                      rating:
                          product.reviewAggregate / product.noOfReviews.length,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: (product.reviewAggregate > 0)
                      ? Text(
                          (product.reviewAggregate ~/
                                  product.noOfReviews.length)
                              .toString(),
                          style: const TextStyle(
                            color: activeCyanColor,
                          ),
                        )
                      : const Text(
                          '0',
                          style: TextStyle(
                            color: activeCyanColor,
                          ),
                        ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
              child: FittedBox(
                child: CostWidget(
                  cost: product.cost,
                  color: const Color.fromARGB(255, 92, 9, 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
