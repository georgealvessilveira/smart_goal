import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_model.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/auth/presenter/signup/signup_state.dart';

class SignUpStore extends Store<SignUpState> {
  final IUserRepository _repository;

  SignUpStore(this._repository) : super(SignUpState());

  Future<void> signUp(SignUpState state) async {
    execute(() async {
      await _repository.signUp(
        UserModel(
          nickname: state.nickname ?? '',
          email: state.email ?? '',
          password: state.password ?? '',
        ),
      );
      return Future.value(state);
    });
  }
}
