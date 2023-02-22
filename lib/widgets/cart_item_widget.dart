import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/screens/product_screen.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/custom_square_button.dart';
import 'package:amazon_clone/widgets/product_information_widget.dart';
import 'package:flutter/material.dart';

import 'custom_simple_rounded_button.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height / 2,
      width: screenSize.width,
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: backgroundColor,
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: screenSize.width / 3,
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProductScreen(product: product)),
                            );
                          },
                          child: Image.network(product.photoUrl))),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: ProductInformationWidget(
                    productName: product.productName,
                    cost: product.cost,
                    seller: product.sellerName,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                CustomSquareWidget(
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40,
                    child: const Center(child: Icon(Icons.remove))),
                CustomSquareWidget(
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40,
                    child: const Center(
                        child: Text(
                      '1',
                      style: TextStyle(color: activeCyanColor),
                    ))),
                CustomSquareWidget(
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40,
                    child: const Center(child: Icon(Icons.add))),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CustomSimpleRoundedButton(
                        onPressed: ()async{
                          String res = 'An error has occurred';
                          try{
                            res = await FirestoreMethods().deleteFromCart(product.productId);
                            res = 'success';
                          }catch(e){
                            res = e.toString();
                          }
                          if(res != 'success'){
                            showSnackbar(context, 'res');
                          } else{
                            showSnackbar(context, 'Item removed from cart');
                          }
                        },
                        childText: 'Delete',
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomSimpleRoundedButton(
                        onPressed: () {},
                        childText: 'Save for later',
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      'See more like this',
                      style: TextStyle(
                        color: activeCyanColor,
                      ),
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
