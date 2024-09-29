import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  CustomButton({super.key, required this.title, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360, //MediaQuery.of(context).size.width
      child: MaterialButton(
        height: 45,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: kprimaryColor,
        textColor: Colors.white,
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
