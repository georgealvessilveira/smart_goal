import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/module/goal/data/goal_model.dart';
import 'package:smart_goals/module/goal/data/goal_repository.dart';
import 'package:smart_goals/module/goal/presenter/goal_state.dart';

class GoalStore extends Store<GoalState> {
  final IGoalRepository goalRepository;

  GoalStore(this.goalRepository) : super(GoalState());

  Future<void> endDate(DateTime endDate) async {
    execute(() {
      state.endDate = endDate;
      return Future.value(state);
    });
  }

  Future<void> save() async {
    execute(
      () async {
        await goalRepository.save(
          GoalModel(
            id: state.id,
            title: state.title ?? '',
            endDate: state.endDate ?? DateTime.now(),
          ),
        );
        return Future.value(
          GoalState(
            id: state.id,
            title: state.title ?? '',
            endDate: state.endDate ?? DateTime.now(),
          ),
        );
      },
    );
  }

  Future<void> completeGoal() async {
    execute(() async {
      await goalRepository.completeGoal(state.id ?? '');
      return Future.value(
        GoalState(
          id: state.id,
          title: state.title ?? '',
          endDate: state.endDate ?? DateTime.now(),
        ),
      );
    });
  }
}
