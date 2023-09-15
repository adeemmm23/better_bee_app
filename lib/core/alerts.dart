import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomAlert extends StatefulWidget {
  final String name;
  final String problem;
  final String solution;
  final String location;
  final String date;
  final dynamic value;
  final String delete;
  final IconData? icon;
  final Map hiveAlerts;

  const CustomAlert({
    Key? key,
    required this.name,
    required this.problem,
    required this.solution,
    required this.location,
    required this.delete,
    required this.date,
    required this.hiveAlerts,
    this.value = "Unknown",
    required this.icon,
  }) : super(key: key);

  @override
  State<CustomAlert> createState() => _CustomAlertState();
}

class _CustomAlertState extends State<CustomAlert> {
  final ref = FirebaseDatabase.instance.ref("alerts");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.name),
      icon: Icon(widget.icon),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'The Problem',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          Text(widget.problem),
          const SizedBox(height: 10),
          const Divider(),
          Text(
            'The Solution',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(height: 10),
          Text(widget.solution),
          const SizedBox(height: 10),
          ActionChip(
              label: Text("Value: ${widget.value}"),
              avatar: Icon(widget.icon),
              onPressed: () {}),
          ActionChip(
              label: Text(widget.date),
              avatar: const Icon(Icons.schedule),
              onPressed: () {}),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('ignore')),
        FilledButton(
            onPressed: () async {
              widget.hiveAlerts.remove(widget.delete);
              await ref.child(widget.delete).remove();
              if (mounted) {
                context.pop();
                context.push('/${widget.location}');
              }
            },
            child: const Text('Check'))
      ],
    );
  }
}

IconData toIcon(String iconName) {
  switch (iconName) {
    case 'Icons.thermostat_outlined':
      return Icons.thermostat_outlined;
    case 'Icons.water_damage':
      return Icons.water_damage;
    case 'Icons.location_pin':
      return Icons.location_pin;
    case 'Icons.volume_up_outlined':
      return Icons.volume_up_outlined;
    case 'Icons.video_camera_back':
      return Icons.video_camera_back;
    // Add more cases for other icon names as needed
    default:
      return Icons.error; // Default icon if no match is found
  }
}
