import 'package:facebook_clone/constants/routes.dart';
import 'package:facebook_clone/services/authservice.dart';
import 'package:facebook_clone/services/dialog_service.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'basemodel.dart';

class SignUpSignInViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigatorService _navigator = locator<NavigatorService>();
  final DialogService _dialogService = locator<DialogService>();
  bool loginBusy = false;
  bool registerBusy = false;

  Future signUp(
      {@required String email,
      @required String password,
      BuildContext context}) async {
    setBusy(true);
    registerBusy = true;

    var result = await _authenticationService.signUpWithEmail(
        email: email, password: password);

    registerBusy = false;
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigator.navigateKillingOld(HomeRoute);
      } else {
        if (context == null) {
          await _dialogService.showDialog(
            title: 'Register Failure',
            description: 'Registration failed, please try again',
          );
        } else {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text('Registration failed, please try again')));
        }
      }
    } else {
      if (context == null) {
        await _dialogService.showDialog(
          title: 'Register Failure',
          description: result,
        );
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(result),
        ));
      }
    }
  }

  Future login({@required String email, @required String password, BuildContext context}) async {
    setBusy(true);
    loginBusy = true;
    var result = await _authenticationService.loginWithEmail(
        email: email, password: password);

    loginBusy = false;
    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigator.navigateKillingOld(HomeRoute);
      } else {
        if(context == null) {
        await _dialogService.showDialog(
          title: 'Sign In Failure',
          description: 'Sign in failed, please try again',
        );
        } else {
          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Sign in failed, please try again'),));
        }
      }
    } else {
      if(context == null) {
      await _dialogService.showDialog(
        title: 'Sign In Failure',
        description: result,
      );
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text(result),));
      }
    }
  }
}
