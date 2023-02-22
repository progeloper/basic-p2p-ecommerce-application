import 'dart:typed_data';

import 'package:amazon_clone/models/order_request_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/models/user.dart' as model;
import 'package:amazon_clone/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../constants/constants.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> uploadProduct(
      {required String productName,
      required String cost,
      required String description,
      required Uint8List productPhoto,
      required String sellerId,
      required String sellerName,
      required int discount}) async {
    String res = 'An error occurred';
    try {
      String productPhotoUrl =
          await StorageMethods().uploadImgToStorage('products', productPhoto);
      String productId = const Uuid().v1();
      ProductModel productModel = ProductModel(
        description: description,
        photoUrl: productPhotoUrl,
        productName: productName,
        cost: double.parse(cost),
        productId: productId,
        discount: discounts[discount],
        sellerName: sellerName,
        sellerId: sellerId,
        noOfReviews: [],
      );
      await _firestore
          .collection('products')
          .doc(productId)
          .set(productModel.returnMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> postReview(
      {required String productId,
      required String text,
      required String uid,
      required int rating,
      required String name}) async {
    String res = 'An error occurred';
    try {
      String reviewId = const Uuid().v1();
      await _firestore.collection('products').doc(productId).update({
        'no-of-reviews': FieldValue.arrayUnion([reviewId]),
        'review-aggregate': FieldValue.increment(rating),
      });
      await _firestore
          .collection('products')
          .doc(productId)
          .collection('reviews')
          .doc(reviewId)
          .set({
        'review-id': reviewId,
        'product-id': productId,
        'rating': rating,
        'text': text,
        'name': name,
        'uid': uid,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addToCart(ProductModel product) async {
    String res = 'An error has occurred';
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(product.productId)
          .set(product.returnMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deleteFromCart(String productId) async {
    String res = 'An error has occurred';
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .doc(productId)
          .delete();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> addToOrders(ProductModel product) async {
    String res = 'An error has occurred';
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orders')
          .doc(product.productId)
          .set(product.returnMap());
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> buyAllItemsInCart(model.User buyer) async {
    String res = 'An error occurred';
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('cart')
          .get();
      for (int i = 0; i < snapshot.docs.length; i++) {
        DocumentSnapshot snap = snapshot.docs[i];
        ProductModel product = ProductModel.fromSnap(snap);
        addToOrders(product);
        await sendOrderRequest(buyer.address, product);
        await deleteFromCart(ProductModel.fromSnap(snap).productId);
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> buyItem(model.User buyer, ProductModel product)async{
    String res = 'An error occurred';
    try{
      addToOrders(product);
      await sendOrderRequest(buyer.address, product);
      res = 'success';
    }catch(e){
      res = e.toString();
    }
    return res;
  }

  Future<String> sendOrderRequest(
      String buyerAddress, ProductModel product) async {
    String res = 'An error occurred';
    String orderId = const Uuid().v1();
    OrderRequestModel orderRequest = OrderRequestModel(
        orderId: orderId,
        orderName: product.productName,
        buyerAddress: buyerAddress);
    try {
      await _firestore
          .collection('users')
          .doc(product.sellerId)
          .collection('orderRequests')
          .doc(orderId)
          .set(orderRequest.returnMap(orderRequest));
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> deleteOrderRequest(String orderId) async {
    String res = 'An error has occurred';
    try {
      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .collection('orderRequests')
          .doc(orderId)
          .delete();
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

}
