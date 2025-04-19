import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation_project/App_Images/app_images.dart';
import 'package:graduation_project/Theme/dialog_utils.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/auth/data/api/api_manager.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/data_source/auth_remote_data_source_impl.dart';
import 'package:graduation_project/auth/data/repository/auth_repository/repository/auth_repository_impl.dart';
import 'package:graduation_project/auth/domain/repository/repository/auth_repository_contract.dart';
import 'package:graduation_project/auth/sing_in_screen/sign_in_screen.dart';
import 'package:graduation_project/functions/navigation.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import '../../Theme/dialogs.dart';
import 'OtpCubit/OtpCubit.dart';
import 'OtpCubit/OtpState.dart';

class OtpScreen extends StatelessWidget {
  static const String routName = 'OtpScreen';
  final String email;
  OtpScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpCubit(
        authRepositoryContract: injectAuthRepositoryContract(),
      ),
      child: BlocListener<OtpCubit, OtpState>(
        listener: (context, state) {
          if (state is OtpLoadingState) {
            showLoadingDialog(context);
          } else if (state is OtpErrorState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            String errorMessage = state.errorMessage ?? "An error occurred";
            if (errorMessage.contains("Session expired")) {
              DialogUtils.showMessage(
                context,
                "Your session has expired. Please log in again.",
                posActionName: 'Ok',
                posAction: () {
                  AppLocalStorage.clearData();
                  pushAndRemoveUntil(context, const SignInScreen());
                },
              );
            } else if (errorMessage.contains("No internet connection")) {
              DialogUtils.showMessage(
                context,
                "No internet connection. Please check your network and try again.",
                posActionName: 'Ok',
              );
            } else {
              DialogUtils.showMessage(context, errorMessage, posActionName: 'Ok');
            }
          } else if (state is OtpSuccessState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            DialogUtils.showMessage(
              context,
              "Verification successful! Please log in.",
              posActionName: 'Ok',
              posAction: () {
                pushAndRemoveUntil(context, const SignInScreen());
              },
            );
          } else if (state is OtpResendSuccessState) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            DialogUtils.showMessage(
              context,
              "Code resent successfully! Check your email.",
              posActionName: 'Ok',
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(10.w),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: MyTheme.whiteColor,
                  size: 24.w,
                ),
              ),
            ),
            centerTitle: true,
            backgroundColor: MyTheme.orangeColor,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.r)),
            ),
            title: Text(
              "Verification Code",
              style: GoogleFonts.dmSerifDisplay(
                color: MyTheme.whiteColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ).animate().fadeIn(duration: 400.ms).slideY(
              begin: 0.1,
              end: 0.0,
              duration: 400.ms,
              curve: Curves.easeOut,
            ),
          ),
          body: Container(
            color: MyTheme.whiteColor,
            child: Builder(
              builder: (context) {
                final cubit = BlocProvider.of<OtpCubit>(context);
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          AppImages.logo,
                          width: 140.w,
                          height: 140.h,
                        ).animate().fadeIn(duration: 500.ms).scale(
                          begin: Offset(0.8, 0.8),
                          end: Offset(1.0, 1.0),
                          duration: 500.ms,
                          curve: Curves.easeOut,
                        ),
                        SizedBox(height: 15.h),
                        Text(
                          "Enter the 5-digit code sent to your email",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSerifDisplay(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ).animate().fadeIn(duration: 500.ms).slideY(
                          begin: 0.1,
                          end: 0.0,
                          duration: 500.ms,
                          curve: Curves.easeOut,
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(5, (index) {
                            return _buildOtpField(context, cubit, index);
                          }),
                        ).animate().fadeIn(duration: 600.ms).slideY(
                          begin: 0.1,
                          end: 0.0,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        ),
                        SizedBox(height: 20.h),
                        BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, state) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive a code? ",
                                  style: GoogleFonts.dmSerifDisplay(
                                    color: MyTheme.grayColor2,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (cubit.canResend)
                                  GestureDetector(
                                    onTap: () {
                                      cubit.resendCode(email);
                                    },
                                    child: Text(
                                      "Resend Code",
                                      style: GoogleFonts.dmSerifDisplay(
                                        color: MyTheme.orangeColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  )
                                else
                                  Text(
                                    "Resend in ${cubit.resendCountdown}s",
                                    style: GoogleFonts.dmSerifDisplay(
                                      color: MyTheme.grayColor2,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                              ],
                            );
                          },
                        ).animate().fadeIn(duration: 600.ms).slideY(
                          begin: 0.1,
                          end: 0.0,
                          duration: 600.ms,
                          curve: Curves.easeOut,
                        ),
                        SizedBox(height: 30.h),
                        BlocBuilder<OtpCubit, OtpState>(
                          builder: (context, state) {
                            String code = cubit.controllers.map((controller) => controller.text).join();
                            bool isEnabled = code.length == 5;
                            return _buildButton(
                              context,
                              text: "Verify",
                              color: isEnabled ? MyTheme.orangeColor : MyTheme.grayColor,
                              onPressed: isEnabled
                                  ? () {
                                cubit.verifyCode(context, email);
                              }
                                  : null,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(BuildContext context, OtpCubit cubit, int index) {
    return Container(
      width: 35.w, // قللنا العرض لـ 35.w
      height: 45.h, // قللنا الطول لـ 45.h
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: MyTheme.grayColor3.withOpacity(0.2),
            blurRadius: 8.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: TextField(
        controller: cubit.controllers[index],
        focusNode: cubit.focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: GoogleFonts.dmSerifDisplay(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: MyTheme.blackColor,
        ),
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.grayColor2, width: 1.w), // Border رمادي افتراضي
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.grayColor2, width: 1.w),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: MyTheme.orangeColor, width: 1.5.w), // Border برتقالي لما يتركز
          ),
        ),
        onChanged: (value) {
          if (value.length == 1 && index < 4) {
            cubit.focusNodes[index].unfocus();
            cubit.focusNodes[index + 1].requestFocus();
          } else if (value.isEmpty && index > 0) {
            cubit.focusNodes[index].unfocus();
            cubit.focusNodes[index - 1].requestFocus();
          }
        },
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, {
        required String text,
        required Color color,
        VoidCallback? onPressed,
      }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        elevation: 3,
        shadowColor: MyTheme.grayColor3.withOpacity(0.4),
      ),
      child: Text(
        text,
        style: GoogleFonts.dmSerifDisplay(
          fontSize: 14.sp,
          color: MyTheme.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    ).animate().scale(
      begin: Offset(1.0, 1.0),
      end: Offset(1.05, 1.05),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    ).then().scale(
      begin: Offset(1.05, 1.05),
      end: Offset(1.0, 1.0),
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }
}

AuthRepositoryContract injectAuthRepositoryContract() {
  return AuthRepositoryImpl(
    remoteDataSource: AuthRemoteDataSourceImpl(
      apiManager: ApiManager.getInstance(),
    ),
  );
}