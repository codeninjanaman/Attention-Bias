import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'quiz_screen.dart';
import 'math_quiz_screen.dart';
import 'package:intl/intl.dart'; // For formatting date

class UserInfoForm extends StatefulWidget {
  final String selectedQuiz;

  UserInfoForm({required this.selectedQuiz});

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _name;
  String? _age;
  String? _gender;
  String? _email;
  String _date = DateFormat('yyyy-MM-dd').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        elevation: 0, // Flat look for modern touch
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 12,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeaderText(),
                      const SizedBox(height: 20),
                      _buildNameField(),
                      const SizedBox(height: 20),
                      _buildAgeField(),
                      const SizedBox(height: 20),
                      _buildGenderField(),
                      const SizedBox(height: 20),
                      _buildEmailField(),
                      const SizedBox(height: 20),
                      _buildDateText(),
                      const SizedBox(height: 30),
                      _buildStartTestButton(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderText() {
    return Center(
      child: Text(
        "User Information",
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.blue, // Blue accent color for the text
        ),
      ),
    );
  }

  Widget _buildNameField() {
    return TextFormField(
      decoration: _inputDecoration("Name"),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your name';
        }
        return null;
      },
      onSaved: (value) {
        _name = value;
      },
    );
  }

  Widget _buildAgeField() {
    return TextFormField(
      decoration: _inputDecoration("Age"),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your age';
        }
        return null;
      },
      onSaved: (value) {
        _age = value;
      },
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      decoration: _inputDecoration("Gender"),
      value: _gender,
      items: ['Male', 'Female', 'Other'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _gender = newValue;
        });
      },
      validator: (value) {
        if (value == null) {
          return 'Please select your gender';
        }
        return null;
      },
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      decoration: _inputDecoration("Email"),
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
      onSaved: (value) {
        _email = value;
      },
    );
  }

  Widget _buildDateText() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: Text(
          "Date: $_date",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }

  Widget _buildStartTestButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // primary: Colors.blue, // Blue color for the button
          elevation: 12,
              shadowColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            _startQuiz(context);
          }
        },
        child: Text(
          'Start Test',
          style: TextStyle(fontSize: 18, color: Colors.blue),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  void _startQuiz(BuildContext context) async {
    // Save user data in Firestore
    String docId = DateTime.now().toString();
    await _firestore.collection('user_data').doc(docId).set({
      'name': _name,
      'age': _age,
      'gender': _gender,
      'email': _email,
      'date': _date,
    });

    // Navigate to the selected quiz and pass user info
    if (widget.selectedQuiz == 'Paradigm 1') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizScreen(
            demoMode: false,
            name: _name!,   // Pass name
            age: _age!,     // Pass age
            gender: _gender!, // Pass gender
            email: _email!,   // Pass email
            date: _date,    // Pass date
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MathQuizScreen(
            demoMode: false,
            name: _name!,   // Pass name
            age: _age!,     // Pass age
            gender: _gender!, // Pass gender
            email: _email!,   // Pass email
            date: _date,    // Pass date
          ),
        ),
      );
    }
  }
}
