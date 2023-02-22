import 'package:amazon_clone/models/review_model.dart';
import 'package:amazon_clone/widgets/rating_star_widget.dart';
import 'package:flutter/material.dart';

class ReviewWidget extends StatelessWidget {
  final ReviewModel review;
  const ReviewWidget({Key? key, required this.review}) : super(key: key);
  static const List<String> ratingDesc = ['Very Poor', 'Poor', 'Average', 'Very Good', 'Excellent'];


  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              review.reviewer,
              style: const TextStyle(
                  color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenSize.width/4,
                  child: FittedBox(
                    child: RatingStarWidget(
                      rating: review.rating,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    ratingDesc[review.rating.round()-1],
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              review.reviewText,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}
