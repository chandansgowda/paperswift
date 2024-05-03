import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:paperswift/controllers/auth_controller.dart';
import 'package:paperswift/utils/constants.dart';


class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AuthController authController =Get.put(AuthController());

  bool isLoggingIn = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(children: [

        Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width / 3,
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.circular(25)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "LOGIN",
                    style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      label: Text(
                        "Username",
                        style: TextStyle(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white70.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      label: Text(
                        "Password",
                        style: TextStyle(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: Colors.white70.withOpacity(0.2),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(20)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () async{
                      final pass = _passwordController.text;
                      final username=_usernameController.text;
                      try {
                        setState(() {
                          isLoggingIn = true;
                        });
                        authController.login(username,pass);
                      }
                      catch(e){
                        setState(() {
                          isLoggingIn = false;
                        });
                        showDialog(context: context, builder: (_) {
                          return AlertDialog(
                            title: Text("Some Error Occured. Try Again!"),
                            content: Text("Error Log\n$e"),
                          );
                        });
                      }},
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(Size(200, 50)),
                        backgroundColor: MaterialStateProperty.all(
                            primaryColor)),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isLoggingIn)
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white70.withOpacity(0.35),
              child: Center(child: CircularProgressIndicator(color: Colors.deepOrange,),),
            ),
          )
      ]),
    );
  }
}