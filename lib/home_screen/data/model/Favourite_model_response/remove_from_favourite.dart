class RemoveFromFavourite {
  String? status;

  RemoveFromFavourite({this.status});

  factory RemoveFromFavourite.fromJson(Map<String, dynamic> json) {
    return RemoveFromFavourite(
      status: json['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
      };
}
