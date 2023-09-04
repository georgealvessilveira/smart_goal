import 'dart:async';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/modules/auth/presenter/auth_store.dart';

class AuthGuard extends RouteGuard {
  final AuthStore store;

  AuthGuard({required this.store}) : super(redirectTo: '/auth/signin');

  @override
  Future<bool> canActivate(String path, ParallelRoute<dynamic> route) {
    return store.checkCurrentUser();
  }
}
