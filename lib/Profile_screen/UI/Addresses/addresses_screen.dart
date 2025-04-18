import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:graduation_project/Profile_screen/UI/Addresses/add_address_screen.dart';
import 'package:graduation_project/Profile_screen/UI/Addresses/edir_address_screen.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_bloc.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_event.dart';
import 'package:graduation_project/Profile_screen/bloc/Address/Address_state.dart';
import 'package:graduation_project/Theme/theme.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AddressBloc>().add(FetchAddressesEvent());

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
      body: BlocConsumer<AddressBloc, AddressState>(
        listener: (context, state) {
          if (state is AddAddressSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Address added successfully'),
                backgroundColor: MyTheme.greenColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is AddAddressErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error adding address: ${state.message}'),
                backgroundColor: MyTheme.redColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is DeleteAddressSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Address deleted successfully'),
                backgroundColor: MyTheme.greenColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is DeleteAddressErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error deleting address: ${state.message}'),
                backgroundColor: MyTheme.redColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is EditAddressSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Address updated successfully'),
                backgroundColor: MyTheme.greenColor,
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is EditAddressErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Error updating address: ${state.message}'),
                backgroundColor: MyTheme.redColor,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is FetchAddressesLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: MyTheme.orangeColor,
              ),
            );
          } else if (state is FetchAddressesSuccessState) {
            final addresses = state.viewAddresses.data ?? [];
            if (addresses.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/images/empty_addresses.json',
                      width: 200.w,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No Addresses Found',
                      style: MyTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        color: MyTheme.grayColor2,
                        fontSize: 20.sp,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Add a new address to get started!',
                      style: TextStyle(
                        color: MyTheme.grayColor,
                        fontSize: 16.sp,
                      ),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        MyTheme.whiteColor,
                        MyTheme.lowOpacity.withOpacity(0.1),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: MyTheme.grayColor3,
                        blurRadius: 8.r,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    leading: CircleAvatar(
                      radius: 24.r,
                      backgroundColor: MyTheme.orangeColor.withOpacity(0.1),
                      child: Icon(
                        Icons.location_on,
                        color: MyTheme.orangeColor,
                        size: 28.w,
                      ),
                    ),
                    title: Text(
                      address.addressName ?? 'No Name',
                      style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${address.addressStreet ?? ''}, ${address.addressCity ?? ''}\nPhone: ${address.addressPhone ?? 'No Phone'}',
                      style: TextStyle(
                        color: MyTheme.grayColor2,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: MyTheme.blueColor,
                            size: 24.w,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditAddressScreen(address: address),
                              ),
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: MyTheme.orangeColor,
                            size: 24.w,
                          ),
                          onPressed: () {
                            context.read<AddressBloc>().add(
                                  DeleteAddressEvent(addressId: address.addressId ?? ''),
                                );
                          },
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms, delay: (100 * index).ms).slideX(begin: -0.2);
              },
            );
          } else if (state is FetchAddressesErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/images/favouriteEmpty.json',
                    width: 200.w,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${state.message}',
                    style: TextStyle(
                      color: MyTheme.redColor,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddAddressScreen(),
            ),
          );
        },
        backgroundColor: Colors.transparent,
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [MyTheme.orangeColor, MyTheme.orangeColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: MyTheme.grayColor3,
                blurRadius: 8.r,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Icon(
              Icons.add,
              color: MyTheme.whiteColor,
              size: 30.w,
            ),
          ),
        ),
      ).animate().scale(duration: 500.ms, curve: Curves.easeInOut),
    );
  }
}