import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attention_bias/login_screen.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MathReportScreen extends StatefulWidget {
  final double meanCorrectResponse;
  final double meanIncorrectResponse;
  final int correctResponses;
  final int incorrectResponses;
  final double attention_bias;
  final String name; // Add name field
  final String age; // Add age field
  final String gender; // Add gender field
  final String email; // Add email field
  final String date; // Add date field

  MathReportScreen({
    required this.meanCorrectResponse,
    required this.meanIncorrectResponse,
    required this.correctResponses,
    required this.incorrectResponses,
    required this.attention_bias,
    required this.name, // Initialize in constructor
    required this.age, // Initialize in constructor
    required this.gender, // Initialize in constructor
    required this.email, // Initialize in constructor
    required this.date, // Initialize in constructor
  });

  @override
  _MathReportScreenState createState() => _MathReportScreenState();
}

class _MathReportScreenState extends State<MathReportScreen> {
  @override
  void initState() {
    super.initState();
    _saveReport();
  }

  Future<void> _saveReport() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final User? user = _auth.currentUser;

    if (user == null || user.email == null) {
      // User is not logged in or email is missing
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      return;
    }

    final email = user.email;
    if (email == null || email.isEmpty) {
      // Handle missing email
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email is missing. Please log in again.')),
      );
      return;
    }

      final timestamp = DateTime.now().toString();
    try {

      // Save the report data with email as document ID
      await _firestore
          .collection('reports')
          .doc(widget.email)
          .collection('paradigm2')
          .doc(timestamp)
          .set({
        'meanCorrectResponse': widget.meanCorrectResponse,
        'meanIncorrectResponse': widget.meanIncorrectResponse,
        'correctResponses': widget.correctResponses,
        'incorrectResponses': widget.incorrectResponses,
        'timestamp': timestamp,
        'attentionBias': widget.attention_bias,
        'name': widget.name, // Use name from widget
      'age': widget.age,
      'gender': widget.gender,
      'email': widget.email,
      'date': widget.date,
      'timestamp': timestamp,
      });
    } catch (e) {
      // Handle any errors that occur during the saving process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save report: $e')),
      );
    }
  }
Future<void> _exportToExcel() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final User? user = _auth.currentUser;

  if (user == null || user.email == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Please log in to export the report.')),
    );
    return;
  }

  final email = user.email;

  try {
    // Create or open the Excel file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/paradigm2.xlsx';

    File file = File(filePath);
    Excel excel;
    if (await file.exists()) {
      // Load existing Excel file
      excel = Excel.decodeBytes(file.readAsBytesSync());
    } else {
      // Create a new Excel file
      excel = Excel.createExcel();
    }

    // Select or create a new sheet
    String sheetName = 'Reports';
    Sheet sheet = excel[sheetName]; // This automatically creates the sheet if it doesn't exist

    // Add column headers if not already present
    if (sheet.maxRows == 0 || sheet.row(0).isEmpty) {
      sheet.appendRow([
        'User Name',
        'User Age',
        'User Gender',
        'User Email',
        'Test Date',
        'Mean Correct Response (ms)',
        'Mean Incorrect Response (ms)',
        'Correct Responses',
        'Incorrect Responses',
        'Timestamp',
        'Attention Bias', 
        
      ]);
    }

    // Add the report data
    sheet.appendRow([
      widget.name, // Use name from widget
      widget.age,
      widget.gender,
      widget.email,
      widget.date,
      widget.meanCorrectResponse.toStringAsFixed(2),
      widget.meanIncorrectResponse.toStringAsFixed(2),
      widget.correctResponses,
      widget.incorrectResponses,
      DateTime.now().toString(),
      (widget.meanCorrectResponse - widget.meanIncorrectResponse).abs().toStringAsFixed(2),
    ]);

    // Save the Excel file
    file.writeAsBytesSync(excel.save()!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Report exported to Excel at: $filePath')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to export report: $e')),
    );
  }
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
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
                              Navigator.pop(context);
                            },
                            color: Color(0xFF2D87FF),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Report",
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Text(
                  'Mean Reaction Time for Correct Response:',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${widget.meanCorrectResponse.toStringAsFixed(2)} ms',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Text(
                  'Mean Reaction Time for Incorrect Response:',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${widget.meanIncorrectResponse.toStringAsFixed(2)} ms',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Text(
                  'Correct Responses:',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${widget.correctResponses}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Text(
                  'Incorrect Responses:',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${widget.incorrectResponses}',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                Text(
                  'Attention Bias:',
                  style: TextStyle(color: Colors.black),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    '${(widget.meanCorrectResponse - widget.meanIncorrectResponse).abs().toStringAsFixed(2)} ms',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF2D87FF)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Restart',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: size.width * 0.6,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green),
                      onPressed: _exportToExcel,
                      child: Text(
                        'Export to Excel',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
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
