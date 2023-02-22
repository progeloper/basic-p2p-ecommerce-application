import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/cart_item_widget.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user!.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return ReusableButton(
                          callback: () {},
                          isLoading: false,
                          color: Colors.grey,
                          child: const Text(
                            'Loading',
                            style: TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else{
                        return ReusableButton(
                          callback: ()async{
                            String res = 'An error occurred';
                            try{
                              res = await FirestoreMethods().buyAllItemsInCart(user);
                            }catch(e){
                              res = e.toString();
                            }
                            if(res != 'success'){
                              showSnackbar(context, res);
                            } else{
                              showSnackbar(context, "All items purchased");
                            }
                          },
                          isLoading: false,
                          color: yellowColor,
                          child: Text(
                            'Proceed to buy ${(snapshot.data! as dynamic).docs.length} items',
                            style: const TextStyle(color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .collection('cart')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        return ListView.builder(
                          itemCount: (snapshot.data! as dynamic).docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              DocumentSnapshot snap =
                                  (snapshot.data! as dynamic).docs[index];
                              return CartItemWidget(
                                  product: ProductModel.fromSnap(snap));
                            }
                          },
                        );
                      }else{
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ),
            const UserDetailsBar(offset: 0),
          ],
        ),
      ),
    );
  }
}
