import 'package:equatable/equatable.dart';

class GoalModel extends Equatable {
  final String? id;
  final String description;
  final DateTime? startDate;
  final DateTime endDate;
  final bool completed;

  const GoalModel({
    this.id,
    required this.description,
    this.startDate,
    required this.endDate,
    this.completed = false,
  });

  @override
  List<Object?> get props => [
        description,
        startDate,
        endDate,
        completed,
      ];
}
