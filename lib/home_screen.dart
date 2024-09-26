import 'package:attention_bias/landingpage.dart';
import 'package:attention_bias/login_screen.dart';
import 'package:attention_bias/math_quiz_screen.dart';
import 'package:attention_bias/quiz_screen.dart';
import 'package:attention_bias/user_info_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  final User user;
  // final String name;

  HomeScreen({required this.user,
  //  required this.name
   });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedQuiz = 'Paradigm 1';

  bool isExpanded = false;

  void toggleExpanded() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return SafeArea(
      child: Scaffold(
      
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    // child: Text('Welcome, ${widget.name}', 
                    child: Text("Welcome",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w500
                    ),)),
                  const SizedBox(height: 20),
              
                   Align(
                    alignment: Alignment.centerLeft,
                     child: Container(
                      width: size.width*0.5,
                      
                       child: DropdownButtonFormField<String>(
                                   value: selectedQuiz,
                                   decoration: InputDecoration(
                                     fillColor: const Color(0xFF2D87FF), // Background color
                                     filled: true,
                                    border: OutlineInputBorder(
                                     borderRadius: BorderRadius.circular(25), // Circular border radius
                                     borderSide: BorderSide.none, // Removes the border line
                                   ),// Removes the underline
                                     contentPadding: const EdgeInsets.symmetric(horizontal: 20), // Adds padding around the dropdown
                                   ),
                                   dropdownColor: const Color(0xFF2D87FF), // Dropdown menu background color
                                   style: const TextStyle(color: Colors.white), // Text color
                                   iconEnabledColor: Colors.white, // Dropdown arrow color
                                   items: <String>['Paradigm 1', 'Paradigm 2'].map((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value, style: const TextStyle(color: Colors.white)),
                                     );
                                   }).toList(),
                                   onChanged: (String? newValue) {
                                     setState(() {
                                       selectedQuiz = newValue!;
                                     });
                                   },
                                 ),
                     ),
                   ),
                 
          
          
          
                  const SizedBox(height: 20),

                  selectedQuiz == 'Paradigm 1' ? quiz1Container() : quiz2Container(),
                   
                   const SizedBox(height: 20),
Container(
  padding: const EdgeInsets.all(8),
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 6,
        offset: const Offset(0, 3),
      ),
    ],
    color: const Color.fromARGB(153, 45, 135, 255),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          "Start Your Demo",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      const Text(
        "Try a few sample questions to see how the quiz works. Start now and sharpen your focus!",
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
      Align(
        alignment: Alignment.centerRight,
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            onPressed: () {
              // Directly start the demo mode without form
              if (selectedQuiz == 'Paradigm 1') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(
                      demoMode: true,
                      name: "", // No form required in demo, pass empty fields
                      age: "",
                      gender: "",
                      email: "",
                      date: DateTime.now().toString(),
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MathQuizScreen(
                      demoMode: true,
                      name: "",
                      age: "",
                      gender: "",
                      email: "",
                      date: DateTime.now().toString(),
                    ),
                  ),
                );
              }
            },
            child: const Text(
              'Start Demo',
              style: TextStyle(
                color: Color(0xFF2D87FF),
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    ],
  ),
),

                  
                  const SizedBox(height: 15),
                  
                
                
                  ElevatedButton.icon(
                    icon: Icon(Icons.logout, color: Colors.white,),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()),
                      );
                    },
                    label: const Text('Sign Out', style: TextStyle(
                      fontSize: 12, 
                      color: Colors.white
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget quiz1Container() {
    return  Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
            spreadRadius: 1, // Extent of the shadow spread
            blurRadius: 6, // Shadow blurring amount
            offset: const Offset(0, 3), // Horizontal and vertical offset of shadow
          )
        ],
        color: const Color.fromARGB(153, 45, 135, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Paradigm 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              isExpanded ? "Welcome to the Attention Bias Paradigm task. In this task, you will be presented with a series of stimuli on the screen. Your task is to carefully attend to these stimuli and respond based on the instructions provided." 
                         : "Welcome to the Attention Bias Paradigm task. In this task, you will be presented with a series of stimuli on the screen. Your task is to carefully attend to these stimuli and respond based on the instructions provided",
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),

          if (isExpanded) ...[
            const Text(
              "Task Overview:",
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Text(
              "1. You will see a series of images presented on the screen.",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            const Text(
              "2. One of these images will be food, while other will be non-food.",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            const Text(
              "3. Your task is to quickly and accurately indicate the orientation of food image.",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Instructions:",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '1. Orientation Judgment:',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
             const Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text(
                '• For each image, you will need to judge the orientation of the food image. ',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
             const Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text(
                '• After making your judgment on the orientation of the food image, a probe (food) will appear on the screen, either in the location of the food image or the non-food image. ',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• If the food image is at LEFT, tap the left side of the screen.',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  Text(
                    '• If the food image is at RIGHT, tap the right side of the screen.',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical:  8.0),
                    child: Text('2. Response Time:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('Respond as quickly and accurately as possible. Do not deliberate for too long on each image. Your initial response is important.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:  8.0),
              child: Text('3. Trial Structure:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('The image will then appear for a predetermined duration.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:  8.0),
              child: Text('4. Feedback:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('After responding, you will receive feedback on the accuracy of your response. Use this feedback to adjust your performance in subsequent trials.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            )
                ],
              ),
            ),
          ],
          InkWell(
            child: Text(isExpanded ? 'See Less' : 'See More', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12)),
            onTap: toggleExpanded,
          ),

           Align(
            alignment: Alignment.centerRight,
             child: SizedBox(
            
              height: 40,
               child:
                ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoForm(selectedQuiz: selectedQuiz),
      ),
    );
  },
  child: Text('Start', style: TextStyle(color: Color(0xFF2D87FF), fontSize: 12)),
),
             ),
           ),
                 
        ],
      ),
    );
  
  }

  Widget quiz2Container() {
     return  Container(
      padding: const EdgeInsets.all(8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with some transparency
            spreadRadius: 1, // Extent of the shadow spread
            blurRadius: 6, // Shadow blurring amount
            offset: const Offset(0, 3), // Horizontal and vertical offset of shadow
          )
        ],
        color: const Color.fromARGB(153, 45, 135, 255),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Paradigm 2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              isExpanded ? "Welcome to the Attention Bias Paradigm task. In this task, you will be presented with a series of math questions followed by two options on the screen. Your task is to carefully attend to these stimuli and respond based on the instructions provided." 
                         : "Welcome to the Attention Bias Paradigm task. In this task, you will be presented with a series of math questions followed by two options on the screen. Your task is to carefully attend to these stimuli and respond based on the instructions provided.",
              style: const TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),

          if (isExpanded) ...[
            const Text(
              "Task Overview:",
              style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
            const Text(
              "1. You will see a series of math questions presented on the screen.",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            const Text(
              "2. Following each question, you will be presented with two options on the screen.",
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
            
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Instructions:",
                style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                '1. Math Question:',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text(
                '• For each trial, a math question (multiplication, subtraction, addition, or division) will be presented.',
                style: TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• Solve the math question mentally.',
                    style: TextStyle(color: Colors.white, fontSize: 11),
                  ),
                  

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text('2. Probe Response:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                  ),
            Padding(
              padding: EdgeInsets.only(bottom: 0.0),
              child: Text('• After solving the math question, two probe options (left and right) will appear on the screen.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),

            Text('• If you think the correct answer to the math question is associated with the left option, tap the left side of the screen.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            Text('• If you think the correct answer to the math question is associated with the right option, tap the right side of the screen.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            Padding(
              padding: EdgeInsets.symmetric(vertical:  8.0),
              child: Text('3. Response Time:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('• Respond as quickly and accurately as possible.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),
            Text('• Do not deliberate for too long on each question. Your initial response is important.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text('4. Trial Structre:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('• The math question will then appear for a predetermined duration.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),
            Text('• After viewing the math question, you will have a brief response window to make your judgment.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),

              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text('5. Feedback:', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
              ),

              Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Text('• After responding, you will receive feedback on the accuracy of your response.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
            ),
               Text('• Use this feedback to adjust your performance in subsequent trials.', style: TextStyle(
                color: Colors.white,
                fontSize: 11
              )),
          
                ],
              ),
            ),
          ],
          InkWell(
            child: Text(isExpanded ? 'See Less' : 'See More', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 12)),
            onTap: toggleExpanded,
          ),

           Align(
            alignment: Alignment.centerRight,
             child: SizedBox(
            
              height: 40,
               child:
                ElevatedButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UserInfoForm(selectedQuiz: selectedQuiz),
      ),
    );
  },
  child: Text('Start', style: TextStyle(color: Color(0xFF2D87FF), fontSize: 12)),
),

             ),
           ),
                 
        ],
      ),
    );
  
  }
}