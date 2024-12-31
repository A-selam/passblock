import 'package:flutter/material.dart';

import 'appBar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(
        title: "Setting",
      ),
      body: SafeArea(
          child: ListView(
        children: [
          ListTile(
            title: const Text('Profile'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          ListTile(
            title: const Text('Help'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            title: const Text('About'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushNamed(context, '/about');
            },
          ),
        ],
      )),
    );
  }
}
