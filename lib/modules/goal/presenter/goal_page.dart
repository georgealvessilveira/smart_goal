import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:intl/intl.dart';
import 'package:smart_goals/modules/goal/data/goal_model.dart';
import 'package:smart_goals/modules/goal/presenter/goal_state.dart';
import 'package:smart_goals/modules/goal/presenter/goal_store.dart';

class GoalPage extends StatefulWidget {
  final GoalModel? goal;

  const GoalPage({super.key, this.goal});

  @override
  State<GoalPage> createState() => _GoalPageState();
}

class _GoalPageState extends State<GoalPage> {
  final store = Modular.get<GoalStore>();
  final titleEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleEditingController.text = widget.goal?.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meta'),
      ),
      body: ScopedBuilder<GoalStore, GoalState>(
        store: store,
        onLoading: (context) => const Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        onState: (context, state) => Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Descreva em poucas palavras o que você gostaria de alcançar - aconcelhamos utilizar o método SMART.',
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 16.0, top: 16.0),
                  child: TextField(
                    style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.displaySmall?.fontSize,
                    ),
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Descreva sua meta aqui',
                    ),
                    controller: titleEditingController,
                    maxLength: 189,
                    maxLines: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: GoalEndDate(
                    state: state,
                    onTap: () async => store.endDate(
                      await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000, 1, 1),
                            lastDate: DateTime(2100, 1, 1),
                            locale: const Locale('pt', 'BR'),
                          ) ??
                          DateTime.now(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: GoalBottomAppBar(
        state: store.state,
        onPressed: () async {
          if (titleEditingController.text.isNotEmpty) {
            store.state.description = titleEditingController.text;
            await store.save();
            Modular.to.navigate('/');
          }
        },
        onDialogPressed: () async {
          await store.completeGoal();
          Modular.to.navigate('/');
        },
      ),
    );
  }
}

class GoalEndDate extends StatelessWidget {
  final GoalState state;
  final GestureTapCallback onTap;

  const GoalEndDate({
    super.key,
    required this.state,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Theme.of(context).colorScheme.secondary,
            width: 0.8,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.access_time_rounded),
              ),
              Text(_checkEndDate()),
            ],
          ),
        ),
      ),
    );
  }

  String _checkEndDate() => state.endDate == null
      ? 'Adicione uma data de conclusão'
      : DateFormat.yMMMMd('pt_BR').format(
          state.endDate ?? DateTime.now(),
        );
}

class GoalBottomAppBar extends StatelessWidget {
  final GoalState state;
  final VoidCallback? onPressed;
  final VoidCallback? onDialogPressed;

  const GoalBottomAppBar({
    super.key,
    required this.state,
    this.onPressed,
    this.onDialogPressed,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          state.id == null
              ? const SizedBox()
              : TextButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (context) => _buildGoalDialog(context),
                  ),
                  child: const Text('Marcar como concluída'),
                ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              state.id == null || state.id!.isEmpty ? 'Criar meta' : 'Salvar',
            ),
          ),
        ],
      ),
    );
  }

  AlertDialog _buildGoalDialog(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Marcar como concluída',
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text(
        'Deseja marcar a meta como concluída?',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: onDialogPressed,
          child: const Text('Concluír'),
        ),
      ],
    );
  }
}
