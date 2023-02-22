import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/screens/login_screen.dart';
import 'package:amazon_clone/screens/sell_screen.dart';
import 'package:amazon_clone/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'layouts/screen_layout.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AmazonClone());
}



class AmazonClone extends StatelessWidget {
  const AmazonClone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context)=>UserProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Amazon',
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snap){
            if(snap.connectionState == ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(color: amazonOrange,),);
            } else if(snap.hasData){
              if(FirebaseAuth.instance.currentUser != null){
                return const ScreenLayout();
                }
            }
            return const SignupScreen();
          },
        ),
      ),
    );
  }
}



