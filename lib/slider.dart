import 'package:flutter/material.dart';

class FeatureSlider extends StatefulWidget {
  const FeatureSlider({super.key});

  @override
  _FeatureSliderState createState() => _FeatureSliderState();
}

class _FeatureSliderState extends State<FeatureSlider> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<IconData> icons = [
    Icons.verified_user_outlined,
    Icons.speed,
    Icons.download_done
  ];

  final List<Map<String, String>> features = [
    {
      'title': 'Security',
      'description':
          'Control your security. This application is built on blockchain to provide 100% secure access.',
    },
    {
      'title': 'Fast',
      'description':
          'Everything in a single click. Add, generate, store, and manage all passwords easily.',
    },
    {
      'title': 'Passblock',
      'description':
          'Download Passblock now and start managing your passwords securely.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                features.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 4,
                  width: 80,
                  decoration: BoxDecoration(
                    color:
                        _currentPage >= index ? Colors.black : Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
          ),

          // PageView for sliding content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: features.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Icon(
                          icons[index],
                          size: 150,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        features[index]['title']!,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        features[index]['description']!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Buttons
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/register");
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  child: const Text(
                    'Sign Up | Sign In',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
