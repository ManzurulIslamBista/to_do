import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:to_do/providers/sql_helper.dart';
import 'package:to_do/views/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:to_do/views/log_in_page.dart';

class UserRegistration extends StatefulWidget {
  const UserRegistration({super.key});

  @override
  State<UserRegistration> createState() => _UserRegistrationState();
}

class _UserRegistrationState extends State<UserRegistration> {

  String uname = "";
  String pass = "";
  String conpass = "";

  @override
  void initstate(){
    super.initState();
  }

  void _showErrorSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('Passwords do not match!'),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showSuccessSnackBar(BuildContext context) {
    final snackBar = SnackBar(
      content: Text('$uname user has been created'),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void insertData( {required String uname,required String pass}) async {
    await context.read<SQLProvider>().initDatabase();
    await context.read<SQLProvider>().insertValueAtDatabase(tableName: 'users', uname: uname, password: pass);
  }
  @override
  Widget build(BuildContext context)   {

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
                      Text(
                        "Register",
                        style: TextStyle(
                          color: Color(0xDEFFFFFF),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child:  Column(
                    children: [
                      Text(
                        "Username",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                      TextField(
                        onChanged: (value)=> uname = value,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Username ',
                          hintStyle: TextStyle(color: Color(0xFF535353)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Password",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                      ),
                      TextField(
                        onChanged: (value)=> pass = value,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Color(0xFF535353)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Confirm Password",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xFFFFFFFF)),
                      ),
                      TextField(
                        onChanged: (value)=> conpass = value,
                        style: TextStyle(color: Colors.white),
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Confirm Password',
                          hintStyle: TextStyle(color: Color(0xFF535353)),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                GestureDetector(
                  onTap: () {
                    if(pass == conpass){
                      insertData(uname : uname, pass: pass);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));
                      _showSuccessSnackBar(context);
                    }
                    else{
                      _showErrorSnackBar(context);
            
                    }
            
                  },
                  child: CustomButton(buttonText: "Register",)
                ),
                SizedBox(height: 20,),
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
                            style: TextStyle(
                                fontSize: 16.0, color: Color(0xFF979797)),
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
                SizedBox(height: 20,),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xFF8875FF))),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/images/google.svg",
                                  semanticsLabel: 'googlr SVG Image',
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                                const Text(
                                  "Register With Google",
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
                    SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => UserRegistration()));
                      },
                      child: Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color(0xFF121212),
                              borderRadius: BorderRadius.circular(5),
                              border:
                                  Border.all(color: const Color(0xFF8875FF))),
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
                                  "Register With Apple",
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
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?Login",
                      style: TextStyle(color: Colors.grey),
                    )
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
