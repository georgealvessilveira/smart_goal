import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_goals/core/const/datetime.dart';

class GoalCard extends StatelessWidget {
  final String description;
  final DateTime endDate;
  final bool completed;
  final GestureTapCallback? onTap;

  const GoalCard({
    super.key,
    required this.description,
    required this.endDate,
    this.completed = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
        elevation: 0.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 0.2,
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    description,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                FutureBuilder<void>(
                  future: initializeDateFormatting('pt_BR', null),
                  builder: (context, snapshot) => Text(
                    '${formatDateTime(endDate)}${_getIfGoalIsOverdue()}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getColor(context),
                      fontSize:
                          Theme.of(context).textTheme.headlineMedium?.fontSize,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getColor(BuildContext context) {
    if (completed) {
      return Colors.lightGreen;
    }

    return endDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
        ? Colors.redAccent
        : Colors.black87;
  }

  String _getIfGoalIsOverdue() {
    if (completed) {
      return '';
    }

    return endDate.isBefore(DateTime.now().subtract(const Duration(days: 1)))
        ? ' | Atrasado'
        : '';
  }
}
