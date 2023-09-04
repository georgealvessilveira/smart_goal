import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/modules/goal/data/goal_repository.dart';
import 'package:smart_goals/modules/goal/presenter/goals_list/goals_list_state.dart';

class GoalsListStore extends Store<GoalsListState> {
  final IGoalRepository _repository;

  GoalsListStore(this._repository) : super(GoalsListState([]));

  Future<void> fetchGoals({required bool completed}) async {
    execute(() async => GoalsListState(await _repository.findAll(completed)));
  }
}
