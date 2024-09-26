import 'package:attention_bias/firebase_options.dart';
import 'package:attention_bias/helo.dart';
import 'package:attention_bias/home_screen.dart';
import 'package:attention_bias/landingpage.dart';
import 'package:attention_bias/login_screen.dart';
import 'package:attention_bias/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Error handling while initializing Firebase
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error initializing Firebase: $e');
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(), // Keeping the starting point clean
    );
  }
}

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Connection is still being established, show a loading spinner
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          // Error occurred during the connection process
          return Scaffold(
            body: Center(
              child: Text('An error occurred! Please try again.'),
            ),
          );
        } else if (snapshot.hasData) {
          // User is logged in, proceed to the home screen
          return HomeScreen(user: snapshot.data!);
        } else {
          // User is not logged in, show landing page
          return LandingPage();
        }
      },
    );
  }
}
