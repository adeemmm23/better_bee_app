import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  double turn = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 35, right: 35),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Hero(
                      tag: 'logo',
                      child: Image.asset(
                        'assets/logo/beee.png',
                        color: Theme.of(context).colorScheme.primary,
                        width: 90,
                      ),
                    ),
                    AnimatedRotation(
                      curve: Curves.easeInOut,
                      duration: const Duration(seconds: 2),
                      turns: turn,
                      child: Image.asset(
                        'assets/images/circle.png',
                        color: Theme.of(context).colorScheme.secondary,
                        width: 180,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                FilledButton(
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 47)),
                    ),
                    onLongPress: () {
                      setState(() {
                        turn += 1;
                      });
                    },
                    onPressed: () {
                      context.go('/auth/login');
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                const SizedBox(height: 7),
                TextButton(
                    onPressed: () {
                      context.go('/auth/register');
                    },
                    child: const Text('Register')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
