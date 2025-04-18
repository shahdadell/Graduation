import 'package:flutter/material.dart';
import 'package:graduation_project/Theme/theme.dart';

class TextFiledResetPassword extends StatefulWidget {
  final String text;
  final IconData icon;
  final TextInputType type;
  final TextInputAction action;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool password;
  final bool enabled; // إضافة الـ enabled كـ parameter

  const TextFiledResetPassword({
    super.key,
    required this.text,
    required this.type,
    required this.action,
    required this.icon,
    required this.controller,
    required this.validator,
    this.password = false,
    this.enabled = true, // القيمة الافتراضية true (قابل للتعديل)
  });

  @override
  State<TextFiledResetPassword> createState() => _TextFiledResetPasswordState();
}

class _TextFiledResetPasswordState extends State<TextFiledResetPassword> {
  bool isObscured = true; // Initial state for password visibility

  void togglePasswordVisibility() {
    setState(() {
      isObscured = !isObscured;
    });

    // Hide password automatically after 1 second for extra security
    if (!isObscured) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isObscured = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: MyTheme.blackColor),
      obscureText: widget.password ? isObscured : false,
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.type,
      textInputAction: widget.action,
      enabled: widget.enabled, // تمرير الـ enabled للـ TextFormField
      decoration: InputDecoration(
        label: Text(
          widget.text,
          style: const TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: Color(0xffF87146)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xffb80505), width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xffb80505), width: 1.2),
        ),
        disabledBorder: OutlineInputBorder(
          // إضافة border للحالة المعطلة للحفاظ على التصميم
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(width: 2, color: Colors.grey),
        ),
        suffixIcon: widget.password
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: togglePasswordVisibility,
              )
            : Icon(widget.icon, color: Colors.grey),
      ),
    );
  }
}
