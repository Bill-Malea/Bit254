import 'package:bit254/Utilities/colors.dart';
import 'package:flutter/material.dart';

class FormInputFieldWithIcon extends StatelessWidget {
  FormInputFieldWithIcon({
    //required this.iconPrefix,
    required this.labelText,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  
    required this.onSaved,
  });

  // final TextEditingController controller;
  //final IconData iconPrefix;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextFormField(
        style: TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            vertical: -2.5,
            horizontal: 10,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: kSuccessColor,
              width: 0.0,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: kSuccessColor,
              width: 0.0,
            ),
          ),

          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.red,
              width: 0.0,
            ),
          ),
          labelStyle: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
          labelText: labelText,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: kSuccessColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: kSuccessColor,
              width: 1.0,
            ),
          ),
          // prefixIcon: Icon(
          //   iconPrefix,
          //   color: kSuccessColor,
          //   size: 12,
          // ),
          // labelText: labelText,
          errorStyle: TextStyle(
            fontSize: 12,
          ),
        ),
        onSaved: onSaved,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }
}
