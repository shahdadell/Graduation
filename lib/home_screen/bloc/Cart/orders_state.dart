import '../../data/model/orders_model_response/ArchiveResponse.dart';
import '../../data/model/orders_model_response/DeleteResponse.dart';
import '../../data/model/orders_model_response/PendingResponse.dart';

class OrdersState {}

class OrdersInitialState extends OrdersState {}

class FetchPendingOrdersLoadingState extends OrdersState {}

class FetchPendingOrdersSuccessState extends OrdersState {
  final PendingResponse pendingResponse;

  FetchPendingOrdersSuccessState({required this.pendingResponse});
}

class FetchPendingOrdersErrorState extends OrdersState {
  final String message;

  FetchPendingOrdersErrorState({required this.message});
}

class FetchArchivedOrdersLoadingState extends OrdersState {}

class FetchArchivedOrdersSuccessState extends OrdersState {
  final ArchiveResponse archiveResponse;

  FetchArchivedOrdersSuccessState({required this.archiveResponse});
}

class FetchArchivedOrdersErrorState extends OrdersState {
  final String message;

  FetchArchivedOrdersErrorState({required this.message});
}

class DeleteOrderLoadingState extends OrdersState {}

class DeleteOrderSuccessState extends OrdersState {
  final DeleteResponse deleteResponse;

  DeleteOrderSuccessState({required this.deleteResponse});
}

class DeleteOrderErrorState extends OrdersState {
  final String message;

  DeleteOrderErrorState({required this.message});
}