import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String btnName;
  final Color? btnColor;
  final Color? textColor;
  final void Function()? onPressed;

  const CommonButton({
    super.key,
    required this.btnName,
    this.btnColor,
    this.textColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 330,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor ?? Colors.grey,
        ),
        onPressed: onPressed,
        child: Text(
          btnName,
          style: TextStyle(
            color: textColor ?? Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
