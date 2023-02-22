import 'package:cloud_firestore/cloud_firestore.dart';

class OrderRequestModel {
  final String orderId;
  final String orderName;
  final String buyerAddress;
  OrderRequestModel(
      {required this.orderId,
      required this.orderName,
      required this.buyerAddress,});

  Map<String, dynamic> returnMap(OrderRequestModel orderRequest) {
    return {
      'orderId': orderRequest.orderId,
      'order-name': orderRequest.orderName,
      'buyer-address': orderRequest.buyerAddress,
    };
  }

  static OrderRequestModel fromSnap(DocumentSnapshot snapshot) {
    var map = snapshot.data() as Map<String, dynamic>;

    return OrderRequestModel(
        orderId: map['orderId'],
        orderName: map['order-name'],
        buyerAddress: map['buyer-address']);
  }
}
