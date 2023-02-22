import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/widgets/result_widget.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class ResultsScreen extends StatelessWidget {
  final String query;
  const ResultsScreen({Key? key, required this.query}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
                child: RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                          text: 'Showing results for ',
                          style: TextStyle(fontSize: 17, color: Colors.black)),
                      TextSpan(
                          text: query,
                          style: const TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            color: Colors.black,
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('products')
                      .where('product-name', isGreaterThanOrEqualTo: query)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(),);
                    } else{
                      return GridView.builder(
                        itemCount: (snapshot.data! as dynamic).docs.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 2/3),
                        itemBuilder: (context, index) {
                          DocumentSnapshot snap = (snapshot.data! as dynamic).docs[index];
                          return ResultWidget(product: ProductModel.fromSnap(snap));
                        },
                      );
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
