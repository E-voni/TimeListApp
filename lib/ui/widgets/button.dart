import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: bluishClr,
        ),
        child: Container(
          margin: const EdgeInsets.only(top: 7, left: 19),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}