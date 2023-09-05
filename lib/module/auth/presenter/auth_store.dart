import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/module/auth/presenter/auth_state.dart';

class AuthStore extends Store<AuthState> {
  final IUserRepository _repository;

  AuthStore(this._repository) : super(AuthState());

  Future<bool> checkCurrentUser() async {
    return _repository.checkCurrentUser();
  }
}
