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

class RegPage extends StatefulWidget{
  final Function()? onTap;
  RegPage({super.key, required this.onTap});

  @override
  State<RegPage> createState() => _RegPageState();
}

class _RegPageState extends State<RegPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  //sign user up method
  void signUserUp() async{
    //show loading circle
    showDialog(
        context: context,
        builder: (context){
          return const Center(
            child: CircularProgressIndicator(),
      );
    },
    );

  //try creating user
    try{
      //check if password is confirmed
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text);
      }else{
        //show error message when password not match
        showErrorMessage("Passwords don't match");
      }
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
                  const SizedBox(height: 15),
                  const Icon(Icons.lock,
                      size: 100,
                      color: Color(0xfff17309)),

                  const SizedBox(height: 10),
                  const Text(
                      "Welcome",
                      style: TextStyle(color: Color(0xfff17309),
                        fontSize: 30,)
                  ),

                  const SizedBox(height: 5),
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

                  //confirm password textfield
                  InputField(
                    title: "    Confirm Password",
                    hint: "Enter password again",
                    controller: confirmPasswordController,
                    obscureText: true,
                  ),

                  const SizedBox(height: 20),

                  //sign in button
                  LoginButton(
                    label: 'Sign Up',
                    onTap: signUserUp,
                  ),

                  const SizedBox(height: 20),
                  //or continue with
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: Text(
                      '-------- Or sign up with --------',
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
                      const Text('Already a member?',style: TextStyle(fontSize: 16)),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text('Login now',
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
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