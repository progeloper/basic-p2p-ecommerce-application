import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ScreenLayout extends StatefulWidget {
  const ScreenLayout({Key? key}) : super(key: key);

  @override
  State<ScreenLayout> createState() => _ScreenLayoutState();
}

class _ScreenLayoutState extends State<ScreenLayout> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  void changePage(int page){
    _pageController.jumpToPage(page);
    setState(() {
      currentPage = page;
    });
  }

  void addData()async{
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    await userProvider.refreshUser();
  }


  @override
  void initState() {
    addData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: backgroundColor,
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: pages,
          ),
          bottomNavigationBar: Container(
            decoration:  BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[400]!, width: 1,),),),
            child: TabBar(
              onTap: changePage,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home_outlined, color: (currentPage == 0)? activeCyanColor : Colors.black,),),
                Tab(icon: Icon(Icons.account_circle_outlined, color: (currentPage == 1)? activeCyanColor : Colors.black,),),
                Tab(icon: Icon(Icons.shopping_cart_outlined, color: (currentPage == 2)? activeCyanColor : Colors.black,),),
                Tab(icon: Icon(Icons.menu, color: (currentPage == 3)? activeCyanColor : Colors.black,),),
              ],
              indicator: const BoxDecoration(
                border: Border(top: BorderSide(color: activeCyanColor, width: 4,),),
              ),
              indicatorSize: TabBarIndicatorSize.label,
            ),
          ),
        ),
      ),
    );
  }
}
