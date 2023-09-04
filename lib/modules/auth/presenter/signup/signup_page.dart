import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/const/app_const.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/auth/presenter/signup/signup_state.dart';
import 'package:smart_goals/modules/auth/presenter/signup/signup_store.dart';

class SignUpPage extends StatelessWidget {
  final _store = SignUpStore(UserRepositoryFirebase());
  final _nicknameEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<SignUpStore, SignUpState>(
        store: _store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) => SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0, top: 46.0),
                    child: Text(
                      'Cadastrar em $appName',
                      style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.displayLarge?.fontSize,
                        fontWeight: Theme.of(context)
                            .textTheme
                            .displayLarge
                            ?.fontWeight,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Como gostaria de ser chamado(a)',
                    ),
                    controller: _nicknameEditingController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Seu e-mail'),
                    controller: _emailEditingController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Crie uma senha',
                    ),
                    controller: _passwordEditingController,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Modular.to.navigate('signin'),
                          child: const Text('Entrar'),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            state
                              ..nickname = _nicknameEditingController.text
                              ..email = _emailEditingController.text
                              ..password = _passwordEditingController.text;
                            await _store.signUp(state);
                            Modular.to.navigate('/');
                          },
                          child: const Text('Cadastrar'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
