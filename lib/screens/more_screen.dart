import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/widgets/category_widget.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: true, hasBackButton: false),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2.2 / 3.5,
          mainAxisSpacing: 3,
        ),
        itemCount: categoriesList.length,
        itemBuilder: (BuildContext context, int index) {
          return CategoryWidget(index: index);
        },
      ),
    );
  }
}
