import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do/providers/sql_helper.dart';
import 'package:to_do/views/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do/views/user_loged_page.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String uname = "";
  String pass = "";
  void _showErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Enter valid Username & Password!'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Logged as User : $uname '),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF121212),
        appBar: AppBar(
          leading: const BackButton(
            color: Color(0xFFFFFFFF),
          ),
          backgroundColor: const Color(0xFF121212),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(

                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Login",style: TextStyle(
                        color: Color(0xDEFFFFFF),
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                Container(
                  child: Column(
                    children: [
                      Text("Username",style:TextStyle(fontSize: 16,
                          color: Color(0xFFFFFFFF),
                      ),),
                      TextField(
                        onChanged: (value) => uname = value,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Username ',
                          hintStyle:TextStyle(color: Color(0xFF535353)),
                        ),
                      ),
                      SizedBox(height: 30,),
                      Text("Password",style: TextStyle(fontSize: 16,
                        color: Color(0xFFFFFFFF)
                      ),),
                      TextField(
                        onChanged: (value) => pass = value,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          hintStyle:TextStyle(color: Color(0xFF535353)),
                        ),
                      )
                    ],
                  ),

                ),
                SizedBox(height: 40,),
                GestureDetector(
                    onTap: () async {
                      bool loggedIn = await context
                          .read<SQLProvider>()
                          .loginUser(uname: uname, password: pass);
                      if (loggedIn) {
                        _showSuccessSnackBar(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserLoggedPage()));
                      } else {
                        _showErrorSnackBar(context);
                      }
                    },
                  child: CustomButton(buttonText: "Login",)
                ),
                SizedBox(height: 30,),
                Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          color: Color(0xFF979797),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or',
                          style: TextStyle(fontSize: 16.0,color: Color(0xFF979797)),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: Color(0xFF979797),
                        ),
                      ),
                    ],
                  ),
                ],
                                ),
                SizedBox(height: 30,),

                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ));

                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: const Color(0xFF8875FF))
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/google.svg",
                                  semanticsLabel: 'uptodo SVG Image',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  "Login With Google",
                                  style: TextStyle(
                                    color: Color(0xDEFFFFFF),
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),SizedBox(height: 20,),

                    GestureDetector(
                      onTap: (){
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration()));

                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: const Color(0xFF8875FF))
                          ),
                          child:  Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/apple.svg",
                                  semanticsLabel: 'uptodo SVG Image',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  "Login With Apple",
                                  style: TextStyle(
                                    color: Color(0xDEFFFFFF),
                                    fontSize: 16,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                SizedBox(height: 30,),
                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                Text("Don't have an account?Register",style: TextStyle(
                    color: Colors.grey
                ),)
                                  ],
                                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
