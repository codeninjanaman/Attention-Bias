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
        {"type": "food", "path": "assets/food1.jpg"},
        {"type": "non-food", "path": "assets/non_food1.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food2.jpg"},
        {"type": "non-food", "path": "assets/non_food2.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food3.jpg"},
        {"type": "non-food", "path": "assets/non_food3.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food4.jpg"},
        {"type": "non-food", "path": "assets/non_food4.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food5.jpg"},
        {"type": "non-food", "path": "assets/non_food5.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food6.jpg"},
        {"type": "non-food", "path": "assets/non_food6.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food7.jpg"},
        {"type": "non-food", "path": "assets/non_food7.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food8.jpg"},
        {"type": "non-food", "path": "assets/non_food8.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food9.jpg"},
        {"type": "non-food", "path": "assets/non_food9.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food10.jpg"},
        {"type": "non-food", "path": "assets/non_food10.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food11.jpg"},
        {"type": "non-food", "path": "assets/non_food11.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food12.jpg"},
        {"type": "non-food", "path": "assets/non_food12.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food13.jpg"},
        {"type": "non-food", "path": "assets/non_food13.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food14.jpg"},
        {"type": "non-food", "path": "assets/non_food14.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food15.jpg"},
        {"type": "non-food", "path": "assets/non_food15.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food16.jpg"},
        {"type": "non-food", "path": "assets/non_food16.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food17.jpg"},
        {"type": "non-food", "path": "assets/non_food17.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food18.jpg"},
        {"type": "non-food", "path": "assets/non_food18.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food19.jpg"},
        {"type": "non-food", "path": "assets/non_food19.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food20.jpg"},
        {"type": "non-food", "path": "assets/non_food20.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food21.jpg"},
        {"type": "non-food", "path": "assets/non_food21.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food22.jpg"},
        {"type": "non-food", "path": "assets/non_food22.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food23.jpg"},
        {"type": "non-food", "path": "assets/non_food23.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food24.jpg"},
        {"type": "non-food", "path": "assets/non_food24.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food25.jpg"},
        {"type": "non-food", "path": "assets/non_food25.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food26.jpg"},
        {"type": "non-food", "path": "assets/non_food26.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food27.jpg"},
        {"type": "non-food", "path": "assets/non_food27.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food28.jpg"},
        {"type": "non-food", "path": "assets/non_food28.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food29.jpg"},
        {"type": "non-food", "path": "assets/non_food29.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food30.jpg"},
        {"type": "non-food", "path": "assets/non_food30.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food31.jpg"},
        {"type": "non-food", "path": "assets/non_food31.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food32.jpg"},
        {"type": "non-food", "path": "assets/non_food32.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food33.jpg"},
        {"type": "non-food", "path": "assets/non_food33.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food34.jpg"},
        {"type": "non-food", "path": "assets/non_food34.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food35.jpg"},
        {"type": "non-food", "path": "assets/non_food35.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food36.jpg"},
        {"type": "non-food", "path": "assets/non_food36.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food37.jpg"},
        {"type": "non-food", "path": "assets/non_food37.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food38.jpg"},
        {"type": "non-food", "path": "assets/non_food38.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food39.jpg"},
        {"type": "non-food", "path": "assets/non_food39.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food40.jpg"},
        {"type": "non-food", "path": "assets/non_food40.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food41.jpg"},
        {"type": "non-food", "path": "assets/non_food41.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food42.jpg"},
        {"type": "non-food", "path": "assets/non_food42.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food43.jpg"},
        {"type": "non-food", "path": "assets/non_food43.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food44.jpg"},
        {"type": "non-food", "path": "assets/non_food44.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food45.jpg"},
        {"type": "non-food", "path": "assets/non_food45.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food46.jpg"},
        {"type": "non-food", "path": "assets/non_food46.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food47.jpg"},
        {"type": "non-food", "path": "assets/non_food47.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food48.jpg"},
        {"type": "non-food", "path": "assets/non_food48.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food49.jpg"},
        {"type": "non-food", "path": "assets/non_food49.jpg"}
    ],
    [
        {"type": "food", "path": "assets/food50.jpg"},
        {"type": "non-food", "path": "assets/non_food50.jpg"}
    ]
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
