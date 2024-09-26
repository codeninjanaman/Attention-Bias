// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'home_screen.dart';
// import 'login_screen.dart';

// class VerifyScreen extends StatefulWidget {
//   final String name;
//   final String phone;
//   final String verificationId;

//   VerifyScreen({
//     required this.name,
//     required this.phone,
//     required this.verificationId,
//   });

//   @override
//   _VerifyScreenState createState() => _VerifyScreenState();
// }

// class _VerifyScreenState extends State<VerifyScreen> {
//   final TextEditingController _otpController = TextEditingController();

//   void _verifyOtp() async {
//     final otp = _otpController.text.trim();

//     if (otp.isEmpty) {
//       Fluttertoast.showToast(msg: 'Please enter OTP');
//       return;
//     }

//     try {
//       final credential = PhoneAuthProvider.credential(
//         verificationId: widget.verificationId,
//         smsCode: otp,
//       );
//       final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
//       final user = userCredential.user;

//       if (user != null) {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//             builder: (context) => HomeScreen(
//               user: user,
//               name: widget.name,
//             ),
//           ),
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Incorrect OTP');
//     }
//   }

//   void _editPhone() {
//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Verify OTP'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.edit),
//             onPressed: _editPhone,
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             TextField(
//               controller: _otpController,
//               decoration: InputDecoration(labelText: 'Enter OTP'),
//               keyboardType: TextInputType.number,
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _verifyOtp,
//               child: Text('Verify OTP'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



import 'package:attention_bias/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'home_screen.dart';

class VerifyScreen extends StatefulWidget {
  final String name;
  final String phone;
  final String verificationId;

  VerifyScreen({
    required this.name,
    required this.phone,
    required this.verificationId,
  });

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _verifyOtp() async {
    final otp = _otpController.text.trim();

    if (otp.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the OTP');
      return;
    }

    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            user: _auth.currentUser!,
            // name: widget.name,
          ),
        ),
        (Route<dynamic> route) => false, 
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Invalid OTP. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          ),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xFF2D87FF)),
        borderRadius: BorderRadius.circular(8),
      ),
    );
    Size size = MediaQuery.of(context).size;
   return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Stack(
            children:[
              Positioned(child: Image.asset('assets/bgring2.png',
              height: size.height*0.24,), bottom: 0,right: 0,),
               Padding(
                 padding: const EdgeInsets.all(20),
                 child: Column(
                               
                               
                               children: [
                  Align(
                      alignment: Alignment.centerLeft,  // Aligns the container to the left
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
                      builder: (context) => LoginScreen()
                    ),
                                   );
                      },
                      color: Color(0xFF2D87FF),
                    ),
                      ),
                    )
                    
                              ,SizedBox(height: size.height*0.07,),
                             
                              Align(
                               alignment: Alignment.centerLeft, 
                 child: Text("Verification Code",
                 style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w400
                 ),),
                              ),

                              Align(
                               alignment: Alignment.centerLeft, 
                 child: Text("We have sent the OTP to your mobile number",
                 style: TextStyle(
                  color: Colors.black26,
                  fontSize: 12,
                  fontWeight: FontWeight.w400
                 ),),
                              ),
                             
                              SizedBox(height: size.height*0.04,),
                              
                  
                  
                  
                   Pinput(
                 defaultPinTheme: defaultPinTheme,
                  length: 6,
                controller: _otpController,
                  showCursor: true,
                  
                ),
                  
                  SizedBox(height: size.height*0.05),
                  SizedBox(
                             
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF2D87FF)
                      ),
                      onPressed: _verifyOtp,
                      child: Text('Verify OTP',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14
                      ),),
                    ),
                  ),
                               ],
                             ),
               ),
         
            ] 
           
          ),
        ),
      ),
    );
  }
}
