import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../models/user.dart';

class AccountScreenGreeting extends StatelessWidget {
  const AccountScreenGreeting({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kAppBarHeight / 2,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: backgroundGradient)),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.00000000000000001),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 17.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Hello, ',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 26,
                    ),
                  ),
                  TextSpan(
                    text: user!.name,
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 26,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            const Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 17),
              child: CircleAvatar(
                backgroundImage: NetworkImage('https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}