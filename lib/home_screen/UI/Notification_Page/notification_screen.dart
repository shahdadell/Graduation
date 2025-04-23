import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:lottie/lottie.dart';

class NotificationScreen extends StatelessWidget {
  static const String routeName = 'NotificationScreen';

  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: InkWell(
        onTap: () => Navigator.pop(context),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Icon(
            Icons.arrow_back_ios_rounded,
            color: MyTheme.whiteColor,
            size: 24.w,
          ),
        ),
      ),
      title: Text(
        "Notification",
        style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: MyTheme.grayColor3,
              blurRadius: 3.r,
              offset: const Offset(1, 1),
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideY(
        begin: 0.1,
        end: 0.0,
        duration: 400.ms,
        curve: Curves.easeOut,
      ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
      ),
    ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
                  'assets/images/No Notifacation.json',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
            const SizedBox(height: 20),
            Text(
            'No Notification',
            style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.mauveColor,
            ),
          ),
          ],
        ),
      ),
    );
  }
}