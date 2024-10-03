import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;
  bool _isCheckboxChecked = false; // Track if the checkbox is checked

  // Function to sign up using email and password
  void _signUp() async {
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

    setState(() {
      _isLoading = true;
    });

    try {
      // Create a new user with email and password
      await _auth.createUserWithEmailAndPassword(email: email, password: password);

      // Navigate to HomeScreen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(user: _auth.currentUser!),
        ),
      );
    } on FirebaseAuthException catch (e) {
      _showSnackbar('Sign up failed: ${e.message}');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showPrivacyPolicyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Privacy Policies & Guidelines'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                'Privacy Policies:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. **Data Collection**:\n'
                '   - We collect personal information such as your name, email address, age, and gender during the sign-up process. This helps us to personalize your experience and improve our services.\n'
                '   - We may collect additional information about your interactions with the application, including test results, response times, and usage metrics.\n',
              ),
              SizedBox(height: 8),
              Text(
                '2. **Purpose of Data Collection**:\n'
                '   - The data collected will be used for research and analysis purposes, contributing to improving behavioral analysis tools and cognitive testing frameworks.\n'
                '   - Your data will help enhance the platform’s features and provide a better understanding of user behaviors to optimize your experience.\n',
              ),
              SizedBox(height: 8),
              Text(
                '3. **Data Usage for Research**:\n'
                '   - Your anonymized data may be used in academic research to better understand attention, cognition, and related fields.\n'
                '   - We will not sell or share your personal data with third parties without your explicit consent.\n',
              ),
              SizedBox(height: 8),
              Text(
                '4. **Data Security**:\n'
                '   - We take data security seriously and use various technologies and procedures to protect your information from unauthorized access, use, or disclosure.\n',
              ),
              SizedBox(height: 16),
              Text(
                'Guidelines:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '1. **Accuracy of Information**:\n'
                '   - You must provide accurate and truthful information during the sign-up process. Failure to do so may result in suspension or termination of your account.\n',
              ),
              SizedBox(height: 8),
              Text(
                '2. **Respect for the Platform**:\n'
                '   - The use of this platform is intended for legitimate research and personal growth. Any misuse, inappropriate behavior, or violation of terms will lead to suspension.\n',
              ),
              SizedBox(height: 8),
              Text(
                '3. **User Responsibility**:\n'
                '   - You are responsible for maintaining the confidentiality of your login information. Sharing of accounts is strictly prohibited.\n',
              ),
              SizedBox(height: 8),
              Text(
                '4. **Usage of Results**:\n'
                '   - The results and insights generated by the tests on this platform are for educational and research purposes. They should not be considered as medical advice or diagnostic tools.\n',
              ),
              SizedBox(height: 8),
              Text(
                '5. **Community Guidelines**:\n'
                '   - Users are expected to be respectful and avoid inappropriate or disruptive behavior while using the platform. Abusive behavior will not be tolerated.\n',
              ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Accept'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
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
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
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
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 32,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.04),
                TextFormField(
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
                SizedBox(height: size.height * 0.015),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
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
                SizedBox(height: size.height * 0.03),
                Row(
                  children: [
                    Checkbox(
                      value: _isCheckboxChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCheckboxChecked = value ?? false;
                        });
                      },
                    ),
                    GestureDetector(
                      onTap: _showPrivacyPolicyDialog,
                      child: Text(
                        "Accept privacy Policies & Guidelines",
                        style: TextStyle(
                          color: Color(0xFF2D87FF),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF2D87FF),
                    ),
                    onPressed: _isLoading || !_isCheckboxChecked // Disable if loading or checkbox is unchecked
                        ? null
                        : _signUp,
                    child: _isLoading
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Sign Up',
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
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(color: Color(0xFF2D87FF)),
                        ),
                      ),
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
