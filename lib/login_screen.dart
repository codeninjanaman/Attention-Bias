import 'package:attention_bias/signupscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'landingpage.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to log in using email and password
  void _login() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    // Function to show snackbar
    void _showSnackbar(String message) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: 2),
        ),
      );
    }

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Please enter email and password');
      return;
    }

    try {
      // Log in the user with email and password
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      // Navigate to HomeScreen after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: _auth.currentUser!),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Login failed: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Stack(
              children:[
                 Padding(
                   padding: const EdgeInsets.all(20),
                   child: Column(
                     children: [
                       Align(
                         alignment: Alignment.centerLeft, // Aligns the container to the left
                         child: Container(
                           decoration: BoxDecoration(
                             color: Color(0x2B2D87FF),
                             borderRadius: BorderRadius.circular(50),
                           ),
                           child: IconButton(
                             icon: Icon(Icons.arrow_back),
                             onPressed: () {
                               Navigator.pushReplacement(
                                 context,
                                 MaterialPageRoute(builder: (context) => LandingPage()),
                               );
                             },
                             color: Color(0xFF2D87FF),
                           ),
                         ),
                       ),
                       SizedBox(height: size.height * 0.07),
                       Align(
                         alignment: Alignment.centerLeft,
                         child: Text(
                           "Log In",
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 32,
                             fontWeight: FontWeight.w400,
                           ),
                         ),
                       ),
                       SizedBox(height: size.height * 0.04),
                       SizedBox(
                         child: TextFormField(
                           controller: _emailController,
                           style: TextStyle(color: Colors.black, fontSize: 14),
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(bottom: 1, left: 14),
                             hintText: 'Email',
                             prefixIcon: Icon(
                               Icons.email,
                               size: 20,
                               color: Colors.grey.shade500,
                             ),
                             hintStyle: TextStyle(
                               color: Colors.grey.shade400,
                               fontWeight: FontWeight.w400,
                             ),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: BorderSide(
                                 width: 1.0,
                                 color: Colors.grey.shade100,
                               ),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: BorderSide(
                                 width: 1.0,
                                 color: Colors.black,
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: size.height * 0.015),
                       SizedBox(
                         child: TextFormField(
                           controller: _passwordController,
                           obscureText: true, // Hides the password
                           style: TextStyle(color: Colors.black, fontSize: 14),
                           decoration: InputDecoration(
                             contentPadding: EdgeInsets.only(bottom: 1, left: 14),
                             hintText: 'Password',
                             prefixIcon: Icon(
                               Icons.lock,
                               size: 20,
                               color: Colors.grey.shade500,
                             ),
                             hintStyle: TextStyle(
                               color: Colors.grey.shade400,
                               fontWeight: FontWeight.w400,
                             ),
                             border: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: BorderSide(
                                 width: 1.0,
                                 color: Colors.grey.shade100,
                               ),
                             ),
                             focusedBorder: OutlineInputBorder(
                               borderRadius: BorderRadius.circular(30),
                               borderSide: BorderSide(
                                 width: 1.0,
                                 color: Colors.black,
                               ),
                             ),
                           ),
                         ),
                       ),
                       SizedBox(height: size.height * 0.05),
                       SizedBox(
                         width: double.infinity,
                         child: ElevatedButton(
                           style: ElevatedButton.styleFrom(
                             backgroundColor: Color(0xFF2D87FF),
                           ),
                           onPressed: _login,
                           child: Text(
                             'Log In',
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 14,
                             ),
                           ),
                         ),
                       ),
                       Align(
                        alignment: Alignment.center,
                        
                         child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account"),
                            TextButton(onPressed: () {
                              Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => SignUpScreen(),
        ),
      );
                            },
                            child: Text("Signup", style: TextStyle(
                              color: Color(0xFF2D87FF)
                            ),),)
                            // Text("Signup")
                          ],
                         ),
                       )
                       
                     ],
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
