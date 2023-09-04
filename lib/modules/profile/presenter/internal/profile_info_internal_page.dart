import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/profile/presenter/profile_state.dart';
import 'package:smart_goals/modules/profile/presenter/profile_store.dart';

class ProfileInfoPage extends StatefulWidget {
  const ProfileInfoPage({super.key});

  @override
  State<ProfileInfoPage> createState() => _ProfileInfoPageState();
}

class _ProfileInfoPageState extends State<ProfileInfoPage> {
  final nicknameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();

  final store = ProfileStore(UserRepositoryFirebase());

  @override
  void initState() {
    super.initState();
    store.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<ProfileStore, ProfileState>(
        store: store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          nicknameEditingController.text = state.nickname ?? '';
          emailEditingController.text = state.email ?? '';

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Com você é chamado',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          store.state.nickname ?? '',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'E-mail cadastrado',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        Text(
                          store.state.email ?? '',
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .headlineLarge
                                ?.fontSize,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Modular.to.navigate('edit'),
                  icon: const Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () => Modular.to.navigate('password'),
                  icon: const Icon(Icons.password_rounded),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}