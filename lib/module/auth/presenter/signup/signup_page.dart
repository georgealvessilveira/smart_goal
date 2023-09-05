import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:smart_goals/core/const/app_const.dart';
import 'package:smart_goals/module/auth/presenter/signup/signup_state.dart';
import 'package:smart_goals/module/auth/presenter/signup/signup_store.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final SignUpStore store = Modular.get<SignUpStore>();

  final nicknameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedBuilder<SignUpStore, SignUpState>(
        store: store,
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
                    controller: nicknameEditingController,
                  ),
                  TextField(
                    decoration: const InputDecoration(labelText: 'Seu e-mail'),
                    controller: emailEditingController,
                  ),
                  TextField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Crie uma senha',
                    ),
                    controller: passwordEditingController,
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
                              ..nickname = nicknameEditingController.text
                              ..email = emailEditingController.text
                              ..password = passwordEditingController.text;
                            await store.signUp(state);
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
