import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/modules/profile/presenter/internal/edit_profile_internal_page.dart';
import 'package:smart_goals/modules/profile/presenter/internal/profile_info_internal_page.dart';
import 'package:smart_goals/modules/profile/presenter/internal/profile_password_internal_page.dart';
import 'package:smart_goals/modules/profile/presenter/privacy_policy/privacy_policy_page.dart';
import 'package:smart_goals/modules/profile/presenter/profile_page.dart';

class ProfileModule extends Module {
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const ProfilePage(), children: [
      ChildRoute('/info', child: (context) => const ProfileInfoPage()),
      ChildRoute('/edit', child: (context) => const EditProfilePage()),
      ChildRoute('/password', child: (context) => const ProfilePasswordPage()),
    ]);
    r.child('/privacy_policy', child: (context) => const PrivacyPolicyPage());
  }
}
