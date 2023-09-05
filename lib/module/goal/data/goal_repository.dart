import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_goals/module/goal/data/goal_model.dart';
import 'package:logger/logger.dart';

abstract class IGoalRepository {
  save(GoalModel goal);

  findAll(bool completed);

  completeGoal(String id);

  incompleteGoal(String id);
}

class GoalRepositoryFirebase implements IGoalRepository {
  final _collection = FirebaseFirestore.instance.collection('goals');
  final _userUid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<void> save(GoalModel goal) async {
    if (goal.id == null) {
      _collection.add({
        'title': goal.title,
        'endDate': goal.endDate,
        'completed': goal.completed,
        'user_uid': _userUid,
      });
    } else {
      _collection.doc(goal.id).update({
        'title': goal.title,
        'endDate': goal.endDate,
        'completed': goal.completed,
      });
    }
  }

  @override
  Future<List<GoalModel>> findAll(bool completed) async {
    try {
      final docs = (await _collection
              .orderBy('endDate')
              .where('completed', isEqualTo: completed)
              .where('user_uid', isEqualTo: _userUid)
              .get())
          .docs;

      final goals = <GoalModel>[];
      for (var doc in docs) {
        goals.add(
          GoalModel(
            id: doc.id,
            title: doc.data()['title'],
            endDate: DateTime.fromMicrosecondsSinceEpoch(
              (doc.data()['endDate'] as Timestamp).microsecondsSinceEpoch,
            ),
            completed: doc.data()['completed'],
          ),
        );
      }

      return goals;
    } catch (e) {
      Logger().e(e);
      rethrow;
    }
  }

  @override
  Future<void> completeGoal(String id) =>
      _collection.doc(id).update({'completed': true});

  @override
  Future<void> incompleteGoal(String id) =>
      _collection.doc(id).update({'completed': false});
}
