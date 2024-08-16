// import 'dart:html';
// import 'package:buildcondition/buildcondition.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cashier_app/shared/styles/colors.dart';

// int pizzaPrice = 70;
int currentIndex = 0;

Widget outlinedButton({
  double? height,
  double width = double.infinity,
  required function,
  required String text,
  MaterialStateProperty<OutlinedBorder?>? shape,
  ButtonStyle? style,
  MaterialStateProperty<BorderSide?>? side,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
            side: const MaterialStatePropertyAll(
              BorderSide(
                  style: BorderStyle.solid,
                  strokeAlign: -3.0,
                  width: 2.0,
                  color: primaryOrange),
            )),
        onPressed: function,
        child: Text(text,
            style: const TextStyle(
              color: primaryOrange,
              fontWeight: FontWeight.bold,
            )),
      ),
    );

Widget button({
  double width = double.infinity,
  double? height,
  required function,
  required String text,
}) =>
    SizedBox(
      height: height,
      width: width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        elevation: 0,
        color: primaryOrange,
        onPressed: function,
        child: Text(
          text.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w700,
            letterSpacing: 0.50,
          ),
        ),
      ),
    );

Widget defaultform({
  required TextEditingController controller,
  required TextInputType type,
  Function(String)? onSubmit,
  EdgeInsetsGeometry? padding,
  onChanged,
  onTap,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  TextStyle? labelStyle,
  validate,
  String? labeltext,
  IconData? prefix,
  bool isPassword = false,
  IconData? suffix,
  suffixPressed,
  String? hintText,
  InputBorder? border,
  InputBorder? errorBorder,
  InputBorder? enabledBorder,
  InputBorder? focusedBorder,
  InputBorder? disabledBorder,
  Color? prefixIconColor,
  Color? suffixIconColor,
  Color? focusColor,
  Color? fillColor,
  Icon? icon,
}) =>
    Container(
      padding: padding,
      decoration: const BoxDecoration(),
      child: TextFormField(
        style: textStyle,
        controller: controller,
        validator: validate,
        onChanged: onChanged,
        onFieldSubmitted: onSubmit,
        keyboardType: type,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: prefix != null
              ? IconButton(
                  icon: Icon(
                    prefix,
                  ),
                  onPressed: () {},
                )
              : null,
          fillColor: fillColor,
          disabledBorder: disabledBorder,
          focusedBorder: focusedBorder,
          focusColor: focusColor,
          enabledBorder: enabledBorder,
          hintStyle: hintStyle,
          prefixIconColor: prefixIconColor,
          suffixIconColor: suffixIconColor,
          labelStyle: labelStyle,
          errorBorder: errorBorder,
          hintText: hintText,
          suffixIcon: suffix != null
              ? IconButton(
                  icon: (Icon(suffix)),
                  onPressed: suffixPressed,
                )
              : null,
          // prefixIcon: Icon (prefix,),
          border: border,
          labelText: labeltext,
        ),
        onTap: onTap,
      ),
    );

Widget mydivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (Route<dynamic> route) => false,
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: chooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { success, error, warning }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.error:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.amber;
      break;
  }
  return color;
}
