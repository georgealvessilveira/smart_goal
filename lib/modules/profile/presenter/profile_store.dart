import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_model.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/profile/presenter/profile_state.dart';
import 'package:logger/logger.dart';

class ProfileStore extends Store<ProfileState> {
  final IUserRepository userRepository;

  ProfileStore(this.userRepository) : super(ProfileState());

  Future<void> signOut() async {
    execute(() async {
      await userRepository.signOut();
      return Future.value(ProfileState());
    });
  }

  Future<void> getCurrentUser() async {
    execute(() async {
      final UserModel currentUser = await userRepository.getCurrentUser();
      Logger().d(currentUser);
      return Future.value(
        ProfileState(
          nickname: currentUser.nickname,
          email: currentUser.email,
          password: currentUser.password,
        ),
      );
    });
  }

  Future<void> updateUserInfo({
    required String nickname,
    required String email,
  }) async {
    execute(() async {
      await userRepository.updateUserInfo(nickname, email);
      return Future.value(
        ProfileState(nickname: nickname, email: email),
      );
    });
  }

  Future<void> updateUserPassword({
    required String password,
  }) async {
    execute(() async {
      await userRepository.updateUserPassword(password);
      return Future.value(
        ProfileState(password: password),
      );
    });
  }
}
