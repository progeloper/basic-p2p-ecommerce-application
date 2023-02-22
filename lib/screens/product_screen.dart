import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cost_widget.dart';
import 'package:amazon_clone/widgets/custom_simple_rounded_button.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:amazon_clone/widgets/review_dialog.dart';
import 'package:amazon_clone/widgets/review_widget.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';

final GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

class ProductScreen extends StatefulWidget {
  final ProductModel product;
  ProductScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User? user = Provider.of<UserProvider>(context).getUser;
    bool isBuyLoading = false;
    bool isCartLoading  = false;

    return SafeArea(
      child: Scaffold(
        key: _scaffold,
        appBar: SearchBarWidget(
          isReadOnly: false,
          hasBackButton: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenSize.height -
                          (kAppBarHeight + kAppBarHeight / 2),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: kAppBarHeight / 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                widget.product.productName,
                                style: const TextStyle(
                                    color: activeCyanColor, fontSize: 17),
                              ),
                              RatingStarWidget(
                                  rating: widget.product.reviewAggregate /
                                      widget.product.noOfReviews.length),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                              alignment: Alignment.centerLeft,
                              child: Text(widget.product.description)),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              constraints: BoxConstraints(
                                maxHeight: screenSize.height / 3,
                              ),
                              child: Image.network(
                                widget.product.photoUrl,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CostWidget(
                              cost: widget.product.cost,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableButton(
                                callback: ()async{
                                  setState(() {
                                    isBuyLoading = true;
                                  });
                                  String res = 'An error occurred';
                                  try{
                                    res = await FirestoreMethods().buyItem(user!, widget.product);
                                  }catch(e){
                                    res = e.toString();
                                  }
                                  setState(() {
                                    isBuyLoading = false;
                                  });
                                  showSnackbar(context, res);
                                },
                                isLoading: isBuyLoading,
                                color: amazonOrange,
                                child: const Text('Buy now')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ReusableButton(
                                callback: () async{
                                  setState(() {
                                    isCartLoading = true;
                                  });
                                  String res = 'An error occurred';
                                  try{
                                    res = await FirestoreMethods().addToCart(widget.product);
                                  }catch(e){
                                    res = e.toString();
                                  }
                                  setState(() {
                                    isCartLoading = false;
                                  });
                                  if(res != 'success'){
                                    showSnackbar(context, res);
                                  } else{
                                    showSnackbar(context, 'Successfully added to cart');
                                  }
                                },
                                isLoading: isCartLoading,
                                color: yellowColor,
                                child: const Text('Add to cart')),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomSimpleRoundedButton(
                                onPressed: () {
                                  showDialog(
                                      context: _scaffold.currentContext!,
                                      builder: (context) => ReviewDialog(
                                          product: widget.product));
                                },
                                childText: 'Add a review for this product'),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: screenSize.height,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.product.productId)
                              .collection('reviews')
                              .snapshots(),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if(!snapshot.hasData){
                              return Container();
                            }
                            return ListView.builder(
                                itemCount:
                                    (snapshot.data! as dynamic).docs.length,
                                itemBuilder: (context, index) {
                                  DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                                  return ReviewWidget(review: ReviewModel.fromSnap(snap));
                                });
                          },
                        ))
                  ],
                ),
              ),
            ),
            const UserDetailsBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
