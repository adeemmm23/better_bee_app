import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

int selectedIndex = 0;

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: selectedIndex,
      onDestinationSelected: (destination) {
        switch (destination) {
          case 0:
            context.pop();
            context.go('/');
            selectedIndex = 0;
            break;
          case 1:
            context.pop();
            context.go('/support');
            selectedIndex = 1;
            break;
          case 2:
            context.pop();

            context.go('/settings');
            selectedIndex = 2;
            break;
          case 3:
            context.pop();
            FirebaseAuth.instance.signOut();
            context.go('/auth');
            selectedIndex = 0;
            break;
        }
      },
      children: [
        DrawerHeader(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                'assets/logo/beee.png',
                color: Theme.of(context).colorScheme.primary,
                height: 30,
              ),
              const SizedBox(height: 10),
              Text(
                'Better Bee',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary),
              ),
              Text(
                'Discover Hive Insights',
                style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ],
          ),
        ),
        const NavigationDrawerDestination(
            icon: Icon(Icons.hive_outlined), label: Text('Home')),
        const SizedBox(height: 10),
        const NavigationDrawerDestination(
            icon: Icon(Icons.help_outline), label: Text('Help')),
        const SizedBox(height: 10),
        const NavigationDrawerDestination(
            icon: Icon(Icons.settings_outlined), label: Text('Settings')),
        const Divider(),
        const NavigationDrawerDestination(
            icon: Icon(Icons.logout), label: Text('Logout')),
      ],
    );
  }
}
