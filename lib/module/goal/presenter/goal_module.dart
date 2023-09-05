import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/module/auth/presenter/auth_guard.dart';
import 'package:smart_goals/module/auth/presenter/auth_module.dart';
import 'package:smart_goals/module/goal/data/goal_model.dart';
import 'package:smart_goals/module/goal/data/goal_repository.dart';
import 'package:smart_goals/module/goal/presenter/completed_goal/completed_goal_page.dart';
import 'package:smart_goals/module/goal/presenter/goal_page.dart';
import 'package:smart_goals/module/goal/presenter/goal_store.dart';
import 'package:smart_goals/module/goal/presenter/goals_list/goals_list_page.dart';
import 'package:smart_goals/module/goal/presenter/goals_list/goals_list_store.dart';
import 'package:smart_goals/module/goal/presenter/profile/internal/edit_profile_internal_page.dart';
import 'package:smart_goals/module/goal/presenter/profile/internal/profile_info_internal_page.dart';
import 'package:smart_goals/module/goal/presenter/profile/internal/profile_password_internal_page.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_page.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_store.dart';

class GoalModule extends Module {
  @override
  void binds(Injector i) {
    i.add<IGoalRepository>(GoalRepositoryFirebase.new);

    i.add(GoalStore.new);
    i.add(CompletedGoalPage.new);
    i.add(GoalsListStore.new);
    i.add(ProfileStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (context) => const GoalsListPage(),
      guards: [AuthGuard()],
    );
    r.child(
      '/goal',
      child: (context) => GoalPage(goal: r.args.data as GoalModel?),
    );
    r.child(
      '/completed_goal',
      child: (context) => CompletedGoalPage(goal: r.args.data as GoalModel),
    );

    r.child('/profile', child: (context) => const ProfilePage(), children: [
      ChildRoute('/info', child: (context) => const ProfileInfoPage()),
      ChildRoute('/edit', child: (context) => const EditProfilePage()),
      ChildRoute('/password', child: (context) => const ProfilePasswordPage()),
    ]);

    r.module('/auth', module: AuthModule());
  }
}
