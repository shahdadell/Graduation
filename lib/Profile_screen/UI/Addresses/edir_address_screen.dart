import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/view_addresses/datumViewAddress.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'adresses_widgets.dart';

class EditAddressScreen extends StatefulWidget {
  final DatumViewAddress address;

  const EditAddressScreen({super.key, required this.address});

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController addressTitleController;
  late TextEditingController addressPhoneController;
  late TextEditingController addressCityController;
  late TextEditingController addressDetailsController;
  late TextEditingController addressLatitudeController;
  late TextEditingController addressLongitudeController;
  bool isDialogShown = false; // تتبع إذا كان الـ Dialog ظهر
  bool isButtonEnabled = true; // تتبع حالة زرار Save

  @override
  void initState() {
    super.initState();
    addressTitleController = TextEditingController(text: widget.address.addressName);
    addressPhoneController = TextEditingController(text: widget.address.addressPhone ?? '');
    addressCityController = TextEditingController(text: widget.address.addressCity ?? '');
    addressDetailsController = TextEditingController(text: widget.address.addressStreet);
    addressLatitudeController = TextEditingController(text: widget.address.addressLat);
    addressLongitudeController = TextEditingController(text: widget.address.addressLong);
  }

  @override
  void dispose() {
    addressTitleController.dispose();
    addressPhoneController.dispose();
    addressCityController.dispose();
    addressDetailsController.dispose();
    addressLatitudeController.dispose();
    addressLongitudeController.dispose();
    super.dispose();
  }

  bool _validateFields() {
    if (addressTitleController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Address title cannot be empty")),
      );
      return false;
    }
    if (addressPhoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Phone number cannot be empty")),
      );
      return false;
    }
    if (addressCityController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("City cannot be empty")),
      );
      return false;
    }
    if (addressDetailsController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Address details cannot be empty")),
      );
      return false;
    }
    if (addressLatitudeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Latitude cannot be empty")),
      );
      return false;
    }
    if (addressLongitudeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Longitude cannot be empty")),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: _buildAppBar(context, textTheme),
      body: Container(
        color: MyTheme.whiteColor,
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            // نمنع تكرار الـ Dialog
            if (isDialogShown) return;

            if (state is EditAddressSuccessState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.scale,
                title: 'Success',
                desc: 'Address updated successfully',
                btnOkText: 'OK',
                btnOkColor: MyTheme.orangeColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
                  });
                  Navigator.pop(context);
                },
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                titleTextStyle: textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.blackColor,
                ),
                descTextStyle: textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: MyTheme.grayColor2,
                ),
              ).show();
            } else if (state is EditAddressErrorState) {
              setState(() {
                isDialogShown = true;
              });
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.scale,
                title: 'Error',
                desc: 'Error updating address: ${state.message}',
                btnOkText: 'OK',
                btnOkColor: MyTheme.redColor,
                btnOkOnPress: () {
                  setState(() {
                    isDialogShown = false;
                    isButtonEnabled = true; // إعادة تفعيل الزر
                  });
                },
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                titleTextStyle: textTheme.displayMedium?.copyWith(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: MyTheme.blackColor,
                ),
                descTextStyle: textTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: MyTheme.grayColor2,
                ),
              ).show();
            }
          },
          builder: (context, state) {
            if (state is EditAddressLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: MyTheme.orangeColor),
              );
            }
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildAddressCard(context),
                    SizedBox(height: 16.h),
                    Column(
                      children: [
                        _buildButton(
                          context,
                          text: "Save Changes",
                          color: isButtonEnabled ? MyTheme.orangeColor : MyTheme.grayColor,
                          onPressed: isButtonEnabled
                              ? () {
                            if (_validateFields()) {
                              setState(() {
                                isButtonEnabled = false; // تعطيل الزر
                              });
                              context.read<AddressBloc>().add(
                                EditAddressEvent(
                                  addressId: widget.address.addressId ?? '0',
                                  name: addressTitleController.text,
                                  phone: addressPhoneController.text,
                                  city: addressCityController.text,
                                  street: addressDetailsController.text,
                                  lat: addressLatitudeController.text,
                                  long: addressLongitudeController.text,
                                ),
                              );
                            }
                          }
                              : null,
                        ),
                        SizedBox(height: 8.h),
                        _buildButton(
                          context,
                          text: "Cancel",
                          color: MyTheme.grayColor,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, TextTheme textTheme) {
    return AppBar(
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
      ).animate().scale(duration: 200.ms, curve: Curves.easeInOut),
      title: Text(
        "Edit Address",
        style: textTheme.displayLarge?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
          color: MyTheme.whiteColor,
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
    );
  }

  Widget _buildAddressCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      decoration: BoxDecoration(
        color: MyTheme.whiteColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: MyTheme.grayColor.withOpacity(0.3),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: MyTheme.blackColor.withOpacity(0.2),
            blurRadius: 8.r,
            spreadRadius: 1.r,
            offset: Offset(0, 4.h),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEditableAddressesField(
              context,
              "Address Title",
              addressTitleController,
              Icons.label,
              isEditing: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter address title';
                }
                return null;
              },
            ),
            buildEditableAddressesField(
              context,
              "Phone Number",
              addressPhoneController,
              Icons.phone,
              isEditing: true,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter phone number';
                }
                return null;
              },
            ),
            buildEditableAddressesField(
              context,
              "City",
              addressCityController,
              Icons.location_city,
              isEditing: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter city';
                }
                return null;
              },
            ),
            buildEditableAddressesField(
              context,
              "Address Details",
              addressDetailsController,
              Icons.location_on,
              isEditing: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter address details';
                }
                return null;
              },
            ),
            buildEditableAddressesField(
              context,
              "Latitude",
              addressLatitudeController,
              Icons.map,
              isEditing: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter latitude';
                }
                return null;
              },
            ),
            buildEditableAddressesField(
              context,
              "Longitude",
              addressLongitudeController,
              Icons.map,
              isEditing: true,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter longitude';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 500.ms).slideY(
      begin: 0.1,
      end: 0.0,
      duration: 500.ms,
      curve: Curves.easeOut,
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
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        elevation: 3,
        shadowColor: MyTheme.grayColor3.withOpacity(0.4),
        minimumSize: Size(double.infinity, 30.h), // زرار طويل
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
          fontSize: 13.sp,
          color: MyTheme.whiteColor,
        ),
      ),
    ).animate().scale(
      begin: Offset(1.0, 1.0),
      end: Offset(1.03, 1.03),
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    ).then().scale(
      begin: Offset(1.03, 1.03),
      end: Offset(1.0, 1.0),
      duration: Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    );
  }
}