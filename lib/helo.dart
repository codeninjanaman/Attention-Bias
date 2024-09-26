// import 'package:attention_bias/login_screen.dart';
// import 'package:attention_bias/math_quiz_screen.dart';
// import 'package:attention_bias/quiz_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class HomeScreen extends StatefulWidget {
//   final User user;
//   final String name;

//   HomeScreen({required this.user, required this.name});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   String selectedQuiz = 'Quiz 1';

//   bool isExpanded = false;

//   void toggleExpanded() {
//     setState(() {
//       isExpanded = !isExpanded;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Center(
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text('Welcome, ${widget.name}', 
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 22,
//                       fontWeight: FontWeight.w500
//                     ),)),
//                   SizedBox(height: 20),

//                   Align(
//                     alignment: Alignment.centerLeft,
//                      child: Container(
//                       width: size.width*0.3,
                      
//                        child: DropdownButtonFormField<String>(
//                                    value: selectedQuiz,
//                                    decoration: InputDecoration(
//                                      fillColor: Color(0xFF2D87FF), // Background color
//                                      filled: true,
//                                     border: OutlineInputBorder(
//                                      borderRadius: BorderRadius.circular(25), // Circular border radius
//                                      borderSide: BorderSide.none, // Removes the border line
//                                    ),
//                                      contentPadding: EdgeInsets.symmetric(horizontal: 20), // Adds padding around the dropdown
//                                    ),
//                                    dropdownColor: Color(0xFF2D87FF), // Dropdown menu background color
//                                    style: TextStyle(color: Colors.white), // Text color
//                                    iconEnabledColor: Colors.white, // Dropdown arrow color
//                                    items: <String>['Quiz 1', 'Quiz 2'].map((String value) {
//                                      return DropdownMenuItem<String>(
//                                        value: value,
//                                        child: Text(value, style: TextStyle(color: Colors.white)),
//                                      );
//                                    }).toList(),
//                                    onChanged: (String? newValue) {
//                                      setState(() {
//                                        selectedQuiz = newValue!;
//                                      });
//                                    },
//                                  ),
//                      ),
//                    ),
//                   SizedBox(height: 20),
          
//                   // Conditional rendering based on selected quiz
//                   selectedQuiz == 'Quiz 1' ? quiz1Container() : quiz2Container(),

//                   // Common buttons for starting quiz and signing out
//                   quizStartButtons(size),
//                   SizedBox(height: 10),
//                   ElevatedButton(
//                     onPressed: () async {
//                       await FirebaseAuth.instance.signOut();
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()),
//                       );
//                     },
//                     child: Text('Sign Out'),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget quiz1Container() {
//     return paradigmContainer();
//   }

//   Widget quiz2Container() {
//     return Container(
//       padding: EdgeInsets.all(8),
//       decoration: BoxDecoration(
//         color: Colors.blue,
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Text('Hello', style: TextStyle(color: Colors.white, fontSize: 16)),
//     );
//   }

//   Widget quizStartButtons(Size size) {
//     return ElevatedButton(
//       onPressed: () {
//         if (selectedQuiz == 'Quiz 1') {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => QuizScreen(demoMode: false)),
//           );
//         } else {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => MathQuizScreen(demoMode: false)),
//           );
//         }
//       },
//       child: Text('Start'),
//     );
//   }

//   Widget paradigmContainer() {
//     return Container(
//       // Your existing code for the "Paradigm 1" container
//     );
//   }
// }
