import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';

import 'appBar.dart';
import 'security_dashboard.dart';
import 'setting.dart';

class HomeScreenManager extends StatefulWidget {
  const HomeScreenManager({super.key});

  @override
  State<HomeScreenManager> createState() => _HomeScreenManagerState();
}

class _HomeScreenManagerState extends State<HomeScreenManager> {
  int _selectedIndex = 0;

  static final List<Widget> _screens = [
    HomeScreen(),
    SecurityDashboard(),
    SettingScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.analytics_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.analytics,
              color: Colors.black,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings_outlined,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.settings,
              color: Colors.black,
            ),
            label: 'Setting',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> passwords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPasswords();
  }

  Future<void> fetchPasswords() async {
    final supabase = Supabase.instance.client;

    // Fetch the current user's passwords
    final user = supabase.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User not logged in')),
      );
      return;
    }

    final response = await supabase
        .from('passwords')
        .select('*')
        .eq('user_id', user.id)
        .order('created_at', ascending: false);

    if (response == []) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error')),
      );
    } else {
      setState(() {
        passwords = List<Map<String, dynamic>>.from(response as List);
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Appbar(title: "Passwords"),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : passwords.isEmpty
              ? const Center(child: Text('No passwords found.'))
              : SafeArea(
                  child: ListView.builder(
                    itemCount: passwords.length,
                    itemBuilder: (context, index) {
                      final password = passwords[index];
                      return ListTile(
                        leading: const CircleAvatar(
                          child: Icon(Icons.security),
                        ),
                        title: Text(password['app_name']),
                        subtitle: Text(password['username']),
                        trailing: IconButton(
                          icon: const Icon(Icons.copy),
                          onPressed: () {
                            Clipboard.setData(
                              ClipboardData(text: password['password']),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Password copied!')),
                            );
                          },
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: {
                              'id': password['id'],
                              'app_name': password['app_name'],
                              'username': password['username'],
                              'password': password['password'],
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}
