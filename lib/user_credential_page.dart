import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterLoginTab extends StatelessWidget {
  const RegisterLoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          toolbarHeight: 200,
          flexibleSpace: const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Icon(Icons.lock_outline, size: 50, color: Colors.black),
                SizedBox(height: 5),
                Text(
                  "Passblock",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "Safe Security",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          bottom: TabBar(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            indicatorColor: Colors.black,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(5),
            ),
            tabs: const [
              Tab(text: 'Register'),
              Tab(text: 'Login'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            RegisterPage(),
            LoginPage(),
          ],
        ),
      ),
    );
  }
}

class RegisterPage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterPage({super.key});

  Future<void> _register(BuildContext context) async {
    try {
      final response = await Supabase.instance.client.auth.signUp(
        email: emailController.text,
        password: passwordController.text,
        data: {
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
        },
      );

      if (response.user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Account created! Please log in.')),
        );
        DefaultTabController.of(context).animateTo(1); // Switch to Login Tab
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-up failed! Please try again.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: firstNameController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              labelText: "First Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: lastNameController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              labelText: "Last Name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Register",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> _login(BuildContext context) async {
    try {
      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (response.user != null) {
        Navigator.pushReplacementNamed(context, '/home'); // Navigate to Home
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed! Check your credentials.')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: emailController,
            style: const TextStyle(color: Colors.black),
            decoration: const InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextField(
            controller: passwordController,
            style: const TextStyle(color: Colors.black),
            obscureText: true,
            decoration: const InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _login(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Log in",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
