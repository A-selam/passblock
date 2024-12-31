import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int passwordId = args['id'];
    final String appName = args['app_name'];
    final String username = args['username'];
    final String password = args['password'];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              color: Colors.red,
            ),
            onPressed: () async {
              final supabase = Supabase.instance.client;

              // Fetch current user's ID
              final user = supabase.auth.currentUser;
              if (user == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('User not logged in')),
                );
                return;
              }

              // Insert data into the 'passwords' table
              final response = await supabase
                  .from('passwords')
                  .delete()
                  .eq('id', '$passwordId')
                  .select('*');

              if (response != []) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Password saved successfully')),
                );
                Navigator.pushReplacementNamed(context, '/home');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[200],
                  child: const Icon(
                    Icons.adobe,
                    size: 30,
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 30),

            // Details and Settings Section
            const Text(
              'Details & Settings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Link
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  appName,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            const Divider(height: 30),

            // User ID
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Username',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  username,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const Divider(height: 30),

            // Password
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Password',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: [
                    Text(
                      password,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            const Divider(height: 30),

            const SizedBox(height: 30),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: password),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Password copied!')),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Copy Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/modify-password',
                        arguments: {
                          'id': passwordId,
                          'app_name': appName,
                          'username': username,
                          'password': password,
                        },
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
