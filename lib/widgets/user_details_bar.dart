import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailsBar extends StatelessWidget {
  final double offset;
  const UserDetailsBar({Key? key, required this.offset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).getUser;


    return Positioned(
      top: -offset/3,
      child: Container(
        height: kAppBarHeight/2,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: lightBackgroundaGradient)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 3,
            horizontal: 20,
          ),
          child: (user==null)? const Center(child: CircularProgressIndicator())
          : Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey[900],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width *0.7,
                child: Text(
                  'Deliver to ${user.name} - ${user.address}',
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Colors.grey[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
