import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_state.dart';
import 'package:smart_goals/module/goal/presenter/profile/profile_store.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ProfileStore store = Modular.get<ProfileStore>();

  final nicknameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    store.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<ProfileStore, ProfileState>(
      store: store,
      onLoading: (context) => const Center(child: CircularProgressIndicator()),
      onState: (context, state) {
        nicknameEditingController.text = state.nickname ?? '';
        emailEditingController.text = state.email ?? '';

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Como você gostaria de ser chamado',
                    ),
                    controller: nicknameEditingController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Seu e-mail',
                    ),
                    controller: emailEditingController,
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
                      onPressed: () => Modular.to.pushNamed('password'),
                      icon: const Icon(Icons.password_rounded),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    if (nicknameEditingController.text.isNotEmpty &&
                        emailEditingController.text.isNotEmpty) {
                      await store.updateUserInfo(
                        nickname: nicknameEditingController.text,
                        email: emailEditingController.text,
                      );

                      nicknameEditingController.text = '';
                      emailEditingController.text = '';
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
