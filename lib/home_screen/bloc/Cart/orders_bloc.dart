import 'package:bloc/bloc.dart';
import 'package:graduation_project/home_screen/data/repo/orders_repo.dart';
import 'orders_event.dart';
import 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrdersRepo ordersRepo;

  OrdersBloc({required this.ordersRepo}) : super(OrdersInitialState()) {
    on<FetchPendingOrdersEvent>(_onFetchPendingOrders);
    on<FetchArchivedOrdersEvent>(_onFetchArchivedOrders);
    on<DeleteOrderEvent>(_onDeleteOrder);
  }

  Future<void> _onFetchPendingOrders(
      FetchPendingOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(FetchPendingOrdersLoadingState());
    try {
      final response = await OrdersRepo.fetchPendingOrders(userId: event.userId);
      emit(FetchPendingOrdersSuccessState(pendingResponse: response));
    } catch (e) {
      emit(FetchPendingOrdersErrorState(message: e.toString()));
    }
  }

  Future<void> _onFetchArchivedOrders(
      FetchArchivedOrdersEvent event, Emitter<OrdersState> emit) async {
    emit(FetchArchivedOrdersLoadingState());
    try {
      final response = await OrdersRepo.fetchArchivedOrders(userId: event.userId);
      emit(FetchArchivedOrdersSuccessState(archiveResponse: response));
    } catch (e) {
      emit(FetchArchivedOrdersErrorState(message: e.toString()));
    }
  }

  Future<void> _onDeleteOrder(
      DeleteOrderEvent event, Emitter<OrdersState> emit) async {
    emit(DeleteOrderLoadingState());
    try {
      final response = await OrdersRepo.deleteOrder(
        userId: event.userId,
        orderId: event.orderId,
      );
      emit(DeleteOrderSuccessState(deleteResponse: response));
      // بعد الحذف، نعيد جلب الطلبات
      add(FetchPendingOrdersEvent(userId: event.userId));
      add(FetchArchivedOrdersEvent(userId: event.userId));
    } catch (e) {
      emit(DeleteOrderErrorState(message: e.toString()));
    }
  }
}