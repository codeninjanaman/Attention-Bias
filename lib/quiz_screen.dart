import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For RawKeyboardListener
import 'report_screen.dart';

class QuizScreen extends StatefulWidget {
  
  final String name;  // Add name
  final String age;   // Add age
  final String gender;  // Add gender
  final String email;  // Add email
  final String date;   // Add date (current date when quiz started)
  final bool demoMode;

  QuizScreen({
    required this.demoMode,
    required this.name,  // Initialize in constructor
    required this.age,   // Initialize in constructor
    required this.gender,  // Initialize in constructor
    required this.email,  // Initialize in constructor
    required this.date,   // Initialize in constructor
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}
class _QuizScreenState extends State<QuizScreen> {
  List<List<Map<String, String>>> originalImagePairs = [
    // The original list of 16 image pairs
    [
        {"type": "food", "path": "assets/food1.png"},
        {"type": "non-food", "path": "assets/non_food1.png"}
    ],
    [
        {"type": "food", "path": "assets/food2.png"},
        {"type": "non-food", "path": "assets/non_food2.png"}
    ],
    [
        {"type": "food", "path": "assets/food3.png"},
        {"type": "non-food", "path": "assets/non_food3.png"}
    ],
    [
        {"type": "food", "path": "assets/food4.png"},
        {"type": "non-food", "path": "assets/non_food4.png"}
    ],
    [
        {"type": "food", "path": "assets/food5.png"},
        {"type": "non-food", "path": "assets/non_food5.png"}
    ],
    [
        {"type": "food", "path": "assets/food6.png"},
        {"type": "non-food", "path": "assets/non_food6.png"}
    ],
    [
        {"type": "food", "path": "assets/food7.png"},
        {"type": "non-food", "path": "assets/non_food7.png"}
    ],
    [
        {"type": "food", "path": "assets/food8.png"},
        {"type": "non-food", "path": "assets/non_food8.png"}
    ],
    [
        {"type": "food", "path": "assets/food9.png"},
        {"type": "non-food", "path": "assets/non_food9.png"}
    ],
    [
        {"type": "food", "path": "assets/food10.png"},
        {"type": "non-food", "path": "assets/non_food10.png"}
    ],
    [
        {"type": "food", "path": "assets/food11.png"},
        {"type": "non-food", "path": "assets/non_food11.png"}
    ],
    [
        {"type": "food", "path": "assets/food12.png"},
        {"type": "non-food", "path": "assets/non_food12.png"}
    ],
    [
        {"type": "food", "path": "assets/food13.png"},
        {"type": "non-food", "path": "assets/non_food13.png"}
    ],
    [
        {"type": "food", "path": "assets/food14.png"},
        {"type": "non-food", "path": "assets/non_food14.png"}
    ],
    [
        {"type": "food", "path": "assets/food15.png"},
        {"type": "non-food", "path": "assets/non_food15.png"}
    ],
    [
        {"type": "food", "path": "assets/food16.png"},
        {"type": "non-food", "path": "assets/non_food16.png"}
    ],
  ];

  List<List<Map<String, String>>> imagePairs = []; // This will hold shuffled pairs for each loop

  int currentQuestion = 1;
  int totalQuestions = 0; // Total questions counter
  int maxQuestions = 50; // 50 questions for the full test
  int demoMaxQuestions = 10; // 10 questions for demo mode

  int correctSameSide = 0;
  int correctOppositeSide = 0;
  int errorsSameSide = 0;
  int errorsOppositeSide = 0;

  bool showImages = false;
  bool showFinalImage = false;
  bool isFoodOnLeft = false;

  DateTime? startTime;
  List<int> reactionTimesSameSide = [];
  List<int> reactionTimesOppositeSide = [];

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    if (widget.demoMode) {
      // Limit to 10 questions in demo mode
      imagePairs = List.from(originalImagePairs);
      imagePairs.shuffle();
      imagePairs = imagePairs.take(demoMaxQuestions).toList(); // Demo mode with 10 questions
    } else {
      // Normal mode with 50 questions
      imagePairs = List.from(originalImagePairs);
      imagePairs.shuffle(); // Shuffle at the start
    }

    startQuiz();
    _focusNode.requestFocus(); // Focus on keyboard input
  }

  void startQuiz() {
    showImages = true;
    showFinalImage = false;
    setState(() {});

    Timer(Duration(seconds: 1), () {
      showImages = false;
      showFinalImage = true;
      isFoodOnLeft = Random().nextBool();
      startTime = DateTime.now();
      setState(() {});
    });
  }

  void handleResponse(bool isLeft) {
    if (!showFinalImage) return;

    final reactionTime = DateTime.now().difference(startTime!).inMilliseconds;

    if (isLeft && isFoodOnLeft) {
      correctSameSide++;
      reactionTimesSameSide.add(reactionTime);
    } else if (!isLeft && !isFoodOnLeft) {
      correctSameSide++;
      reactionTimesSameSide.add(reactionTime);
    } else if (isLeft && !isFoodOnLeft) {
      errorsOppositeSide++;
      reactionTimesOppositeSide.add(reactionTime);
    } else if (!isLeft && isFoodOnLeft) {
      errorsOppositeSide++;
      reactionTimesOppositeSide.add(reactionTime);
    }

    // Increment total questions counter
    totalQuestions++;

    // If totalQuestions reaches the max limit (50 for normal mode, 10 for demo), end the test
    if (totalQuestions >= (widget.demoMode ? demoMaxQuestions : maxQuestions)) {
      showFinalReport(); // End the test after 50 questions (or 10 in demo mode)
    } else {
      // Move to the next question, shuffle and reset after every loop of 16
      if (currentQuestion < imagePairs.length - 1) {
        currentQuestion++;
      } else {
        currentQuestion = 0; // Reset the question index after 16 pairs
        imagePairs.shuffle(); // Reshuffle for the next loop
      }
      startQuiz();
    }
  }

  void showFinalReport() {

    if (widget.demoMode) {
      // End the demo mode test and return to the previous screen
      Navigator.pop(context); // Simply pop the current screen without showing a report
      return;
    }
    
    final meanSameSide = reactionTimesSameSide.isNotEmpty
        ? (reactionTimesSameSide.reduce((a, b) => a + b) / reactionTimesSameSide.length).toDouble()
        : 0.0;

    final meanOppositeSide = reactionTimesOppositeSide.isNotEmpty
        ? (reactionTimesOppositeSide.reduce((a, b) => a + b) / reactionTimesOppositeSide.length).toDouble()
        : 0.0;

    final attentionBias = (meanSameSide - meanOppositeSide).abs();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ReportScreen(
          meanSameSide: meanSameSide,
          meanOppositeSide: meanOppositeSide,
          attentionBias: attentionBias,
          errorsSameSide: errorsSameSide,
          errorsOppositeSide: errorsOppositeSide,
          name: widget.name,
          age: widget.age,
          gender: widget.gender,
          email: widget.email,
          date: widget.date,
        ),
      ),
    );
  }

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        handleResponse(true);
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        handleResponse(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: RawKeyboardListener(
        focusNode: _focusNode,
        onKey: _handleKeyPress,
        autofocus: true,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            showImages
                                ? Image.asset(
                                    imagePairs[currentQuestion][0]['path']!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  )
                                : (showFinalImage && isFoodOnLeft)
                                    ? Image.asset(
                                        imagePairs[currentQuestion][0]['path']!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.contain,
                                      )
                                    : SizedBox(
                                        width: 150,
                                        height: 150,
                                      ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_left, size: 50),
                                onPressed: () => handleResponse(true),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(
                          children: [
                            showImages
                                ? Image.asset(
                                    imagePairs[currentQuestion][1]['path']!,
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.contain,
                                  )
                                : (showFinalImage && !isFoodOnLeft)
                                    ? Image.asset(
                                        imagePairs[currentQuestion][1]['path']!,
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.contain,
                                      )
                                    : SizedBox(
                                        width: 150,
                                        height: 150,
                                      ),
                            SizedBox(height: 20),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black, width: 2),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: IconButton(
                                icon: Icon(Icons.arrow_right, size: 50),
                                onPressed: () => handleResponse(false),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
