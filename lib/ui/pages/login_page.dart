
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/ui/theme.dart';
import 'package:flutter/src/material/colors.dart';

import '../../services/theme_services.dart';

class LoginPage extends StatelessWidget{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Center(
          child: Column(
            children: const [
              SizedBox(height: 50),

              Icon(Icons.lock,
              size: 50,),

              SizedBox(height: 50),
              Text(
                  "Welcome",
                style: TextStyle(color: Colors.grey,
                fontSize: 16,)
              ),

              SizedBox(height: 25),
              //username textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),

              SizedBox(height: 10),
              //password textfield
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    fillColor: Colors.white,
                    filled: true,
                  ),
                ),
              ),
            ],

          ),
        ),
      )



    );
  }


}