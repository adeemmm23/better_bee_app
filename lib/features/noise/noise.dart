import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Noise extends StatefulWidget {
  const Noise({super.key});

  @override
  State<Noise> createState() => _NoiseState();
}

class _NoiseState extends State<Noise> {
  dynamic noiseLevel = 0;
  double highestNoiseLevel = 0;
  final ref = FirebaseDatabase.instance.ref("noise");

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
                noiseLevel = snapshot.data!.snapshot.value;
                noiseLevel = noiseLevel.toDouble();
              }
              return TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: noiseLevel),
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeOutCubic,
                  builder: (context, double value, child) {
                    if (value > highestNoiseLevel) {
                      highestNoiseLevel = value;
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
                                'Noise Level',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: 200,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                      width: 15,
                                      height: value < 150 ? value / 2 : 150 / 2,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                      height:
                                          value < 150 ? value / 1.5 : 150 / 1.5,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                      height: value < 150 ? value : 150,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                      height:
                                          value < 150 ? value / 1.5 : 150 / 1.5,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    Container(
                                      width: 15,
                                      height: value < 150 ? value / 2 : 150 / 2,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text("${value.toInt().toString()} Hz",
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
                                        "Highest noise level",
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
                                        highestNoiseLevel.toInt().toString(),
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
