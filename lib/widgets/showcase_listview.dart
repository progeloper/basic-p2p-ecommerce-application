import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsShowcaseListView extends StatelessWidget {
  final String title;
  int discount;

  ProductsShowcaseListView(
      {Key? key, required this.title, this.discount = 0})
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
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('discount', isEqualTo: discount)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot snap =
                          (snapshot.data as dynamic).docs[index];
                      return SimpleProductWidget(
                        product: ProductModel.fromSnap(snap),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
