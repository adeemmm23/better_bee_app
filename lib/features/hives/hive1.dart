import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/alerts.dart';
import '../../core/card.dart';

class Hive1 extends StatefulWidget {
  const Hive1({super.key});

  @override
  State<Hive1> createState() => _Hive1State();
}

class _Hive1State extends State<Hive1> {
  final ref = FirebaseDatabase.instance.ref("alerts");
  // Map lastActiveTime = {};

  // Future getLastActiveTime() async {
  //   DatabaseReference ref = FirebaseDatabase.instance.ref('active');
  //   DatabaseEvent event = await ref.once();
  //   Map<dynamic, dynamic> data = event.snapshot.value as Map<dynamic, dynamic>;
  //   return Map<String, dynamic>.from(data);
  // }

  // @override
  // void initState() async {
  //   super.initState();
  //   lastActiveTime = await getLastActiveTime();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hive 1'),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        icon: const Icon(Icons.notifications),
                        title: const Text('Notifications'),
                        content: const Text(
                            'Do you want to clear all notifications fo this hive?'),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      );
                    });
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Text('Select a sensor to view its data',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 3),
                child: Text(
                    'Discover Hive Insights: Swipe through sensors to keep an eye on hive temperature, noise, and humidity.',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    SizedBox(
                      width: 100,
                    ),
                    CustomCard(
                      title: 'Noise',
                      description: 'Try to make some noise!',
                      icon: Icons.volume_down,
                    ),
                    CustomCard(
                      title: 'Humidity',
                      description: 'Check the humidity of the air!',
                      icon: Icons.water_damage,
                    ),
                    CustomCard(
                      title: 'Temperature',
                      description: 'Check the temperature of the air!',
                      icon: Icons.thermostat_outlined,
                    ),
                    CustomCard(
                      title: 'Location',
                      description: 'See your location live!',
                      icon: Icons.location_pin,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const Divider(
                indent: 30,
                endIndent: 30,
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text('Alerts',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10, top: 3),
                child: Text('Check out the latest alerts from your hives.',
                    style: TextStyle(
                        fontSize: 15,
                        color: Theme.of(context).colorScheme.onBackground)),
              ),
              const SizedBox(height: 10),
              StreamBuilder(
                  stream: ref.onValue,
                  builder: (context, snapshot) {
                    Map dataMap;
                    final data = snapshot.data?.snapshot.value;
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text('Something went wrong'),
                      );
                    }
                    if (snapshot.data?.snapshot.value == null) {
                      dataMap = {};
                    } else {
                      dataMap = data as Map;
                    }
                    return alert(context, dataMap);
                  }),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.hive),
          label: const Text('See Hives'),
        ));
  }
}

Widget alert(context, Map hiveAlerts) {
  return Padding(
    padding: const EdgeInsets.only(left: 20, top: 10),
    child: hiveAlerts.isEmpty
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Icon(Icons.notifications_none,
                    size: 50, color: Theme.of(context).colorScheme.secondary),
                const SizedBox(height: 10),
                Text(
                  'No alerts to show!',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
              ],
            ),
          )
        : Wrap(
            spacing: 10,
            children: [
              for (var alert in hiveAlerts.entries)
                ActionChip(
                  avatar: Icon(
                    toIcon(alert.value["icon"]),
                    color: alert.value["serious"]
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                  ),
                  label: Text(alert.value["name"]),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return CustomAlert(
                          delete: alert.key,
                          icon: toIcon(alert.value["icon"]),
                          location: alert.value["location"],
                          problem: alert.value["problem"],
                          solution: alert.value["solution"],
                          name: alert.value["name"],
                          value: alert.value["value"],
                          date:
                              alert.value["date"] ?? DateTime.now().toString(),
                          hiveAlerts: hiveAlerts,
                        );
                      },
                    );
                  },
                ),
            ],
          ),
  );
}
