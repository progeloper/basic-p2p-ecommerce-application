import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:flutter/material.dart';

class BannerAd extends StatefulWidget {
  const BannerAd({Key? key}) : super(key: key);

  @override
  State<BannerAd> createState() => _BannerAdState();
}

class _BannerAdState extends State<BannerAd> {
  int currentAd = 0;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    double smallAdHeight = screenSize.width/5;

    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == largeAds.length - 1) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [backgroundColor, backgroundColor.withOpacity(0)],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAdHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getIndexedSmallAd(0, smallAdHeight),
                getIndexedSmallAd(1, smallAdHeight),
                getIndexedSmallAd(2, smallAdHeight),
                getIndexedSmallAd(3, smallAdHeight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getIndexedSmallAd(int index, double height) {
    return Container(
      height: height,
      width: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(smallAds[index]),
            const SizedBox(height: 5,),
            Text(adItemNames[index]),
          ],
        ),
      ),
    );
  }
}
