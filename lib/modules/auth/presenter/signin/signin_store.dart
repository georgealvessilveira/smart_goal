import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_model.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/auth/presenter/signin/signin_state.dart';

class SignInStore extends Store<SignInState> {
  final IUserRepository _repository;

  SignInStore(this._repository) : super(SignInState());

  Future<void> signIn(SignInState state) async {
    execute(() async {
      await _repository.signIn(
        UserModel(
          nickname: '',
          email: state.email ?? '',
          password: state.password ?? '',
        ),
      );
      return Future.value(state);
    });
  }
}
