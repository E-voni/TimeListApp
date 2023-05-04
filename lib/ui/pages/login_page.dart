import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/services/auth_services.dart';
import 'package:myapp/ui/theme.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:myapp/ui/widgets/login_button.dart';
import 'package:myapp/ui/widgets/square_tile.dart';

import '../../services/theme_services.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatefulWidget{
   final Function()? onTap;
   LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  //sign user in method
  void signUserIn() async{
    //show loading circle
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }


  //error message
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

@override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                const SizedBox(height: 25),
                const Icon(Icons.person,
                size: 100,
                color: Color(0xfff17309)),

                const SizedBox(height: 20),
                const Text(
                    "Welcome to TimeList",
                  style: TextStyle(color: Color(0xfff17309),
                  fontSize: 30,)
                ),

                const SizedBox(height: 10),
                //username textfield
                InputField(
                  title: "    Email",
                  hint: "Enter email",
                  controller: emailController,
                  obscureText: false,
                ),


                const SizedBox(height: 10),
                //password textfield
                InputField(
                  title: "    Password",
                  hint: "Enter password",
                  controller: passwordController,
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                //forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forgot Password?',
                      style: TextStyle(color: Colors.grey[600])),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //sign in button
                LoginButton(
                    label: 'Sign In',
                    onTap: signUserIn,
                ),

                const SizedBox(height: 20),
                //or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Text(
                    '-------- Or sign in with --------',
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                const SizedBox(height: 20),
                //google sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  SquareTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google_logo.png'),
                ],),

                const SizedBox(height: 20),
                //not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not a member?', style: TextStyle(fontSize: 16)),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text('Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}