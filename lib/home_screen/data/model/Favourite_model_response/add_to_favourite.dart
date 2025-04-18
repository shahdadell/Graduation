class AddToFavourite {
  String? status;
  String? message;

  AddToFavourite({this.status, this.message});

  factory AddToFavourite.fromJson(Map<String, dynamic> json) {
    return AddToFavourite(
      status: json['status'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
      };
}
