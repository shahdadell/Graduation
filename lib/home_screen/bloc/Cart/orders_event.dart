class OrdersEvent {}

class FetchPendingOrdersEvent extends OrdersEvent {
  final int userId;

  FetchPendingOrdersEvent({required this.userId});
}

class FetchArchivedOrdersEvent extends OrdersEvent {
  final int userId;

  FetchArchivedOrdersEvent({required this.userId});
}

class DeleteOrderEvent extends OrdersEvent {
  final int userId;
  final int orderId;

  DeleteOrderEvent({required this.userId, required this.orderId});
}