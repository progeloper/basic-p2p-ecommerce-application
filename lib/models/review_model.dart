import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewModel {
  final double rating;
  final String reviewer;
  final String reviewText;
  ReviewModel(
      {required this.rating, required this.reviewer, required this.reviewText});

  static ReviewModel fromSnap(DocumentSnapshot snapshot) {
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    return ReviewModel(
      rating: (map['rating'] as int).toDouble(),
      reviewer: map['name'],
      reviewText: map['text'],
    );
  }

}
