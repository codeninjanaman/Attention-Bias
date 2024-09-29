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

  List<List<Map<String, String>>> imagePairs = [
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



  int currentQuestion = 0;
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

  FocusNode _focusNode = FocusNode(); // To focus on keyboard events

  @override
  void initState() {
    super.initState();
    imagePairs.shuffle();
    if (widget.demoMode) {
      imagePairs = imagePairs.take(5).toList();
    }
    startQuiz();

    // Request focus to capture keyboard input
    _focusNode.requestFocus();
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

    if (currentQuestion < imagePairs.length - 1) {
      currentQuestion++;
      startQuiz();
    } else {
      if (!widget.demoMode) {
        showFinalReport();
      } else {
        Navigator.pop(context);
      }
    }
  }
void showFinalReport() {
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
        name: widget.name,  // Pass the user name to ReportScreen
        age: widget.age,    // Pass the user age
        gender: widget.gender, // Pass the gender
        email: widget.email,   // Pass the email
        date: widget.date,    // Pass the date
      ),
    ),
  );
}

  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        handleResponse(true); // Left arrow key pressed
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        handleResponse(false); // Right arrow key pressed
      }
    }
  }
@override
Widget build(BuildContext context) {
  Size size = MediaQuery.of(context).size;
  return Scaffold(
    body: RawKeyboardListener(
      focusNode: _focusNode, // Focus node to capture keyboard events
      onKey: _handleKeyPress, // Function to handle key press events
      autofocus: true, // Automatically focus on the widget for keyboard events
      child: GestureDetector(
        behavior: HitTestBehavior.translucent, // Ensures the entire area captures taps
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
                          // Show the images before or after the 2 seconds depending on the state
                          showImages
                              ? Image.asset(
                                  imagePairs[currentQuestion][0]['path']!, // Initial image on the left
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.contain,
                                )
                              : (showFinalImage && isFoodOnLeft)
                                  ? Image.asset(
                                      imagePairs[currentQuestion][0]['path']!, // Final image on the left
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain,
                                    )
                                  : SizedBox(
                                      width: 150,
                                      height: 150,
                                    ), // Placeholder when no image is shown
                          SizedBox(height: 20), // Add margin-top to the arrow button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2), // Black border
                              borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_left, size: 50),
                              onPressed: () => handleResponse(true), // Left arrow button
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
                          // Show the images before or after the 2 seconds depending on the state
                          showImages
                              ? Image.asset(
                                  imagePairs[currentQuestion][1]['path']!, // Initial image on the right
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.contain,
                                )
                              : (showFinalImage && !isFoodOnLeft)
                                  ? Image.asset(
                                      imagePairs[currentQuestion][0]['path']!, // Final image on the right
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.contain,
                                    )
                                  : SizedBox(
                                      width: 150,
                                      height: 150,
                                    ), // Placeholder when no image is shown
                          SizedBox(height: 20), // Add margin-top to the arrow button
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2), // Black border
                              borderRadius: BorderRadius.circular(5), // Optional: rounded corners
                            ),
                            child: IconButton(
                              icon: Icon(Icons.arrow_right, size: 50),
                              onPressed: () => handleResponse(false), // Right arrow button
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

  void onScreenTap(TapUpDetails details) {
  if (!showFinalImage) return; // Ensure that images are being displayed

  final tapPosition = details.globalPosition.dx;
  final screenWidth = MediaQuery.of(context).size.width;

  final reactionTime = DateTime.now().difference(startTime!).inMilliseconds;

  if (tapPosition <= screenWidth / 2) {
    // Left side tapped
    if (isFoodOnLeft) {
      correctSameSide++;
      reactionTimesSameSide.add(reactionTime);
    } else {
      errorsOppositeSide++;
      reactionTimesOppositeSide.add(reactionTime);
    }
  } else {
    // Right side tapped
    if (!isFoodOnLeft) {
      correctSameSide++;
      reactionTimesSameSide.add(reactionTime);
    } else {
      errorsOppositeSide++;
      reactionTimesOppositeSide.add(reactionTime);
    }
  }

  if (currentQuestion < imagePairs.length - 1) {
    currentQuestion++;
    startQuiz();
  } else {
    if (!widget.demoMode) {
      showFinalReport();
    } else {
      Navigator.pop(context); // Return to home screen in demo mode
    }
  }
}
}
