import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // App Name and Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Password Manager',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'A secure, user-friendly application designed to help you store and manage your passwords effortlessly. Built as part of the Mobile Computing and Programming course.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Features Section
            _SectionTitle(title: 'Features'),
            const ListTile(
              leading: Icon(Icons.security, color: Colors.black),
              title: Text('Secure password storage with encryption'),
            ),
            const ListTile(
              leading: Icon(Icons.shuffle, color: Colors.black),
              title: Text('Random password generation'),
            ),
            const ListTile(
              leading: Icon(Icons.analytics, color: Colors.black),
              title: Text('Password strength analysis'),
            ),
            const ListTile(
              leading: Icon(Icons.cloud, color: Colors.black),
              title: Text('Cloud backup with Supabase integration'),
            ),
            const SizedBox(height: 30),

            // Tech Stack Section
            _SectionTitle(title: 'Tech Stack'),
            const ListTile(
              title: Text('Flutter for cross-platform development'),
            ),
            const ListTile(
              title: Text('Supabase for backend and database management'),
            ),
            const SizedBox(height: 30),

            // Development Team Section
            _SectionTitle(title: 'Development Team'),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('A', style: TextStyle(color: Colors.white)),
              ),
              title: Text('Abduselam Sultan'),
              subtitle: Text('SWEG Student'),
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('B', style: TextStyle(color: Colors.white)),
              ),
              title: Text('Abel Bogale'),
              subtitle: Text('SWEG Student'),
            ),
            const ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black,
                child: Text('C', style: TextStyle(color: Colors.white)),
              ),
              title: Text('Abel Ma\'ereg'),
              subtitle: Text('SWEG Student'),
            ),
            const SizedBox(height: 30),

            // Footer
            Column(
              children: const [
                Text(
                  'Thank you for using our app!',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'For feedback or support, please contact us at support@passblock.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
