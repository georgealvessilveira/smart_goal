import 'package:flutter_modular/flutter_modular.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/auth/presenter/auth_guard.dart';
import 'package:smart_goals/modules/auth/presenter/auth_module.dart';
import 'package:smart_goals/modules/auth/presenter/auth_store.dart';
import 'package:smart_goals/modules/goal/data/goal_model.dart';
import 'package:smart_goals/modules/goal/data/goal_repository.dart';
import 'package:smart_goals/modules/goal/presenter/completed_goal/completed_goal_page.dart';
import 'package:smart_goals/modules/goal/presenter/goal_page.dart';
import 'package:smart_goals/modules/goal/presenter/goal_store.dart';
import 'package:smart_goals/modules/goal/presenter/goals_list/goals_list_page.dart';
import 'package:smart_goals/modules/goal/presenter/goals_list/goals_list_store.dart';

class GoalModule extends Module {
  final authGuard = AuthGuard(store: AuthStore(UserRepositoryFirebase()));

  @override
  void binds(Injector i) {
    i.add<IGoalRepository>(GoalRepositoryFirebase.new);
    i.add(GoalStore.new);
    i.add(CompletedGoalPage.new);
    i.add(GoalsListStore.new);
  }

  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const GoalsListPage(), guards: [authGuard]);
    r.child(
      '/goal',
      child: (context) => GoalPage(goal: r.args.data as GoalModel?),
    );
    r.child(
      '/completed_goal',
      child: (context) => CompletedGoalPage(goal: r.args.data as GoalModel),
    );

    r.module('/auth', module: AuthModule());
  }
}
