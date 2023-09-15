import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData? icon;
  const CustomCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
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
                              context.push('/${title.toLowerCase()}');
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
