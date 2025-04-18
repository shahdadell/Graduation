import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Theme/theme.dart';

class AddAddressScreen extends StatelessWidget {
  const AddAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final addressTitleController = TextEditingController();
    final addressPhoneController = TextEditingController(); // جديد: حقل التليفون
    final addressDetailsController = TextEditingController();
    final addressCityController = TextEditingController();
    String latitude = '';
    String longitude = '';

    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) {
        if (state is AddAddressSuccessState) {
          Navigator.pop(context);
        } else if (state is AddAddressErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error adding address: ${state.message}'),
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
          "My Addresses",
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
            child: Column(
              children: [
                Card(
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
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Address Title',
                              labelStyle: TextStyle(
                                color: MyTheme.grayColor2,
                                fontSize: 14,
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
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: TextStyle(
                                color: MyTheme.grayColor2,
                                fontSize: 14,
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
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: 'City',
                              labelStyle: TextStyle(
                                color: MyTheme.grayColor2,
                                fontSize: 14,
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
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              labelText: 'Address Details',
                              labelStyle: TextStyle(
                                color: MyTheme.grayColor2,
                                fontSize: 14,
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
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    latitude = '0';
                    longitude = '0';
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Location selected: Lat: $latitude, Long: $longitude'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.map,
                    color: MyTheme.whiteColor,
                  ),
                  label: Text(
                    'Select Location',
                    style: TextStyle(
                      color: MyTheme.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      if (latitude.isEmpty || longitude.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select a location'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                        return;
                      }
                      context.read<AddressBloc>().add(
                            AddAddressEvent(
                              addressName: addressTitleController.text,
                              addressPhone: addressPhoneController.text, // ضفنا addressPhone
                              addressCity: addressCityController.text,
                              addressStreet: addressDetailsController.text,
                              addressLat: latitude,
                              addressLong: longitude,
                            ),
                          );
                    }
                  },
                  child: Text(
                    'Add Address',
                    style: TextStyle(
                      color: MyTheme.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}