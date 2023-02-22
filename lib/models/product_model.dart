import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  final String photoUrl;
  final String productName;
  String description;
  final double cost;
  final String productId;
  final String sellerName;
  final String sellerId;
  final int discount;
  List noOfReviews;
  int reviewAggregate;
  ProductModel({
    required this.photoUrl,
    required this.productName,
    this.description = '',
    required this.cost,
    required this.productId,
    required this.discount,
    required this.sellerName,
    required this.sellerId,
    required this.noOfReviews,
    this.reviewAggregate=0,
  });

  Map<String, dynamic> returnMap() {
    return {
      'photo-url': photoUrl,
      'product-name': productName,
      'description': description,
      'cost': cost,
      'product-id': productId,
      'seller-name': sellerName,
      'seller-id': sellerId,
      'discount': discount,
      'no-of-reviews': noOfReviews,
      'review-aggregate': reviewAggregate,
    };
  }

  static ProductModel fromSnap(DocumentSnapshot snap) {
    var map = snap.data() as Map<String, dynamic>;

    return ProductModel(
      photoUrl: map['photo-url'],
      productName: map['product-name'],
      description: map['description'],
      cost: map['cost'],
      productId: map['product-id'],
      discount: map['discount'],
      sellerName: map['seller-name'],
      sellerId: map['seller-id'],
      noOfReviews: map['no-of-reviews'],
      reviewAggregate: map['review-aggregate'],
    );
  }
}
