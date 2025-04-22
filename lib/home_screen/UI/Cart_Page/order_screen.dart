import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/Theme/theme.dart';
import 'package:graduation_project/home_screen/data/model/orders_model_response/PendingResponse.dart';
import 'package:graduation_project/home_screen/data/repo/orders_repo.dart';
import 'package:graduation_project/local_data/shared_preference.dart';
import 'package:lottie/lottie.dart';
import '../../bloc/Cart/orders_bloc.dart';
import '../../bloc/Cart/orders_event.dart';
import '../../bloc/Cart/orders_state.dart';

class OrderScreen extends StatefulWidget {
  static const String routeName = 'order';
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final int? userId = AppLocalStorage.getData('user_id');
    if (userId == null) {
      return Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          color: MyTheme.whiteColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_rounded,
                  size: 80.w,
                  color: MyTheme.mauveColor.withOpacity(0.7),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Please log in to view your orders',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: MyTheme.mauveColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.4),
                  ),
                  child: Text(
                    'Login',
                    style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
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
      create: (context) {
        final bloc = OrdersBloc(ordersRepo: OrdersRepo());
        bloc.add(FetchPendingOrdersEvent(userId: userId));
        bloc.add(FetchArchivedOrdersEvent(userId: userId));
        return bloc;
      },
      child: BlocListener<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is DeleteOrderSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.check_circle_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Order deleted successfully'),
                  ],
                ),
                backgroundColor: MyTheme.greenColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          } else if (state is DeleteOrderErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Row(
                  children: [
                    Icon(Icons.error_rounded,
                        color: MyTheme.whiteColor, size: 16.w),
                    SizedBox(width: 8.w),
                    Text('Failed to delete order: ${state.message}'),
                  ],
                ),
                backgroundColor: MyTheme.redColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: Container(
            color: MyTheme.whiteColor,
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  TabBar(
                    labelColor: MyTheme.orangeColor,
                    unselectedLabelColor: MyTheme.grayColor2,
                    indicatorColor: MyTheme.orangeColor,
                    tabs: [
                      Tab(text: 'Pending'),
                      Tab(text: 'Archived'),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildPendingOrders(context, userId),
                        _buildArchivedOrders(context, userId),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Your Orders",
        style: MyTheme.lightTheme.textTheme.displayLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              color: MyTheme.grayColor3,
              blurRadius: 3.r,
              offset: Offset(1, 1),
            ),
          ],
        ),
      ),
      centerTitle: true,
      backgroundColor: MyTheme.orangeColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20.r),
        ),
      ),
    );
  }

  Widget _buildPendingOrders(BuildContext context, int userId) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is FetchPendingOrdersLoadingState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: MyTheme.orangeColor,
                  strokeWidth: 3.w,
                ),
                SizedBox(height: 15.h),
                Text(
                  'Loading your pending orders...',
                  style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontSize: 18.sp,
                    color: MyTheme.mauveColor,
                  ),
                ),
              ],
            ),
          );
        } else if (state is FetchPendingOrdersSuccessState) {
          final orders = state.pendingResponse.data ?? [];
          if (orders.isNotEmpty) {
            return _buildOrdersList(context, orders, userId, true);
          }
          return _buildEmptyOrders(context);
        } else if (state is FetchPendingOrdersErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 80.w,
                  color: MyTheme.redColor.withOpacity(0.7),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Error: ${state.message}',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    color: MyTheme.redColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrdersBloc>()
                        .add(FetchPendingOrdersEvent(userId: userId));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.4),
                  ),
                  child: Text(
                    'Retry',
                    style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: MyTheme.orangeColor,
                strokeWidth: 3.w,
              ),
              SizedBox(height: 15.h),
              Text(
                'Loading your pending orders...',
                style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontSize: 18.sp,
                  color: MyTheme.mauveColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildArchivedOrders(BuildContext context, int userId) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state is FetchArchivedOrdersLoadingState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: MyTheme.orangeColor,
                  strokeWidth: 3.w,
                ),
                SizedBox(height: 15.h),
                Text(
                  'Loading your archived orders...',
                  style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                    fontSize: 18.sp,
                    color: MyTheme.mauveColor,
                  ),
                ),
              ],
            ),
          );
        } else if (state is FetchArchivedOrdersSuccessState) {
          // الـ ArchiveResponse مش فيه بيانات طلبات، بس هنعرض رسالة إذا كان فيه فشل
          if (state.archiveResponse.status == 'success') {
            // لو كان فيه بيانات في المستقبل، هنحتاج نعدل الموديل عشان يدعم قايمة الطلبات
            return _buildEmptyOrders(context); // مؤقتًا لأن مفيش بيانات
          }
          return _buildEmptyOrders(context);
        } else if (state is FetchArchivedOrdersErrorState) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_rounded,
                  size: 80.w,
                  color: MyTheme.redColor.withOpacity(0.7),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Error: ${state.message}',
                  style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontSize: 18.sp,
                    color: MyTheme.redColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<OrdersBloc>()
                        .add(FetchArchivedOrdersEvent(userId: userId));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyTheme.orangeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 30.w, vertical: 12.h),
                    elevation: 5,
                    shadowColor: MyTheme.orangeColor.withOpacity(0.4),
                  ),
                  child: Text(
                    'Retry',
                    style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: MyTheme.orangeColor,
                strokeWidth: 3.w,
              ),
              SizedBox(height: 15.h),
              Text(
                'Loading your archived orders...',
                style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
                  fontSize: 18.sp,
                  color: MyTheme.mauveColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrdersList(
      BuildContext context, List<Data> orders, int userId, bool isPending) {
    return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return BlocConsumer<OrdersBloc, OrdersState>(
            listener: (context, state) {
              if (state is DeleteOrderSuccessState) {
                context
                    .read<OrdersBloc>()
                    .add(FetchPendingOrdersEvent(userId: userId));
                context
                    .read<OrdersBloc>()
                    .add(FetchArchivedOrdersEvent(userId: userId));
              }
            },
            builder: (context, state) {
              bool isLoading = state is DeleteOrderLoadingState;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 6.h),
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: MyTheme.whiteColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: MyTheme.grayColor.withOpacity(0.3),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: MyTheme.grayColor3.withOpacity(0.3),
                      blurRadius: 6.r,
                      spreadRadius: 1.r,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.receipt_long_rounded,
                      size: 60.w,
                      color: MyTheme.orangeColor,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order #${order.ordersId}',
                            style: MyTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: MyTheme.mauveColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            'Total: ${order.ordersTotalprice} EGP',
                            style: MyTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.greenColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Date: ${order.ordersDatetime}',
                            style: MyTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.grayColor2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Payment: ${order.ordersPaymentmethod == "0" ? "Cash" : "Payment Card"}',
                            style: MyTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.grayColor2,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Address: ${order.addressName}, ${order.addressStreet}, ${order.addressCity}',
                            style: MyTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              fontSize: 12.sp,
                              color: MyTheme.grayColor2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isPending)
                      GestureDetector(
                        onTap: isLoading
                            ? null
                            : () {
                          context.read<OrdersBloc>().add(DeleteOrderEvent(
                            userId: userId,
                            orderId: int.parse(order.ordersId!),
                          ));
                        },
                        child: Container(
                          padding: EdgeInsets.all(5.w),
                          decoration: BoxDecoration(
                            color: MyTheme.redColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: isLoading
                              ? SizedBox(
                            width: 18.w,
                            height: 18.w,
                            child: CircularProgressIndicator(
                              color: MyTheme.redColor,
                              strokeWidth: 2.w,
                            ),
                          )
                              : Icon(
                            Icons.delete_rounded,
                            size: 18.w,
                            color: MyTheme.redColor,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        },
    );
  }

  Widget _buildEmptyOrders(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/images/empty_orders.json', // استبدلي بمسار الـ animation المناسب
            width: 200.w,
            height: 200.h,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 20.h),
          Text(
            'No orders found',
            style: MyTheme.lightTheme.textTheme.titleMedium?.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: MyTheme.mauveColor,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Start shopping now!',
            style: MyTheme.lightTheme.textTheme.titleSmall?.copyWith(
              fontSize: 16.sp,
              color: MyTheme.grayColor2,
            ),
          ),
          SizedBox(height: 20.h),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                '/home', // استبدلي بالمسار الصحيح لصفحة التسوق
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: MyTheme.orangeColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 8.h),
              elevation: 5,
              shadowColor: MyTheme.orangeColor.withOpacity(0.4),
            ),
            child: Text(
              'Start Shopping',
              style: MyTheme.lightTheme.textTheme.displayMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}