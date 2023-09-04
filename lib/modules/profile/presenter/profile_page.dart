import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/profile/presenter/profile_state.dart';
import 'package:smart_goals/modules/profile/presenter/profile_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final store = ProfileStore(UserRepositoryFirebase());

  @override
  void initState() {
    super.initState();
    Modular.to.navigate('info');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Modular.to.navigate('/'),
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Perfil'),
        actions: [
          IconButton(
            onPressed: () => Modular.to.pushNamed('privacy_policy'),
            icon: const Icon(Icons.policy_rounded),
          ),
          SignOutButton(),
        ],
      ),
      body: const RouterOutlet(),
    );
  }
}

class SignOutButton extends StatelessWidget {
  final store = ProfileStore(UserRepositoryFirebase());

  SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedBuilder<ProfileStore, ProfileState>(
      store: store,
      onState: (context, state) => IconButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Saindo da conta',
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headlineLarge?.fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                'Ter certeza que deseja sair da conta?',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () async {
                    await store.signOut();
                    Modular.to.navigate('/auth/signin');
                  },
                  child: const Text('Sair'),
                ),
              ],
            );
          },
        ),
        icon: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
