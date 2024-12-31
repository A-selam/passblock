import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Title Section
            const Text(
              'How can we help you?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // FAQs Section
            _SectionTitle(title: 'FAQs'),
            _FAQItem(
              question: 'How do I add a new password?',
              answer:
                  'Go to the "Add Password" screen, enter your app name, username, and password, then click "Save".',
            ),
            _FAQItem(
              question: 'How do I edit or delete a saved password?',
              answer:
                  'Navigate to the "Saved Passwords" section, tap on the password you want to edit or delete, and choose the desired action.',
            ),
            _FAQItem(
              question: 'What happens if I forget my master password?',
              answer:
                  'Unfortunately, your master password cannot be recovered for security reasons. You may need to reset your account.',
            ),
            _FAQItem(
              question: 'How is my data protected?',
              answer:
                  'We use encryption to securely store your passwords, and all communication is encrypted via Supabase.',
            ),
            const SizedBox(height: 30),

            // How-To Guides Section
            _SectionTitle(title: 'How-To Guides'),
            const ListTile(
              leading: Icon(Icons.lock, color: Colors.black),
              title: Text('Set up your account securely'),
              subtitle: Text('Step-by-step guide to create your account.'),
            ),
            const ListTile(
              leading: Icon(Icons.password, color: Colors.black),
              title: Text('Generate strong passwords'),
              subtitle: Text('Learn how to create secure, random passwords.'),
            ),
            const ListTile(
              leading: Icon(Icons.cloud, color: Colors.black),
              title: Text('Sync your data to the cloud'),
              subtitle: Text('How to back up and restore your passwords.'),
            ),
            const SizedBox(height: 30),

            // Contact Support Section
            _SectionTitle(title: 'Contact Support'),
            const ListTile(
              leading: Icon(Icons.email, color: Colors.black),
              title: Text('Email us'),
              subtitle: Text('support@passwordmanager.com'),
            ),
            const ListTile(
              leading: Icon(Icons.phone, color: Colors.black),
              title: Text('Call us'),
              subtitle: Text('+1 123 456 7890'),
            ),
            const SizedBox(height: 30),
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

class _FAQItem extends StatelessWidget {
  final String question;
  final String answer;

  const _FAQItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: const TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
