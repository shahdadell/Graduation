class FavouriteViewResponse {
  String? status;
  String? message;
  List<FavouriteItem>? favourites;

  FavouriteViewResponse({this.status, this.message, this.favourites});

  factory FavouriteViewResponse.fromJson(Map<String, dynamic> json) {
    return FavouriteViewResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      favourites: (json['favourites'] as List<dynamic>?)
          ?.map((item) => FavouriteItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'favourites': favourites?.map((item) => item.toJson()).toList(),
      };
}

class FavouriteItem {
  int? id;
  int? itemId;
  int? userId;
  String? itemName;
  double? itemPrice;
  String? itemImage;

  FavouriteItem({
    this.id,
    this.itemId,
    this.userId,
    this.itemName,
    this.itemPrice,
    this.itemImage,
  });

  factory FavouriteItem.fromJson(Map<String, dynamic> json) {
    return FavouriteItem(
      id: json['id'] as int?,
      itemId: json['item_id'] as int?,
      userId: json['user_id'] as int?,
      itemName: json['item_name'] as String?,
      itemPrice: (json['item_price'] as num?)?.toDouble(),
      itemImage: json['item_image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'item_id': itemId,
        'user_id': userId,
        'item_name': itemName,
        'item_price': itemPrice,
        'item_image': itemImage,
      };
}
