import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

import '../models/user.dart';

class ReviewDialog extends StatelessWidget {
  final ProductModel product;
  const ReviewDialog({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final Size screenSize = MediaQuery.of(context).size;
    final User? user = Provider.of<UserProvider>(context).getUser;

    return RatingDialog(
        title: const Text(
          'Leave a review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        submitButtonText: 'Submit',
        starSize: 35,
        onSubmitted: (response) async{
          String res = 'An error occurred';
          try{
            res = await FirestoreMethods().postReview(productId: product.productId, uid: user!.uid, rating: response.rating.toInt(), name: user.name, text: response.comment);
          }catch(e){
            res = e.toString();
          }
        });
  }
}
