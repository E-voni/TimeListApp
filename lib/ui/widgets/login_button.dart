import 'package:flutter/material.dart';
import '../theme.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const LoginButton({Key? key, required this.label, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: bluishClr,
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 15, left: 33),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}