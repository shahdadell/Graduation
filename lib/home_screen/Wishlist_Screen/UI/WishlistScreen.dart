import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteBloc.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteEvent.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/bloc/FavoriteState.dart';
import 'package:graduation_project/home_screen/Wishlist_Screen/data/repo/FavoriteRepo.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:lottie/lottie.dart';

class WishlistScreen extends StatelessWidget {
  static const String routeName = '/wishlist';
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId == null) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/images/favouriteEmpty.json',
                  width: 200.w,
                  height: 200.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 20.h),
                Text(
                  'Please log in to view your favorites',
                  style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    "Go to Login",
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocProvider(
      create: (context) => FavoriteBloc(favoriteRepo: FavoriteRepo())
        ..add(FetchFavoriteEvent(userId: userId)),
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[100]!, Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is FetchFavoriteLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is FetchFavoriteSuccessState) {
                final favorites = state.favoriteViewResponse.data ?? [];
                if (favorites.isEmpty) {
                  return _buildEmptyFavorites(context);
                }
                return ListView.builder(
                  padding: EdgeInsets.all(16.w),
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    final item = favorites[index];
                    return Card(
                      elevation: 2,
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12.w),
                        leading: item.itemsImage != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8.r),
                                child: Image.network(
                                  item.itemsImage!,
                                  width: 60.w,
                                  height: 60.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(Icons.error),
                                ),
                              )
                            : const Icon(Icons.image_not_supported),
                        title: Text(
                          item.itemsName ?? 'No Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Price: ${item.itemsPrice ?? '0'}',
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: MyTheme.orangeColor),
                          onPressed: () {
                            context.read<FavoriteBloc>().add(
                                  DeleteFavoriteItemEvent(
                                    userId: userId,
                                    itemId: int.parse(item.itemsId ?? '0'),
                                  ),
                                );
                          },
                        ),
                      ),
                    );
                  },
                );
              } else if (state is FetchFavoriteErrorState) {
                return Center(child: Text('Error: ${state.message}'));
              }
              return _buildEmptyFavorites(context);
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Favorites",
        style: TextStyle(
          fontSize: 22.sp,
          color: MyTheme.whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.3),
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [MyTheme.orangeColor, Colors.orange[400]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyFavorites(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/favouriteEmpty.json',
            width: 200.w,
            height: 200.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),
          Text(
            'Your favorites list is empty',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start adding items now!',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}