// import 'package:flutter/material.dart';
// import 'package:random_password_generator/random_password_generator.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ModifyPasswordScreen extends StatefulWidget {
//   const ModifyPasswordScreen({super.key});

//   @override
//   State<ModifyPasswordScreen> createState() => _ModifyPasswordScreenState();
// }

// class _ModifyPasswordScreenState extends State<ModifyPasswordScreen> {
//   bool includeNumbers = true;
//   bool includeSymbols = true;
//   bool includeLowercase = true;
//   bool includeUppercase = true;
//   int passwordLength = 12;

//   late int passId;

//   late TextEditingController appName;
//   late TextEditingController userId;
//   late TextEditingController password;

//   final passwordGenerator = RandomPasswordGenerator();
//   late String newPassword;

//   @override
//   void initState() {
//     super.initState();

//     final args =
//         ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

//     final int passwordId = args['id'];
//     final String applicationName = args['app_name'];
//     final String username = args['username'];
//     final String oldPassword = args['password'];

//     passId = passwordId;
//     password = TextEditingController(text: oldPassword);
//     appName = TextEditingController(text: applicationName);
//     userId = TextEditingController(text: username);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         title: const Text('New Record'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Name Input
//             TextField(
//               controller: appName,
//               decoration: const InputDecoration(
//                 labelText: 'Name',
//                 hintText: 'Website or app name',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // User ID Input
//             TextField(
//               controller: userId,
//               decoration: InputDecoration(
//                 labelText: 'User ID',
//                 hintText: 'Username or email ID',
//                 border: OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Password Input
//             TextField(
//               controller: password,
//               decoration: InputDecoration(
//                 labelText: 'Password',
//                 border: const OutlineInputBorder(),
//               ),
//             ),
//             const SizedBox(height: 20),

//             // Password Length Slider
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text('Length', style: TextStyle(fontSize: 16)),
//                 Text('$passwordLength', style: const TextStyle(fontSize: 16)),
//               ],
//             ),
//             Slider(
//               value: passwordLength.toDouble(),
//               min: 4,
//               max: 32,
//               divisions: 28,
//               label: '$passwordLength',
//               onChanged: (value) {
//                 setState(() {
//                   passwordLength = value.toInt();
//                 });
//               },
//             ),

//             // Options Toggles
//             Row(
//               children: [
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: const Text('Numbers'),
//                     value: includeNumbers,
//                     onChanged: (value) {
//                       setState(() {
//                         includeNumbers = value!;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: const Text('Symbols'),
//                     value: includeSymbols,
//                     onChanged: (value) {
//                       setState(() {
//                         includeSymbols = value!;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               children: [
//                 Expanded(
//                   child: CheckboxListTile(
//                     enabled: false,
//                     title: const Text('Lowercase'),
//                     value: includeLowercase,
//                     onChanged: (value) {
//                       setState(() {
//                         includeLowercase = value!;
//                       });
//                     },
//                   ),
//                 ),
//                 Expanded(
//                   child: CheckboxListTile(
//                     title: const Text('Uppercase'),
//                     value: includeUppercase,
//                     onChanged: (value) {
//                       setState(() {
//                         includeUppercase = value!;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),

//             // Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: OutlinedButton(
//                     onPressed: () {
//                       setState(() {
//                         newPassword = passwordGenerator.randomPassword(
//                           letters: true,
//                           uppercase: includeUppercase,
//                           numbers: includeNumbers,
//                           specialChar: includeSymbols,
//                           passwordLength: passwordLength.toDouble(),
//                         );
//                         password.text =
//                             newPassword; // Update the password text field
//                       });
//                     },
//                     style: OutlinedButton.styleFrom(
//                       side: const BorderSide(color: Colors.black),
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     child: const Text(
//                       'Regenerate',
//                       style: TextStyle(color: Colors.black),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       final supabase = Supabase.instance.client;

//                       // Fetch current user's ID
//                       final user = supabase.auth.currentUser;
//                       if (user == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text('User not logged in')),
//                         );
//                         return;
//                       }

//                       double passwordStrength = passwordGenerator.checkPassword(
//                           password: password.text);
//                       final String strength;

//                       if (passwordStrength < 0.3) {
//                         strength = 'Risk';
//                       } else if (passwordStrength < 0.7) {
//                         strength = 'Weak';
//                       } else {
//                         strength = 'Safe';
//                       }

//                       // Insert data into the 'passwords' table
//                       final response = await supabase.from('passwords').update({
//                         'user_id': user.id,
//                         'app_name': appName.text,
//                         'username': userId.text,
//                         'password': password.text,
//                         'strength': strength,
//                       }).eq('id', passId);

//                       if (response.error == null) {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content: Text('Password saved successfully')),
//                         );
//                         Navigator.pop(context);
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                               content:
//                                   Text('Error: ${response.error!.message}')),
//                         );
//                       }
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.black,
//                       minimumSize: const Size(double.infinity, 50),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(5),
//                       ),
//                     ),
//                     child: const Text(
//                       'Save Password',
//                       style: TextStyle(
//                         color: Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:random_password_generator/random_password_generator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ModifyPasswordScreen extends StatefulWidget {
  const ModifyPasswordScreen({super.key});

  @override
  State<ModifyPasswordScreen> createState() => _ModifyPasswordScreenState();
}

class _ModifyPasswordScreenState extends State<ModifyPasswordScreen> {
  bool includeNumbers = true;
  bool includeSymbols = true;
  bool includeLowercase = true;
  bool includeUppercase = true;
  int passwordLength = 12;

  late int passId;

  late TextEditingController appName;
  late TextEditingController userId;
  late TextEditingController password;

  final passwordGenerator = RandomPasswordGenerator();
  late String newPassword;

  @override
  void initState() {
    super.initState();
    appName = TextEditingController();
    userId = TextEditingController();
    password = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Fetch arguments from ModalRoute
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    final int passwordId = args['id'];
    final String applicationName = args['app_name'];
    final String username = args['username'];
    final String oldPassword = args['password'];

    passId = passwordId;
    appName.text = applicationName;
    userId.text = username;
    password.text = oldPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Edit Record'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Input
            TextField(
              controller: appName,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Website or app name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // User ID Input
            TextField(
              controller: userId,
              decoration: const InputDecoration(
                labelText: 'User ID',
                hintText: 'Username or email ID',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Password Input
            TextField(
              controller: password,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Password Length Slider
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Length', style: TextStyle(fontSize: 16)),
                Text('$passwordLength', style: const TextStyle(fontSize: 16)),
              ],
            ),
            Slider(
              value: passwordLength.toDouble(),
              min: 4,
              max: 32,
              divisions: 28,
              label: '$passwordLength',
              onChanged: (value) {
                setState(() {
                  passwordLength = value.toInt();
                });
              },
            ),

            // Options Toggles
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Numbers'),
                    value: includeNumbers,
                    onChanged: (value) {
                      setState(() {
                        includeNumbers = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Symbols'),
                    value: includeSymbols,
                    onChanged: (value) {
                      setState(() {
                        includeSymbols = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    enabled: false,
                    title: const Text('Lowercase'),
                    value: includeLowercase,
                    onChanged: (value) {
                      setState(() {
                        includeLowercase = value!;
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    title: const Text('Uppercase'),
                    value: includeUppercase,
                    onChanged: (value) {
                      setState(() {
                        includeUppercase = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        newPassword = passwordGenerator.randomPassword(
                          letters: true,
                          uppercase: includeUppercase,
                          numbers: includeNumbers,
                          specialChar: includeSymbols,
                          passwordLength: passwordLength.toDouble(),
                        );
                        password.text =
                            newPassword; // Update the password text field
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.black),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Regenerate',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      final supabase = Supabase.instance.client;

                      // Fetch current user's ID
                      final user = supabase.auth.currentUser;
                      if (user == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User not logged in')),
                        );
                        return;
                      }

                      double passwordStrength = passwordGenerator.checkPassword(
                          password: password.text);
                      final String strength;

                      if (passwordStrength < 0.3) {
                        strength = 'Risk';
                      } else if (passwordStrength < 0.7) {
                        strength = 'Weak';
                      } else {
                        strength = 'Safe';
                      }

                      // Insert data into the 'passwords' table
                      final response = await supabase.from('passwords').update({
                        'user_id': user.id,
                        'app_name': appName.text,
                        'username': userId.text,
                        'password': password.text,
                        'strength': strength,
                      }).eq('id', passId);

                      if (response != []) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text('Password saved successfully')),
                        );
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: const Text(
                      'Save Password',
                      style: TextStyle(
                        color: Colors.white,
                      ),
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
