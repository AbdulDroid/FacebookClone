import 'package:facebook_clone/constants/routes.dart';
import 'package:facebook_clone/services/authservice.dart';
import 'package:facebook_clone/utils/locator.dart';
import 'package:facebook_clone/utils/navigator.dart';
import 'package:facebook_clone/viewmodel/basemodel.dart';

class StartViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();
  final NavigatorService _navigatorService = locator<NavigatorService>();

  Future hasActiveLogin() async {
    var hasUser = await _authenticationService.isLoggedIn();

    if(hasUser) {
      _navigatorService.navigateKillingOld(HomeRoute);
    } else {
      _navigatorService.navigateKillingOld(LoginRoute);
    }
  }
}