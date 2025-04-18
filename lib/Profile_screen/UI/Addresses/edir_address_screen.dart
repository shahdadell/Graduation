import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Profile_screen/data/model/response/Users%20Addresses/view_addresses/datumViewAddress.dart';
import 'package:graduation_project/Theme/theme.dart';

class EditAddressScreen extends StatelessWidget {
  final DatumViewAddress address;

  const EditAddressScreen({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final addressTitleController = TextEditingController(text: address.addressName);
    final addressPhoneController = TextEditingController(text: address.addressPhone ?? ''); // جديد: حقل التليفون
    final addressCityController = TextEditingController(text: address.addressCity ?? '');
    final addressDetailsController = TextEditingController(text: address.addressStreet);
    final addressLatitudeController = TextEditingController(text: address.addressLat);
    final addressLongitudeController = TextEditingController(text: address.addressLong);

    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is EditAddressSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Address updated successfully'),
              backgroundColor: MyTheme.greenColor,
              duration: const Duration(seconds: 2),
            ),
          );
          Navigator.pop(context);
        } else if (state is EditAddressErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error editing address: ${state.message}'),
              backgroundColor: MyTheme.redColor,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      child: Scaffold(
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
          "Edit Addresses",
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
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.orangeColor, MyTheme.orangeColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30.r),
          ),
        ),
      ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Card(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: addressTitleController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Address Title',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., Home, Work',
                          suffixIcon: Icon(
                            Icons.label,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressPhoneController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., +1234567890',
                          suffixIcon: Icon(
                            Icons.phone,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressCityController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'City',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., Fayoum',
                          suffixIcon: Icon(
                            Icons.location_city,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressDetailsController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Address Details',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., Street name, Building number',
                          suffixIcon: Icon(
                            Icons.location_on,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter address details';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressLatitudeController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., 29.30995',
                          suffixIcon: Icon(
                            Icons.map,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter latitude';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: addressLongitudeController,
                        style: TextStyle(
                          color: MyTheme.blackColor,
                          fontSize: 16.sp,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          labelStyle: TextStyle(
                            color: MyTheme.grayColor2,
                            fontSize: 14.sp,
                          ),
                          hintText: 'e.g., 30.84185',
                          suffixIcon: Icon(
                            Icons.map,
                            color: MyTheme.orangeColor,
                          ),
                          border: const UnderlineInputBorder(),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.grayColor),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: MyTheme.orangeColor, width: 2.0),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter longitude';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            context.read<AddressBloc>().add(
                                  EditAddressEvent(
                                    addressId: address.addressId ?? '0',
                                    name: addressTitleController.text,
                                    phone: addressPhoneController.text, // ضفنا phone
                                    city: addressCityController.text,
                                    street: addressDetailsController.text,
                                    lat: addressLatitudeController.text,
                                    long: addressLongitudeController.text,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyTheme.orangeColor,
                          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 3,
                        ),
                        child: Text(
                          'Update Address',
                          style: TextStyle(
                            color: MyTheme.whiteColor,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}