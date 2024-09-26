import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:attention_bias/login_screen.dart';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportScreen extends StatefulWidget {
  final double meanSameSide;
  final double meanOppositeSide;
  final double attentionBias;
  final int errorsSameSide;
  final int errorsOppositeSide;
  final String name; // Add name field
  final String age; // Add age field
  final String gender; // Add gender field
  final String email; // Add email field
  final String date; // Add date field

  ReportScreen({
    required this.meanSameSide,
    required this.meanOppositeSide,
    required this.attentionBias,
    required this.errorsSameSide,
    required this.errorsOppositeSide,
     required this.name, // Initialize in constructor
    required this.age, // Initialize in constructor
    required this.gender, // Initialize in constructor
    required this.email, // Initialize in constructor
    required this.date, // Initialize in constructor
  });

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  void initState() {
    super.initState();
    _saveReport();
  }
Future<void> _saveReport() async {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final timestamp = DateTime.now().toString();

  try {
    // Save the report data along with user details
    await _firestore.collection('reports').doc(widget.email).collection('paradigm1').doc(timestamp).set({
      'meanSameSide': widget.meanSameSide,
      'meanOppositeSide': widget.meanOppositeSide,
      'attentionBias': widget.attentionBias,
      'errorsSameSide': widget.errorsSameSide,
      'errorsOppositeSide': widget.errorsOppositeSide,
      'name': widget.name, // Use name from widget
      'age': widget.age,
      'gender': widget.gender,
      'email': widget.email,
      'date': widget.date,
      'timestamp': timestamp,
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to save report: $e')),
    );
  }
}

Future<void> _exportToExcel() async {
  final email = widget.email;

  try {
    // Create or open the Excel file
    Directory directory = await getApplicationDocumentsDirectory();
    String filePath = '${directory.path}/paradigm1_report.xlsx';

    File file = File(filePath);
    Excel excel;
    if (await file.exists()) {
      excel = Excel.decodeBytes(file.readAsBytesSync());
    } else {
      excel = Excel.createExcel();
    }

    // Select or create a new sheet
    String sheetName = 'Reports';
    Sheet sheet = excel[sheetName]; // This automatically creates the sheet if it doesn't exist

    // Add column headers if not already present
    if (sheet.maxRows == 0) {
      sheet.appendRow([
        'User Name',
        'User Age',
        'User Gender',
        'User Email',
        'Test Date',
        'Mean Same Side Response (ms)',
        'Mean Opposite Side Response (ms)',
        'Attention Bias (ms)',
        'Errors Same Side',
        'Errors Opposite Side',
        'Timestamp',
      ]);
    }

    // Add the report data
    sheet.appendRow([
      widget.name, // Use name from widget
      widget.age,
      widget.gender,
      email,
      widget.date,
      widget.meanSameSide.toStringAsFixed(2),
      widget.meanOppositeSide.toStringAsFixed(2),
      widget.attentionBias.toStringAsFixed(2),
      widget.errorsSameSide,
      widget.errorsOppositeSide,
      DateTime.now().toString(),
    ]);

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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mean Reaction Time for Same Side Response:',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "${widget.meanSameSide} ms",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Text(
                            'Mean Reaction Time for Opposite Side Response:',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${widget.meanOppositeSide} ms',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Text(
                            'Attention Bias:',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${widget.attentionBias} ms',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Text(
                            'Number of Errors in Same Side Response: ',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${widget.errorsSameSide}',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          Text(
                            'Number of Errors in Opposite Side Response: ',
                            style: TextStyle(color: Colors.black38),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              '${widget.errorsOppositeSide}',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: size.width * 0.6,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF2D87FF)),
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
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                            onPressed: _exportToExcel,
                            child: Text(
                              'Export to Excel',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
