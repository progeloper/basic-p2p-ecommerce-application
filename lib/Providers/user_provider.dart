import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';

class UserProvider with ChangeNotifier{
  User? user;

  User? get getUser => user;

  Future<void> refreshUser() async{
    User temp = await AuthMethods().getUserDetails();
    user = temp;
  }
}