import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:smart_goals/core/user/user_model.dart';

abstract class IUserRepository {
  signIn(UserModel userModel);

  signUp(UserModel userModel);

  signOut();

  updateUserInfo(String nickname, String email);

  updateUserPassword(String password);

  checkCurrentUser();

  getCurrentUser();
}

class UserRepositoryFirebase implements IUserRepository {
  final _logger = Logger();
  final _auth = FirebaseAuth.instance;
  final _collection = FirebaseFirestore.instance.collection('registered_users');

  @override
  Future<void> signIn(UserModel userModel) async {
    try {
      _auth.signInWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password ?? '',
      );
    } catch (error) {
      _logger.e(error.toString(), error: error);
    }
  }

  @override
  Future<void> signUp(UserModel userModel) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: userModel.email,
        password: userModel.password ?? '',
      );

      await _collection.add({
        'user_uid': userCredential.user?.uid,
        'nickname': userModel.nickname,
        'email': userModel.email,
      });

      _auth.currentUser?.updateDisplayName(userModel.nickname);
    } catch (error) {
      _logger.e(error.toString(), error: error);
    }
  }

  @override
  Future<void> signOut() async {
    _auth.signOut();
  }

  @override
  Future<void> updateUserInfo(String nickname, String email) async {
    final userModel = await getCurrentUser();
    await _collection.doc(userModel.id).update({
      'nickname': nickname,
      'email': email,
    });
    _auth.currentUser?.updateEmail(email);
  }

  @override
  Future<void> updateUserPassword(String password) async {
    _auth.currentUser?.updatePassword(password);
  }

  @override
  Future<bool> checkCurrentUser() async {
    return _auth.currentUser != null;
  }

  @override
  Future<UserModel> getCurrentUser() async {
    Logger().d(_auth.currentUser);

    final userUid = _auth.currentUser?.uid;
    final snapshot =
        await _collection.where('user_uid', isEqualTo: userUid).limit(1).get();

    final user = snapshot.docs.first;
    return UserModel(
      id: user.id,
      nickname: user['nickname'],
      email: user['email'],
    );
  }
}
