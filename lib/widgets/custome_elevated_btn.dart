import 'package:flutter/material.dart';

class CustomeElevatedBtn extends StatelessWidget{
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final double? borderRadius;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;
  final IconData? icon;

  const CustomeElevatedBtn({super.key,
      required this.text,
      required this.onPressed,
      this.backgroundColor,
      this.textColor,
      this.borderRadius,
      this.fontSize,
      this.padding,
      this.icon,
     /* required Text child*/
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: textColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        padding: padding ?? EdgeInsets.symmetric(horizontal: 16.0,vertical: 12)
      ),
        onPressed: onPressed,
        child: Text( text ,
          style: TextStyle(fontSize: fontSize ?? 16.0),
        )

    );
  }

}