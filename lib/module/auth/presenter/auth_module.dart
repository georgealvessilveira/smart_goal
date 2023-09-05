import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/module/auth/presenter/auth_store.dart';
import 'package:smart_goals/module/auth/presenter/signin/signin_page.dart';
import 'package:smart_goals/module/auth/presenter/signin/signin_store.dart';
import 'package:smart_goals/module/auth/presenter/signup/signup_page.dart';
import 'package:smart_goals/module/auth/presenter/signup/signup_store.dart';

class AuthModule extends Module {
  @override
  void binds(Injector i) {
    i.add(AuthStore.new);
    i.add(SignInStore.new);
    i.add(SignUpStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/signin', child: (context) => const SignInPage());
    r.child('/signup', child: (context) => const SignUpPage());
  }
}
