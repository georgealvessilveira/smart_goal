import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_goals/modules/goal/data/goal_model.dart';

abstract class IGoalRepository {
  save(GoalModel goal);

  findAll(bool completed);

  completeGoal(String id);

  incompleteGoal(String id);
}

class GoalRepositoryFirebase implements IGoalRepository {
  final _collection = FirebaseFirestore.instance.collection('goals');

  @override
  Future<void> save(GoalModel goal) async {
    if (goal.id == null) {
      _collection.add({
        'title': goal.description,
        'endDate': goal.endDate,
        'completed': goal.completed,
      });
    } else {
      _collection.doc(goal.id).update({
        'title': goal.description,
        'endDate': goal.endDate,
        'completed': goal.completed,
      });
    }
  }

  @override
  Future<List<GoalModel>> findAll(bool completed) async {
    final goals = <GoalModel>[];
    final docs = (await _collection
            .orderBy('endDate')
            .where('completed', isEqualTo: completed)
            .get())
        .docs;

    for (var doc in docs) {
      goals.add(
        GoalModel(
          id: doc.id,
          description: doc.data()['title'],
          endDate: DateTime.fromMicrosecondsSinceEpoch(
            (doc.data()['endDate'] as Timestamp).microsecondsSinceEpoch,
          ),
          completed: doc.data()['completed'],
        ),
      );
    }

    return goals;
  }

  @override
  Future<void> completeGoal(String id) =>
      _collection.doc(id).update({'completed': true});

  @override
  Future<void> incompleteGoal(String id) =>
      _collection.doc(id).update({'completed': false});
}
