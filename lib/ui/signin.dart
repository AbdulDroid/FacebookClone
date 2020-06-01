import 'dart:io';

import 'package:facebook_clone/constants/colors.dart';
import 'package:facebook_clone/viewmodel/signupviewmodel.dart';
import 'package:facebook_clone/widgets/authbutton.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:flutter/services.dart';
import 'package:provider_architecture/provider_architecture.dart';

class SignInSignUpScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInSignUpScreenState();
}

class _SignInSignUpScreenState extends State<SignInSignUpScreen> {
  final _key = GlobalKey<FormState>();
  bool isPasswordVisible;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isPasswordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpSignInViewModel>.withConsumer(
      viewModelBuilder: () => SignUpSignInViewModel(),
      builder: (context, model, _) => WillPopScope(
        onWillPop: () async {
          var platform = Theme.of(context).platform;
          if (platform == TargetPlatform.android) {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          } else if (platform == TargetPlatform.iOS) {
            exit(0);
          }
          return true;
        },
        child: Scaffold(
          body: Form(
            key: _key,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 111.0, left: 22.0, right: 22.0),
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Facebook',
                          style: TextStyle(
                            fontSize: 20,
                            color: blue,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 8.0,
                          right: 110.0,
                        ),
                        child: Text(
                          'Connect with friend and stay safe',
                          style: TextStyle(
                            color: textDark,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 35.0,
                          left: 8.0,
                        ),
                        child: TextFormField(
                          controller: emailController,
                          validator: (value) {
                            Pattern pattern =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(pattern);
                            if (value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!regExp.hasMatch(value)) {
                              return 'Please enter a valid email';
                            } else {
                              return null;
                            }
                          },
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: textDark,
                            fontWeight: FontWeight.normal,
                            fontSize: 20.0,
                          ),
                          cursorColor: strokeDarker,
                          decoration: InputDecoration(
                            hintText: 'Email Address',
                            hintStyle: TextStyle(
                              color: textLight,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          top: 30.0,
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a password';
                            } else if (value.length < 6) {
                              return 'Password too short';
                            } else if (value == 'password' ||
                                value == 'PASSWORD' ||
                                value == '123456') {
                              return 'Weak password, please set a stronger password';
                            } else {
                              return null;
                            }
                          },
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: isPasswordVisible,
                          autofocus: false,
                          cursorColor: strokeDarker,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: textLight,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: strokeDarker,
                                width: 2,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible;
                                });
                              },
                              color:
                                  isPasswordVisible ? Colors.grey[800] : blue,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 8.0,
                          right: 73.0,
                          top: 21.0,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'By signing up , you have accepted the ',
                              ),
                              TextSpan(
                                  text: 'Terms and Conditions',
                                  style: TextStyle(
                                    color: blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      debugPrint('Navigate user to TnC page');
                                    }),
                              TextSpan(
                                text: ' of this service',
                              ),
                            ],
                            style: TextStyle(
                              color: textLighter,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 21.0),
                            child: ButtonWithLoader(
                              loading: model.loginBusy,
                              onPressed: () {
                                if (_key.currentState.validate()) {
                                  model.login(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                                setState(() {
                                  isPasswordVisible = true;
                                });
                                debugPrint('Sign User into app');
                              },
                              text: 'Sign in',
                              color: blue,
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 21.0),
                              child: ButtonWithLoader(
                                loading: model.registerBusy,
                                onPressed: () {
                                  if (_key.currentState.validate()) {
                                    model.signUp(
                                        email: emailController.text,
                                        password: passwordController.text);
                                  }
                                  setState(() {
                                    isPasswordVisible = true;
                                  });
                                  debugPrint(
                                      'Register new User to the platform');
                                },
                                text: 'Register',
                                color: buttonBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
