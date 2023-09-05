import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/module/goal/data/goal_repository.dart';
import 'package:smart_goals/module/goal/presenter/completed_goal/completed_goal_state.dart';

class CompletedGoalStore extends Store<CompletedGoalState> {
  final IGoalRepository goalRepository;

  CompletedGoalStore(this.goalRepository) : super(CompletedGoalState());

  Future<void> incompleteGoal() async {
    execute(() async {
      await goalRepository.incompleteGoal(state.id ?? '');
      return Future.value(
        CompletedGoalState(
          id: state.id,
          description: state.description ?? '',
          endDate: state.endDate ?? DateTime.now(),
        ),
      );
    });
  }
}
