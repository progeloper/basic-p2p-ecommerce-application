import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/widgets/banner_ad.dart';
import 'package:amazon_clone/widgets/categories_listview.dart';
import 'package:amazon_clone/widgets/search_bar_widget.dart';
import 'package:amazon_clone/widgets/showcase_listview.dart';
import 'package:amazon_clone/widgets/user_details_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double offset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      setState(() {
        offset = _scrollController.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: kAppBarHeight / 2),
                  const CategoriesListView(),
                  const BannerAd(),
                  ProductsShowcaseListView(
                    title: 'Up to 70% off',
                    discount: 70,
                  ),
                  ProductsShowcaseListView(
                    title: 'Up to 60% off',
                    discount: 60,
                  ),
                  ProductsShowcaseListView(
                    title: 'Up to 50% off',
                    discount: 50,
                  ),
                  ProductsShowcaseListView(
                    title: 'Explore',
                  ),
                ],
              ),
            ),
            UserDetailsBar(offset: offset),
          ],
        ));
  }
}
