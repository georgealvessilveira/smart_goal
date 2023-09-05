import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_state.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_store.dart';

class ProfilePasswordPage extends StatefulWidget {
  const ProfilePasswordPage({super.key});

  @override
  State<ProfilePasswordPage> createState() => _ProfilePasswordPageState();
}

class _ProfilePasswordPageState extends State<ProfilePasswordPage> {
  final ProfileStore store = Modular.get<ProfileStore>();

  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<ProfileStore, ProfileState>(
      store: store,
      onLoading: (context) => const Center(child: CircularProgressIndicator()),
      onState: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nova senha',
                    ),
                    controller: passwordEditingController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Confirme sua nova senha',
                    ),
                    controller: confirmPasswordEditingController,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Modular.to.pushNamed('info'),
                      icon: const Icon(Icons.info),
                    ),
                    IconButton(
                      onPressed: () => Modular.to.pushNamed('edit'),
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    if (passwordEditingController.text.isNotEmpty &&
                        confirmPasswordEditingController.text.isNotEmpty &&
                        passwordEditingController.text ==
                            confirmPasswordEditingController.text) {
                      await store.updateUserPassword(
                        password: passwordEditingController.text,
                      );

                      passwordEditingController.text = '';
                      confirmPasswordEditingController.text = '';
                    }
                  },
                  child: const Text('Salvar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}