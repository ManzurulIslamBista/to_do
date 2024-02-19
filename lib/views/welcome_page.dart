import 'package:flutter/material.dart';
import 'package:to_do/views/custom_button.dart';
import 'package:to_do/views/log_in_page.dart';
import 'package:to_do/views/user_registration_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Color(0xFFFFFFFF),
          ),
          backgroundColor: const Color(0xFF121212),
        ),
        backgroundColor: const Color(0xFF121212),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Expanded(flex: 4,
                child: Container(
                  child:Column(
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Welcome to UpTodo",style: TextStyle(
                            color: Color(0xDEFFFFFF),
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),)
                        ],
                      ),
                      const SizedBox(height: 30,),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text("Please login to your account or create new account to continue",style: TextStyle(
                              color: Color(0xDEFFFFFF),
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                              textAlign: TextAlign.center,),
                          )
                        ],
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height > 500 ? MediaQuery.of(context).size.height/2 : MediaQuery.of(context).size.height/20),
                    ],
                  ),
                ),
              ),


              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                },
                child: CustomButton(buttonText: "LOGIN",)
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MaterialApp(debugShowCheckedModeBanner: false ,home: UserRegistration())));

                },
                child: Center(
                  child: Container(
                    // height: 60,
                    width: MediaQuery.of(context).size.width-20,
                    decoration: BoxDecoration(
                      color: const Color(0xFF121212),
                      borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: const Color(0xFF8875FF))
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text("CREATE ACCOUNT",style: TextStyle(
                          color: Color(0xDEFFFFFF),
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                          textAlign: TextAlign.center,),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
