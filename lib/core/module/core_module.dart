import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/core/user/user_repository.dart';

class CoreModule extends Module {

  @override
  void exportedBinds(Injector i) {
    i.add<IUserRepository>(UserRepositoryFirebase.new);
  }
}