
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/ui/theme.dart';
import 'package:flutter/src/material/colors.dart';
import 'package:myapp/ui/widgets/login_button.dart';
import 'package:myapp/ui/widgets/square_tile.dart';

import '../../services/theme_services.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatelessWidget{
   LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method
   void signUserIn(){}

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const SizedBox(height: 25),
              const Icon(Icons.lock,
              size: 100,
              color: Color(0xfff17309)),

              const SizedBox(height: 20),
              const Text(
                  "Welcome",
                style: TextStyle(color: Color(0xfff17309),
                fontSize: 30,)
              ),

              const SizedBox(height: 10),
              //username textfield
              InputField(
                title: "    Username",
                hint: "Enter username",
                controller: usernameController,
              ),


              const SizedBox(height: 10),
              //password textfield
              InputField(
                title: "    Password",
                hint: "Enter password",
                controller: passwordController,
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
                  '-------- Or continue with --------',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              
              const SizedBox(height: 20),
              //google sign in
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                SquareTile(imagePath: 'lib/images/google_logo.png'),
              ],),

              const SizedBox(height: 20),
              //not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Not a member?'),
                  SizedBox(width: 4),
                  Text('Register now',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),),
                ],
              )



            ],

          ),
        ),
      )



    );
  }


}