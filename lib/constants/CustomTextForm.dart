import 'package:e_commerce/screens/constans.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatefulWidget {
  final String hintText;
  final TextEditingController myControler;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  CustomTextForm(
      {required this.hintText,
      required this.keyboardType,
      required this.myControler,
      required this.isPassword,
      required this.validator});

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {
  bool isObscured = true;

  void togglePasswordVisibility() {
    setState(() {
      isObscured = !isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isPassword) {
      return TextFormField(
        validator: widget.validator,
        controller: widget.myControler,
        obscureText: (widget.isPassword && isObscured),
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
            color: kprimaryColor2,
          )),
          contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
          filled: true,
          fillColor: Colors.grey[100],
          labelText: widget.hintText,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey),
          ),
          suffixIcon: IconButton(
            onPressed: togglePasswordVisibility,
            icon: Icon(
              isObscured ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            ),
          ),
        ),
      );
    } else {
      return TextFormField(
        validator: widget.validator,
        controller: widget.myControler,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: kprimaryColor2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            filled: true,
            fillColor: Colors.grey[100],
            labelText: widget.hintText,
            labelStyle: TextStyle(color: Colors.grey, fontSize: 15),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            )),
      );
    }
  }
}
