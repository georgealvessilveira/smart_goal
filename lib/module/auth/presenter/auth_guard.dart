import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/module/auth/presenter/auth_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/auth/signin');

  @override
  Future<bool> canActivate(String path, ParallelRoute<dynamic> route) {
    final store = AuthStore(Modular.get<IUserRepository>());
    return store.checkCurrentUser();
  }
}
