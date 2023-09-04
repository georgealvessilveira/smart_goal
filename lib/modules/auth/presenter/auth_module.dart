import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/modules/auth/presenter/signin/signin_page.dart';
import 'package:smart_goals/modules/auth/presenter/signup/signup_page.dart';

class AuthModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/signin', child: (context) => SignInPage());
    r.child('/signup', child: (context) => SignUpPage());
  }
}
