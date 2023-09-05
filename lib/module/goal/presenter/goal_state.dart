class GoalState {
  String? id = '';
  String? title = '';
  DateTime? endDate;

  GoalState({
    this.id,
    this.title,
    this.endDate,
  });

  void update({
    String? id,
    String? title,
    DateTime? endDate,
  }) {
    this.id = id;
    this.title = title;
    this.endDate = endDate;
  }
}
