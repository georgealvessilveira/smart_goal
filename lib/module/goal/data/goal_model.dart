import 'package:equatable/equatable.dart';

class GoalModel extends Equatable {
  final String? id;
  final String title;
  final DateTime? startDate;
  final DateTime endDate;
  final bool completed;

  const GoalModel({
    this.id,
    required this.title,
    this.startDate,
    required this.endDate,
    this.completed = false,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        startDate,
        endDate,
        completed,
      ];
}
