import 'package:flutter/material.dart';

class CommonStyle {
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefix,
    Widget? prefixIcon,
    Widget? suffix,
    Widget? suffixIcon,
    Color? fillColor,
    bool showSelectableIcon = false,
    bool isOptional = false,
  }) {
    //
    if (showSelectableIcon) {
      suffixIcon = Icon(Icons.keyboard_arrow_down);
    }

    return InputDecoration(
      prefix: prefix,
      prefixIcon: prefixIcon == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: prefixIcon,
            ),
      suffix: suffix,
      suffixIcon: suffixIcon == null
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: suffixIcon,
            ),
      suffixIconConstraints: BoxConstraints(
        minWidth: 10,
        minHeight: 10,
      ),
      prefixIconConstraints: BoxConstraints(
        minWidth: 10,
        minHeight: 10,
      ),
      isDense: true,
      // contentPadding: const EdgeInsets.all(20.0),
      errorStyle: const TextStyle(
        color: Colors.red,
      ),
      // hintText: hintText,
      labelText: labelText == null
          ? null
          : "${labelText}${isOptional ? " (optional)" : ""}",
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      hintText: hintText,
      focusColor: Colors.white,
      labelStyle: TextStyle(
        fontSize: 13.0,
        color: Colors.black,
        letterSpacing: 0.7,
      ),
      hintStyle: TextStyle(
        fontSize: 13.0,
        color: Colors.black,
        letterSpacing: 0.7,
      ),
      //
      contentPadding: EdgeInsets.fromLTRB(10, 13, 10, 13),
      border: OutlineInputBorder(),
      // focusedErrorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.red,
      //     style: BorderStyle.solid,
      //   ),
      // ),
      // //
      // errorBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.red,
      //     style: BorderStyle.solid,
      //   ),
      // ),
      // //
      // enabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.white,
      //     style: BorderStyle.solid,
      //   ),
      // ),
      // //
      // disabledBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.white,
      //     style: BorderStyle.solid,
      //   ),
      // ),
      // //
      // //
      // focusedBorder: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.white,

      
      //     style: BorderStyle.solid,
      //   ),
      // ),
      // //
      // border: OutlineInputBorder(
      //   borderRadius: BorderRadius.circular(5.0),
      //   borderSide: const BorderSide(
      //     width: 0.0,
      //     color: Colors.white,
      //     style: BorderStyle.solid,
      //   ),
      // ),
      //
      filled: true,
      fillColor: fillColor ?? Colors.grey[100],
      //
    );
  }
}
