import 'package:flutter/material.dart';
import 'package:myapp/ui/pages/login_page.dart';
import 'package:myapp/ui/pages/reg_page.dart';

class LoginOrRegPage extends StatefulWidget {
  const LoginOrRegPage ({super.key});

  @override
  State<LoginOrRegPage> createState() => _LoginOrRegPageState();

}

class _LoginOrRegPageState extends State<LoginOrRegPage> {
  //initially show login page
  bool showLoginPage = true;

  //toggle between login and register page
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePages);
    } else {
      return RegPage(
        onTap: togglePages
      );
    }
  }
}