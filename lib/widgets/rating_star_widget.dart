import 'package:amazon_clone/constants/colors.dart';
import 'package:flutter/material.dart';

class RatingStarWidget extends StatelessWidget {
  final double rating;
  const RatingStarWidget({Key? key, required this.rating}) : super(key: key);

  List<Widget> getChildren(){
    List<Widget> children = [];
    for(int i=0; i<5; i++){
      if(i<rating){
        children.add(const Icon(Icons.star, color: amazonOrangeAccent,));
      } else{
        children.add(const Icon(Icons.star_border, color: amazonOrangeAccent,));
      }
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: getChildren(),
    );
  }
}
