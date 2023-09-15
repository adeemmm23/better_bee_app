import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Humidity extends StatefulWidget {
  const Humidity({super.key});

  @override
  State<Humidity> createState() => _HumidityState();
}

class _HumidityState extends State<Humidity> {
  double humidityLevel = 0;
  int highestHumidityLevel = 0;
  final ref = FirebaseDatabase.instance.ref("humidity");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(child: Text('Something went wrong'));
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                humidityLevel = (snapshot.data!.snapshot.value as double) * 1.0;
              }
              return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: humidityLevel),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (context, double value, child) {
                    if (value > highestHumidityLevel) {
                      highestHumidityLevel = value.toInt();
                    }
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'humidity Level',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 30),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    bottom: 10,
                                    child: Container(
                                      width: 60,
                                      height: value * 2 > 180 ? 180 : value * 2,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Image.asset(
                                    'assets/images/water.png',
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 70,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text(("${value.toInt().toString()} %"),
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Center(
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 250,
                                width: MediaQuery.of(context).size.width * 0.9,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Highest humidity level",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                      Text(
                                        "For Today",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                      Text(
                                        value.toInt().toString(),
                                        style: TextStyle(
                                            fontSize: 70,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary),
                                      ),
                                      IconButton.filled(
                                        onPressed: () {
                                          context.pop();
                                        },
                                        icon: const Icon(Icons.arrow_back),
                                      )
                                    ]),
                              ),
                            )),
                      ],
                    );
                  });
            }),
      ),
    );
  }
}
