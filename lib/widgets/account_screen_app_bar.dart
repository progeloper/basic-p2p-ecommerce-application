import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:flutter/material.dart';

class AccountScreenAppBar extends StatelessWidget with PreferredSizeWidget {
  const AccountScreenAppBar({Key? key})
      : preferredSize = const Size.fromHeight(kAppBarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: kAppBarHeight,
      width: screenSize.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: backgroundGradient),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15
            ),
            child: Image.network(amazonLogoUrl, height: kAppBarHeight*0.8,),
          ),
          Row(
            children: [
              IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_outlined, color: Colors.black,)),
              IconButton(onPressed: (){}, icon: const Icon(Icons.search_outlined, color: Colors.black,)),
            ],
          )
        ],
      ),
    );
  }
}
