import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'appBar.dart';

class SecurityDashboard extends StatefulWidget {
  const SecurityDashboard({super.key});

  @override
  State<SecurityDashboard> createState() => _SecurityDashboardState();
}

class _SecurityDashboardState extends State<SecurityDashboard> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> passwords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchPasswords();
  }

  Future<void> _fetchPasswords() async {
    try {
      final response = await supabase
          .from('passwords') // Replace with your actual Supabase table name
          .select('*')
          .order('created_at', ascending: false);

      setState(() {
        passwords = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching passwords: $e')),
      );
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(
        title: "Dashboard",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Circular Progress Indicator with label
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: CircularProgressIndicator(
                    value: _calculateSecurityPercentage(),
                    strokeWidth: 8,
                    backgroundColor: Colors.grey[300],
                    valueColor:
                        const AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${(_calculateSecurityPercentage() * 100).toStringAsFixed(0)}%",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Secured",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatTile(
                  passwords.where((p) => p['strength'] == 'Safe').length,
                  "Safe",
                  Colors.green,
                ),
                _buildStatTile(
                  passwords.where((p) => p['strength'] == 'Weak').length,
                  "Weak",
                  Colors.orange,
                ),
                _buildStatTile(
                  passwords.where((p) => p['strength'] == 'Risk').length,
                  "Risk",
                  Colors.red,
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Analysis Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Analysis",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    // Filter functionality
                  },
                ),
              ],
            ),

            // Analysis List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : passwords.isEmpty
                      ? const Center(child: Text("No passwords found"))
                      : ListView.builder(
                          itemCount: passwords.length,
                          itemBuilder: (context, index) {
                            final password = passwords[index];
                            return _buildAnalysisTile(
                              icon: Icons.security,
                              platform: password['platform'] ?? 'Unknown',
                              username: password['username'] ?? 'Unknown',
                              status: password['strength'] ?? 'Unknown',
                              color: _getStatusColor(password['strength']),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  double _calculateSecurityPercentage() {
    if (passwords.isEmpty) return 0.0;

    final safeCount = passwords.where((p) => p['strength'] == 'Safe').length;
    return safeCount / passwords.length;
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case 'Safe':
        return Colors.green;
      case 'Weak':
        return Colors.orange;
      case 'Risk':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  Widget _buildStatTile(int count, String label, Color color) {
    return Column(
      children: [
        Text(
          "$count",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(label),
      ],
    );
  }

  Widget _buildAnalysisTile({
    required IconData icon,
    required String platform,
    required String username,
    required String status,
    required Color color,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color.withOpacity(0.2),
        child: Icon(icon, color: color),
      ),
      title: Text(platform),
      subtitle: Text(username),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            status,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}
