import 'package:better_buzz/core/drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        drawer: const CustomDrawer(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    minRadius: 30,
                    foregroundImage: NetworkImage(
                        'https://media.discordapp.net/attachments/778000943249096705/1140753767537578035/avatar.png'),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${FirebaseAuth.instance.currentUser?.displayName ?? "User"}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Tap to change picture',
                        style: TextStyle(
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Card(
              shadowColor: Colors.transparent,
              margin:
                  const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: ListTile(
                leading: const Icon(Icons.face),
                title: const Text('Change Name'),
                subtitle: Text(
                    FirebaseAuth.instance.currentUser?.displayName ?? "User"),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            Card(
              shadowColor: Colors.transparent,
              margin:
                  const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Change Email'),
                subtitle: Text(FirebaseAuth.instance.currentUser!.email ??
                    'No Email Found'),
                trailing: const Icon(Icons.arrow_forward),
              ),
            ),
            const Card(
              shadowColor: Colors.transparent,
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: ListTile(
                leading: Icon(Icons.lock),
                title: Text('Change Password'),
                subtitle: Text('•••••••••••••••••'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
            const Divider(
              height: 30,
              indent: 30,
              endIndent: 30,
            ),
            const Card(
              shadowColor: Colors.transparent,
              margin: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              child: ListTile(
                leading: Icon(Icons.language),
                title: Text('Change Language'),
                subtitle: Text('English'),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              final dbRef = FirebaseDatabase.instance.ref('shutdown');
              try {
                await dbRef.set("shutdown");
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Shutting down...'),
                    ),
                  );
                }
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("error"),
                  ),
                );
              }
            },
            label: const Text('Shut Down'),
            icon: const Icon(Icons.power_settings_new)));
  }
}
