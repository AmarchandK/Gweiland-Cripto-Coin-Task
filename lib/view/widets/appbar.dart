import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "EXCHANGES",
        style: TextStyle(fontWeight: FontWeight.w800)
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none_rounded)),
        IconButton(
            onPressed: () {
            },
            icon: const Icon(Icons.settings_outlined))
      ],
    );
  }
}
