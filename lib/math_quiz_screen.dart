import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'math_report.dart';

class MathQuizScreen extends StatefulWidget {
  final bool demoMode;
  final String name;
  final String age;
  final String gender;
  final String email;
  final String date;

  MathQuizScreen({
    required this.demoMode,
    required this.name,
    required this.age,
    required this.gender,
    required this.email,
    required this.date,
  });

  @override
  _MathQuizScreenState createState() => _MathQuizScreenState();
}

class _MathQuizScreenState extends State<MathQuizScreen> {
  List<Map<String, dynamic>> questions = [
    {"question": "14 + 3", "options": {"A": 16, "B": 17}, "correct_answer": "B"},
    {"question": "5 + 5", "options": {"A": 10, "B": 11}, "correct_answer": "A"},
    {"question": "6 + 7", "options": {"A": 12, "B": 13}, "correct_answer": "B"},
    {"question": "10 + 9", "options": {"A": 18, "B": 19}, "correct_answer": "B"},
    {"question": "12 + 8", "options": {"A": 20, "B": 21}, "correct_answer": "A"},
    {"question": "16 + 4", "options": {"A": 20, "B": 21}, "correct_answer": "A"},
    {"question": "19 + 5", "options": {"A": 23, "B": 24}, "correct_answer": "B"},
    {"question": "2 + 3", "options": {"A": 4, "B": 5}, "correct_answer": "B"},
    {"question": "1 + 7", "options": {"A": 8, "B": 9}, "correct_answer": "A"},
    {"question": "13 + 6", "options": {"A": 18, "B": 19}, "correct_answer": "B"},
    {"question": "9 + 9", "options": {"A": 17, "B": 18}, "correct_answer": "B"},
    {"question": "21 + 4", "options": {"A": 25, "B": 26}, "correct_answer": "A"},
    {"question": "17 + 3", "options": {"A": 19, "B": 20}, "correct_answer": "B"},
    
    {"question": "45 - 5", "options": {"A": 40, "B": 39}, "correct_answer": "A"},
    {"question": "48 - 6", "options": {"A": 42, "B": 41}, "correct_answer": "A"},
    {"question": "16 - 4", "options": {"A": 12, "B": 11}, "correct_answer": "A"},
    {"question": "40 - 8", "options": {"A": 32, "B": 31}, "correct_answer": "A"},
    {"question": "42 - 6", "options": {"A": 36, "B": 35}, "correct_answer": "A"},
    {"question": "27 - 3", "options": {"A": 24, "B": 23}, "correct_answer": "A"},
    {"question": "10 - 5", "options": {"A": 5, "B": 4}, "correct_answer": "A"},
    {"question": "60 - 6", "options": {"A": 54, "B": 53}, "correct_answer": "A"},
    {"question": "7 - 1", "options": {"A": 6, "B": 5}, "correct_answer": "A"},
    {"question": "26 - 2", "options": {"A": 24, "B": 23}, "correct_answer": "A"},
    {"question": "48 - 4", "options": {"A": 44, "B": 43}, "correct_answer": "A"},
    {"question": "45 - 3", "options": {"A": 42, "B": 41}, "correct_answer": "A"},
    {"question": "70 - 5", "options": {"A": 65, "B": 64}, "correct_answer": "A"},

    {"question": "48 ÷ 6", "options": {"A": 7, "B": 8}, "correct_answer": "B"},
    {"question": "16 ÷ 4", "options": {"A": 3, "B": 4}, "correct_answer": "B"},
    {"question": "40 ÷ 8", "options": {"A": 4, "B": 5}, "correct_answer": "B"},
    {"question": "42 ÷ 6", "options": {"A": 6, "B": 7}, "correct_answer": "B"},
    {"question": "27 ÷ 3", "options": {"A": 8, "B": 9}, "correct_answer": "B"},
    {"question": "10 ÷ 5", "options": {"A": 1, "B": 2}, "correct_answer": "B"},
    {"question": "60 ÷ 6", "options": {"A": 9, "B": 10}, "correct_answer": "B"},
    {"question": "7 ÷ 1", "options": {"A": 6, "B": 7}, "correct_answer": "B"},
    {"question": "26 ÷ 2", "options": {"A": 12, "B": 13}, "correct_answer": "B"},
    {"question": "48 ÷ 4", "options": {"A": 11, "B": 12}, "correct_answer": "B"},
    {"question": "45 ÷ 3", "options": {"A": 14, "B": 15}, "correct_answer": "B"},
    {"question": "70 ÷ 5", "options": {"A": 13, "B": 14}, "correct_answer": "B"},

    {"question": "9 * 6", "options": {"A": 52, "B": 54}, "correct_answer": "B"},
    {"question": "4 * 7", "options": {"A": 28, "B": 29}, "correct_answer": "A"},
    {"question": "6 * 6", "options": {"A": 35, "B": 36}, "correct_answer": "B"},
    {"question": "3 * 8", "options": {"A": 23, "B": 24}, "correct_answer": "B"},
    {"question": "5 * 5", "options": {"A": 24, "B": 25}, "correct_answer": "B"},
    {"question": "2 * 9", "options": {"A": 18, "B": 19}, "correct_answer": "A"},
    {"question": "10 * 4", "options": {"A": 39, "B": 40}, "correct_answer": "B"},
    {"question": "7 * 7", "options": {"A": 48, "B": 49}, "correct_answer": "B"},
    {"question": "12 * 2", "options": {"A": 23, "B": 24}, "correct_answer": "B"},
    {"question": "11 * 3", "options": {"A": 32, "B": 33}, "correct_answer": "B"},
    {"question": "9 * 5", "options": {"A": 44, "B": 45}, "correct_answer": "B"},
    {"question": "8 * 6", "options": {"A": 47, "B": 48}, "correct_answer": "B"},
  ];



  int currentQuestion = 0;
  int correctResponses = 0;
  int incorrectResponses = 0;

  bool showQuestion = true;
  bool showOptions = false;
  bool isCorrectOnLeft = false;

  DateTime? startTime;
  List<int> reactionTimesCorrect = [];
  List<int> reactionTimesIncorrect = [];

  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    questions.shuffle();
    if (widget.demoMode) {
      questions = questions.take(10).toList();
    }
    startQuiz();
    _focusNode.requestFocus();
  }

  void startQuiz() {
    showQuestion = true;
    showOptions = false;
    setState(() {});

    Timer(Duration(seconds: 1), () {
      showQuestion = false;
      showOptions = true;
      isCorrectOnLeft = Random().nextBool();
      startTime = DateTime.now();
      setState(() {});
    });
  }

  void onColumnTap(String column) {
    if (!showOptions) return;

    final reactionTime = DateTime.now().difference(startTime!).inMilliseconds;

    String userAnswer;
    if (column == 'left') {
      userAnswer = isCorrectOnLeft ? "A" : "B";
    } else if (column == 'right') {
      userAnswer = isCorrectOnLeft ? "B" : "A";
    } else {
      return;
    }

    if (userAnswer == questions[currentQuestion]['correct_answer']) {
      correctResponses++;
      reactionTimesCorrect.add(reactionTime);
    } else {
      incorrectResponses++;
      reactionTimesIncorrect.add(reactionTime);
    }

    if (currentQuestion < questions.length - 1) {
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
    final meanCorrectResponse = reactionTimesCorrect.isNotEmpty
        ? (reactionTimesCorrect.reduce((a, b) => a + b) / reactionTimesCorrect.length).toDouble()
        : 0.0;

    final meanIncorrectResponse = reactionTimesIncorrect.isNotEmpty
        ? (reactionTimesIncorrect.reduce((a, b) => a + b) / reactionTimesIncorrect.length).toDouble()
        : 0.0;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MathReportScreen(
          meanCorrectResponse: meanCorrectResponse,
          meanIncorrectResponse: meanIncorrectResponse,
          attention_bias: (meanCorrectResponse - meanIncorrectResponse).abs(),
          correctResponses: correctResponses,
          incorrectResponses: incorrectResponses,
          name: widget.name,
          age: widget.age,
          gender: widget.gender,
          email: widget.email,
          date: widget.date,
        ),
      ),
    );
  }

  // Handle key presses (left/right arrow keys)
  void _handleKeyPress(RawKeyEvent event) {
    if (event is RawKeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowLeft) {
        onColumnTap('left');
      } else if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
        onColumnTap('right');
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display question or options
            if (showQuestion)
              Padding(
                padding: const EdgeInsets.only(bottom: 90),
                child: Text(
                  questions[currentQuestion]['question'],
                  style: TextStyle(fontSize: 40, letterSpacing: 4.0),
                ),
              )
            else
              Row(
                children: [
                  // Left-side answer option
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            isCorrectOnLeft
                                ? '${questions[currentQuestion]['options']['A']}'
                                : '${questions[currentQuestion]['options']['B']}',
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                  // Right-side answer option
                  Expanded(
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            !isCorrectOnLeft
                                ? '${questions[currentQuestion]['options']['A']}'
                                : '${questions[currentQuestion]['options']['B']}',
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            // Arrow buttons - Visible only when the options are shown
            if (showOptions) // Conditionally display the arrow buttons
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Black border
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_left, size: 50),
                            onPressed: () => onColumnTap('left'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black, // Black border
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            icon: Icon(Icons.arrow_right, size: 50),
                            onPressed: () => onColumnTap('right'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ),
  );
}

}
