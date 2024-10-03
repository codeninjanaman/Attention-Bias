import 'package:attention_bias/login_screen.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Stack(
              
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset("assets/bgring.png",
                  height: size.height*0.14,
                  )),
                Padding(
                  padding: const EdgeInsets.only(top:30 , bottom: 20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            SizedBox(height: size.height*0.07,),
                            Text("Welcome to", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500
                            ),),
                            Text("Attention Bias Test", 
                            style: TextStyle(
                              color: Color(0xFF2D87FF),
                              fontSize: 24,
                              fontWeight: FontWeight.w700
                            ),),
                            Text("Version 1.0", 
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500
                            ),)
                          ],
                        ),
                        SizedBox(height: size.height*0.07,),
                     Image.asset("assets/brain.png", 
                     height: size.height*0.4,),
                    
                    SizedBox(height: size.height*0.07,),
                     Column(
                      children: [
                        SizedBox(
                      width: size.width*0.6,
                      
                       child: ElevatedButton(
                        
                        onPressed: (){
                        Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen()
                        ),
                                       );
                       }, child: 
                       Text("Log In", 
                       style: TextStyle(
                        color: Colors.white,
                        fontSize: 16
                       ),),
                       style: ElevatedButton.styleFrom(
                        
                        backgroundColor: Color(0xFF2D87FF),
                                       
                       ),
                       ),
                     )
                      ,
                      SizedBox(height: size.height*0.08,)
                      ],
                     )     
                     
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ); 
  }
}