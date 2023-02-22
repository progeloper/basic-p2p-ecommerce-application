import 'package:amazon_clone/screens/account_screen.dart';
import 'package:amazon_clone/screens/cart_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/more_screen.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../widgets/simple_product_widget.dart';

const double kAppBarHeight = 80;

const String amazonLogoUrl =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amazon_icon.svg/2500px-Amazon_icon.svg.png";

const List<String> categoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

const List<Widget> pages = [
  HomeScreen(),
  AccountScreen(),
  CartScreen(),
  MoreScreen(),
];

final List<Widget> testList = [
  SimpleProductWidget(
    product: ProductModel(photoUrl: categoryLogos[0], productName: 'Adidas chanclas', cost: 14999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: largeAds[0], productName: 'Bala Blue', cost: 26999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: categoryLogos[0], productName: 'Townhall different', cost: 1999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: largeAds[0], productName: 'Nike chanclas', cost: 19999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: categoryLogos[0], productName: 'Puma chanclas', cost: 49999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: largeAds[0], productName: 'Umbro chanclas', cost: 9999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: categoryLogos[0], productName: 'Reebok chanclas', cost: 15000.00, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
  SimpleProductWidget(
    product: ProductModel(photoUrl: largeAds[0], productName: 'New Balance chanclas', cost: 29999.99, productId: 'fxfggfjghgghfxcvhmgc', sellerName: 'Iseoluwa Oyedotun', sellerId: 'fghfgjhfjgfhcfxd', noOfReviews: [1], discount: 0, description: 'Size 12 Uk, blue', reviewAggregate: 4),
  ),
];

//Dont even attemp to scroll to the end of this manually lmao
const String amazonLogo =
    "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a9/Amazon_logo.svg/2560px-Amazon_logo.svg.png";

const String photoUrl = 'https://contents.mediadecathlon.com/p1980629/k\$28b0a1ca6ce1e67f3ac6354f80a3d81a/sq/chanclas-adidas-adilette-piscina-adulto-azul-blanco.jpg';

const List<int> discounts = [0, 70, 60, 50];
