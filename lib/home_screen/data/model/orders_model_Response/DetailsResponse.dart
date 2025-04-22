/// status : "failure"

class DetailsResponse {
  DetailsResponse({
      this.status,});

  DetailsResponse.fromJson(dynamic json) {
    status = json['status'];
  }
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    return map;
  }

}