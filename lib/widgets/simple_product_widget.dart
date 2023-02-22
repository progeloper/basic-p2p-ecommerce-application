import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:flutter/material.dart';

class SimpleProductWidget extends StatelessWidget {
  final ProductModel product;
  const SimpleProductWidget({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(product: product)));
      },
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          height: (screenSize.height) / 8,
          width: (screenSize.width) / 4,
          color: Colors.white,
          child: SizedBox(
              height: (screenSize.height) / 8,
              width: (screenSize.width) / 4,
              child: Image.network(product.photoUrl)),
        ),
      ),
    );
  }
}
