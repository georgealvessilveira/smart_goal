import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/const/app_const.dart';
import 'package:smart_goals/core/user/user_repository.dart';
import 'package:smart_goals/modules/auth/presenter/signin/signin_state.dart';
import 'package:smart_goals/modules/auth/presenter/signin/signin_store.dart';

class SignInPage extends StatelessWidget {
  final _store = SignInStore(UserRepositoryFirebase());
  final _emailEditingController = TextEditingController();
  final _passwordEditingController = TextEditingController();

  SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<SignInStore, SignInState>(
        store: _store,
        onLoading: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        onState: (context, state) {
          return SafeArea(
            child: Center(
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
                          appName,
                          style: TextStyle(
                            fontSize: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontSize,
                            fontWeight: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.fontWeight,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      TextField(
                        decoration: const InputDecoration(labelText: 'E-mail'),
                        controller: _emailEditingController,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: const InputDecoration(labelText: 'Senha'),
                        controller: _passwordEditingController,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(32.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton(
                              onPressed: () => Modular.to.navigate('signup'),
                              child: const Text('Cadastrar'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                state
                                  ..email = _emailEditingController.text
                                  ..password = _passwordEditingController.text;
                                await _store.signIn(state);
                                Modular.to.navigate('/');
                              },
                              child: const Text('Entrar'),
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
          );
        },
      ),
    );
  }
}
