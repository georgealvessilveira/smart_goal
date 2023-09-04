import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:smart_goals/modules/goal/data/goal_model.dart';
import 'package:smart_goals/modules/goal/data/goal_repository.dart';
import 'package:smart_goals/modules/goal/presenter/completed_goal/completed_goal_state.dart';
import 'package:smart_goals/modules/goal/presenter/completed_goal/completed_goal_store.dart';

class CompletedGoalPage extends StatefulWidget {
  final GoalModel goal;

  const CompletedGoalPage({super.key, required this.goal});

  @override
  State<CompletedGoalPage> createState() => _CompletedGoalPageState();
}

class _CompletedGoalPageState extends State<CompletedGoalPage> {
  final store = CompletedGoalStore(GoalRepositoryFirebase());

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: const Text('Meta concluída'),
    );

    return ScopedBuilder<CompletedGoalStore, CompletedGoalState>(
      store: store,
      onLoading: (context) {
        return Scaffold(
          appBar: appBar,
          body: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
      onState: (context, state) {
        state.id = widget.goal.id;
        state.description = widget.goal.description;
        state.endDate = widget.goal.endDate;

        return Scaffold(
          appBar: appBar,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Descrição'),
                        Text(
                          state.description ?? '',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Data de conclusão da meta'),
                        Text(
                          DateFormat.yMMMMd('pt_BR').format(
                            state.endDate ?? DateTime.now(),
                          ),
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .displaySmall
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => _buildGoalDialog(context),
                  ),
                  child: const Text('Desmarcar como concluída'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  AlertDialog _buildGoalDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Desmarcar como concluída',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Deseja desmarcar a meta como concluída?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () async {
            await store.incompleteGoal();
            Modular.to.navigate('/');
          },
          child: const Text('Desmarcar meta'),
        ),
      ],
    );
  }
}
