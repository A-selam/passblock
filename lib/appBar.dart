import 'package:flutter/material.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Appbar({required this.title, super.key});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.person_outline),
        onPressed: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      title: Text(title),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            Navigator.pushNamed(context, '/add-password');
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
