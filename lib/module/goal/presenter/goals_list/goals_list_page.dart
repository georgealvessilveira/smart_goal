import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/module/goal/data/goal_model.dart';
import 'package:smart_goals/module/goal/presenter/goal_card.dart';
import 'package:smart_goals/module/goal/presenter/goals_list/goals_list_state.dart';
import 'package:smart_goals/module/goal/presenter/goals_list/goals_list_store.dart';

class GoalsListPage extends StatefulWidget {
  const GoalsListPage({super.key});

  @override
  State<GoalsListPage> createState() => _GoalsListPageState();
}

class _GoalsListPageState extends State<GoalsListPage> {
  final GoalsListStore store = Modular.get<GoalsListStore>();

  @override
  void initState() {
    super.initState();
    store.fetchGoals(completed: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suas metas'),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('/profile'),
            icon: const Icon(Icons.perm_identity_sharp),
          ),
        ],
      ),
      body: ScopedBuilder<GoalsListStore, GoalsListState>(
        store: store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          return RefreshIndicator(
            onRefresh: () => store.fetchGoals(completed: false),
            child: state.goals.isEmpty
                ? ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(
                      left: 16.0,
                      right: 16.0,
                      bottom: 48.0,
                    ),
                    children: [
                      Container(height: 200.0),
                      Text(
                        'Não há metas criadas, crie uma meta!',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 8.0),
                    itemCount: state.goals.length,
                    itemBuilder: (context, index) => _buildGoalCard(
                      state.goals[index],
                    ),
                  ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CompletedGoalsBottomSheet(),
            FloatingActionButton(
              onPressed: () => Modular.to.pushNamed('/goal'),
              elevation: 0.0,
              child: Icon(
                Icons.add,
                color: Theme.of(context).colorScheme.primary,
                size: 28.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalCard(GoalModel goal) {
    return GoalCard(
      description: goal.title,
      endDate: goal.endDate,
      onTap: () => Modular.to.pushNamed(
        '/goal',
        arguments: goal,
      ),
    );
  }
}

class CompletedGoalsBottomSheet extends StatefulWidget {
  const CompletedGoalsBottomSheet({super.key});

  @override
  State<CompletedGoalsBottomSheet> createState() =>
      _CompletedGoalsBottomSheetState();
}

class _CompletedGoalsBottomSheetState extends State<CompletedGoalsBottomSheet> {
  final store = Modular.get<GoalsListStore>();

  @override
  void initState() {
    super.initState();
    store.fetchGoals(completed: true);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<GoalsListStore, GoalsListState>(
      store: store,
      onLoading: (context) => const Center(child: CircularProgressIndicator()),
      onState: (context, state) => TextButton(
        onPressed: () => showBottomSheet(
          context: context,
          builder: (context) => BottomSheet(
            enableDrag: false,
            onClosing: () => Navigator.pop(context),
            builder: (context) => RefreshIndicator(
              onRefresh: () => store.fetchGoals(completed: true),
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  left: 8.0,
                  right: 8.0,
                ),
                itemCount: state.goals.length,
                itemBuilder: (context, index) => _buildGoalCard(
                  state.goals[index],
                ),
              ),
            ),
          ),
        ),
        child: const Text('Metas concluídas'),
      ),
    );
  }

  Widget _buildGoalCard(GoalModel goal) {
    return GoalCard(
      description: goal.title,
      endDate: goal.endDate,
      completed: true,
      onTap: () => Modular.to.pushNamed(
        '/completed_goal',
        arguments: goal,
      ),
    );
  }
}
