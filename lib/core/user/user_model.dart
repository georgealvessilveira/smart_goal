import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String nickname;
  final String email;
  final String? id;
  final String? password;

  const UserModel({
    required this.nickname,
    required this.email,
    this.id,
    this.password,
  });

  @override
  List<Object?> get props => [nickname, email, id, password];
}
