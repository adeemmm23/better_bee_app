import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  dynamic tempLevel = 0;
  double highestTempLevel = 0;
  final ref = FirebaseDatabase.instance.ref("temperature");

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
                tempLevel = snapshot.data!.snapshot.value;
                tempLevel = tempLevel.toDouble();
              }
              return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: tempLevel),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (context, double value, child) {
                    if (value > highestTempLevel) {
                      highestTempLevel = value;
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
                                'Temperature Level',
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
                                    bottom: 40,
                                    child: Container(
                                      width: 35,
                                      height: value > 155 ? 155 : value * 2,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 7,
                                    child: Container(
                                      width: 70,
                                      height: 70,
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
                                    'assets/images/thermostats.png',
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    width: 80,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Text("${value.toInt().toString()} °C",
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
                                        "Highest temperature level",
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
