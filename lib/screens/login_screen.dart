import 'package:amazon_clone/constants/colors.dart';
import 'package:amazon_clone/constants/constants.dart';
import 'package:amazon_clone/layouts/screen_layout.dart';
import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:amazon_clone/screens/signup_screen.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:flutter/material.dart';

import '../widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool signedIn = true;
  bool isLoading = false;
  bool isEmailInFocus = false;
  bool isPasswordInFocus = false;

  void loginUser() async {
    String res = 'An error occurred';
    setState(() {
      isLoading = true;
    });
    try {
      res = await AuthMethods().loginUser(
          email: _emailController.text, password: _passwordController.text);
    } catch (e) {
      res = e.toString();
    }
    setState(() {
      isLoading = false;
      _emailController.clear();
      _passwordController.clear();
    });
    if (res != 'success') {
      showSnackbar(context, res);
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ScreenLayout()));
    }
  }

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(
              child: Hero(
                tag: 'Amazon A logo',
                child: Image(
                  image: const NetworkImage(amazonLogoUrl),
                  width: MediaQuery.of(context).size.width / 3,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                ),
                color: Colors.white,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: amazonOrange,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 46,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isEmailInFocus = true;
                        });
                      } else {
                        setState(() {
                          isEmailInFocus = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _emailController,
                      hintText: 'Email address',
                      isFocused: isEmailInFocus,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isPasswordInFocus = true;
                        });
                      } else {
                        setState(() {
                          isPasswordInFocus = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _passwordController,
                      hintText: 'Password',
                      isFocused: isPasswordInFocus,
                      obscureText: true,
                    ),
                  ),

                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Checkbox(
                            value: signedIn,
                            onChanged: (value) {
                              setState(() {
                                signedIn = value!;
                              });
                            },
                            activeColor: amazonOrangeAccent,
                          ),
                          const Text(
                            'Keep me logged in',
                            style: TextStyle(color: textFieldLabel),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {},
                        child: const Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: activeCyanColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ReusableButton(
                    callback: loginUser,
                    isLoading: isLoading,
                    color: amazonOrange,
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Don\'t have an account? ',
                            style: TextStyle(color: textFieldLabel),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignupScreen()));
                            },
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: activeCyanColor,
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
