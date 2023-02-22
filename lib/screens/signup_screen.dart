import 'package:amazon_clone/resources/auth_methods.dart';
import 'package:amazon_clone/screens/login_screen.dart';
import 'package:amazon_clone/utils/utils.dart';
import 'package:amazon_clone/widgets/reusable_button.dart';
import 'package:amazon_clone/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../constants/constants.dart';
import '../layouts/screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool isLoading = false;
  bool isUsernameFocused = false;
  bool isAddressFocused = false;
  bool isEmailFocused = false;
  bool isPasswordFocused = false;

  @override
  void dispose() {
    super.dispose();

    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _addressController.dispose();
  }

  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });
    String res = "Error";
    try {
      res = await AuthMethods().createUser(
          name: _nameController.text,
          address: _addressController.text,
          email: _emailController.text,
          password: _passwordController.text);
    } catch (e) {
      res = e.toString();
    }
    setState(() {
      isLoading = false;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
      _addressController.clear();
    });
    if (res != 'success') {
      showSnackbar(context, res);
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ScreenLayout()));
    }
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
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: amazonOrange,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isUsernameFocused = true;
                        });
                      } else {
                        setState(() {
                          isUsernameFocused = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _nameController,
                      hintText: 'Enter Your Name',
                      isFocused: isUsernameFocused,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isAddressFocused = true;
                        });
                      } else {
                        setState(() {
                          isAddressFocused = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _addressController,
                      hintText: 'Address',
                      isFocused: isAddressFocused,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isEmailFocused = true;
                        });
                      } else {
                        setState(() {
                          isEmailFocused = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _emailController,
                      hintText: 'Email address',
                      isFocused: isEmailFocused,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Focus(
                    onFocusChange: (hasFocus) {
                      if (hasFocus) {
                        setState(() {
                          isPasswordFocused = true;
                        });
                      } else {
                        setState(() {
                          isPasswordFocused = false;
                        });
                      }
                    },
                    child: TextFieldWidget(
                      controller: _passwordController,
                      hintText: 'Password',
                      isFocused: isPasswordFocused,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  ReusableButton(
                    callback: signUp,
                    isLoading: isLoading,
                    color: amazonOrange,
                    child: const Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account? ',
                          style: TextStyle(color: textFieldLabel),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: const Text(
                            'Log in',
                            style: TextStyle(
                              color: activeCyanColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
