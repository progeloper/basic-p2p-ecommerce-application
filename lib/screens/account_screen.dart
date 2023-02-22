import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/models/order_request_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:amazon_clone/resources/firestore_methods.dart';
import 'package:amazon_clone/screens/login_screen.dart';
import 'package:amazon_clone/screens/sell_screen.dart';
import 'package:amazon_clone/widgets/account_screen_app_bar.dart';
import 'package:amazon_clone/widgets/order_showcase_listview.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:amazon_clone/widgets/showcase_listview.dart';
import 'package:amazon_clone/widgets/simple_product_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/account_screen_greeting.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AccountScreenAppBar(),
      body: (user == null)
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: SizedBox(
                height: screenSize.height,
                width: screenSize.width,
                child: Column(
                  children: [
                    AccountScreenGreeting(user: user),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReusableButton(
                        callback: () async {
                          String res = await AuthMethods().signOutUser();
                          if(res == 'success'){
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          }
                        },
                        isLoading: false,
                        color: amazonOrange,
                        child: const Text(
                          'Sign out',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ReusableButton(
                        callback: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SellScreen()));
                        },
                        isLoading: false,
                        color: yellowColor,
                        child: const Text(
                          'Sell',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user.uid)
                          .collection('orders')
                          .get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        } else {
                          List<Widget> children = [];
                          for (int i = 0;
                              i < (snapshot.data! as dynamic).docs.length;
                              i++) {
                            ProductModel product =
                                ProductModel.fromSnap(snapshot.data!.docs[i]);
                            children.add(SimpleProductWidget(product: product));
                          }
                          return OrdersShowcaseListView(
                              title: 'Your orders', children: children);
                        }
                      },
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Order Requests',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .collection('orderRequests')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (!snapshot.hasData) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  if(!snapshot.hasData){
                                    return Container();
                                  }
                                  OrderRequestModel currentRequest = OrderRequestModel.fromSnap(snapshot.data!.docs[index]);
                                  return ListTile(
                                    title: Text(
                                      'Order: ${currentRequest.orderName}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    subtitle:  Text(currentRequest.buyerAddress),
                                    trailing: IconButton(
                                      onPressed: ()async{
                                        setState(()async{
                                          await FirestoreMethods().deleteOrderRequest(currentRequest.orderId);
                                        });
                                      },
                                      icon: const Icon(Icons.check, color: Colors.grey,),
                                    ),
                                  );
                                });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

