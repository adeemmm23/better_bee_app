import 'package:better_buzz/core/drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Image.asset(
          'assets/logo/beee.png',
          color: Theme.of(context).colorScheme.primary,
          height: 30,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 13),
            child: CircleAvatar(
              radius: 17,
              foregroundImage: NetworkImage(
                  "https://media.discordapp.net/attachments/778000943249096705/1140753767537578035/avatar.png"),
            ),
          )
        ],
      ),
      drawer: const CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 40),
              child: Text('Here you can see all your hives!',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary)),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 10, top: 3),
              child: Text(
                  'Select one of your hives to see more information about it! or add a new one!',
                  style: TextStyle(
                      fontSize: 15,
                      color: Theme.of(context).colorScheme.onBackground)),
            ),
          ),
          const SizedBox(height: 20),
          Wrap(
            alignment: WrapAlignment.start,
            children: [
              const HiveCard(
                title: 'Hive 1',
                description: 'Sousse',
                icon: Icons.hive,
                location: 'hive1',
              ),
              const HiveCard(
                title: 'Hive 2',
                description: 'Sousse',
                icon: Icons.hive,
              ),
              const HiveCard(
                title: 'Hive 3',
                description: 'Sousse',
                icon: Icons.hive,
              ),
              const HiveCard(
                title: 'Hive 4',
                description: 'Sousse',
                icon: Icons.hive,
              ),
              SizedBox(
                height: 180,
                width: 180,
                child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shadowColor: Colors.transparent,
                    elevation: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton.filled(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.add,
                            size: 50,
                          ),
                        )
                      ],
                    )),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HiveCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  final String location;
  const HiveCard(
      {Key? key,
      required this.title,
      required this.description,
      required this.icon,
      this.location = "none"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 180,
      child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shadowColor: Colors.transparent,
          elevation: 1,
          child: Stack(
            children: [
              Positioned(
                bottom: -75,
                left: -75,
                child: Icon(
                  icon,
                  size: 200,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              const SizedBox(height: 5),
                              Text(description),
                            ],
                          )),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: FilledButton.icon(
                            onPressed: () {
                              location == "none" ? null : context.push('/$location');
                            },
                            label: const Text(
                              'Check',
                            ),
                            icon: Icon(icon),
                          ))
                    ],
                  )),
            ],
          )),
    );
  }
}
