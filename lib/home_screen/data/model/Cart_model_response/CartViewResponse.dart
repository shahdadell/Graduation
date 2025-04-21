import 'datacart.dart';

/// status : "success"
/// rest_cafe : {"countprice":{"totalprice":"0","totalcount":"0"},"datacart":[]}
/// hotel_tourist : {"countprice":{"totalprice":"0","totalcount":"0"},"datacart":[]}
/// other_categories : {"25":{"cat_name":"Entertainment Centers","countprice":{"totalprice":400,"totalcount":4},"datacart":[{"cart_id":"417","cart_usersid":"828","cart_itemsid":"182","cart_orders":"0","cart_quantity":"4","items_name":"Car Game","items_price":"100","items_image":"https://abdulrahmanantar.com/outbye/upload/items/8862Funcity.jpg","items_cat":"25","items_discount":"10","categories_id":"25","categories_name":"Entertainment Centers","categories_name_ar":"مراكز ترفيهية","total_price":"400"}]}}

class CartViewResponse {
  CartViewResponse({
    this.status,
    this.restCafe,
    this.hotelTourist,
    this.otherCategories,
  });

  CartViewResponse.fromJson(dynamic json) {
    status = json['status'];
    restCafe =
        json['rest_cafe'] != null ? RestCafe.fromJson(json['rest_cafe']) : null;
    hotelTourist = json['hotel_tourist'] != null
        ? HotelTourist.fromJson(json['hotel_tourist'])
        : null;
    if (json['other_categories'] != null) {
      otherCategories = (json['other_categories'] as Map<String, dynamic>?)?.map(
        (key, value) => MapEntry(key, OtherCategory.fromJson(value)),
      );
    }
  }

  String? status;
  RestCafe? restCafe;
  HotelTourist? hotelTourist;
  Map<String, OtherCategory>? otherCategories;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (restCafe != null) {
      map['rest_cafe'] = restCafe?.toJson();
    }
    if (hotelTourist != null) {
      map['hotel_tourist'] = hotelTourist?.toJson();
    }
    if (otherCategories != null) {
      map['other_categories'] = otherCategories?.map(
        (key, value) => MapEntry(key, value.toJson()),
      );
    }
    return map;
  }
}

/// cat_name : "Entertainment Centers"
/// countprice : {"totalprice":400,"totalcount":4}
/// datacart : [{"cart_id":"417","cart_usersid":"828","cart_itemsid":"182","cart_orders":"0","cart_quantity":"4","items_name":"Car Game","items_price":"100","items_image":"https://abdulrahmanantar.com/outbye/upload/items/8862Funcity.jpg","items_cat":"25","items_discount":"10","categories_id":"25","categories_name":"Entertainment Centers","categories_name_ar":"مراكز ترفيهية","total_price":"400"}]

class OtherCategory {
  OtherCategory({
    this.catName,
    this.countprice,
    this.datacart,
  });

  OtherCategory.fromJson(dynamic json) {
    catName = json['cat_name'];
    countprice = json['countprice'] != null
        ? Countprice.fromJson(json['countprice'])
        : null;
    if (json['datacart'] != null) {
      datacart = [];
      json['datacart'].forEach((v) {
        datacart?.add(Datacart.fromJson(v));
      });
    }
  }

  String? catName;
  Countprice? countprice;
  List<Datacart>? datacart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cat_name'] = catName;
    if (countprice != null) {
      map['countprice'] = countprice?.toJson();
    }
    if (datacart != null) {
      map['datacart'] = datacart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// countprice : {"totalprice":"0","totalcount":"0"}
/// datacart : []

class HotelTourist {
  HotelTourist({
    this.countprice,
    this.datacart,
  });

  HotelTourist.fromJson(dynamic json) {
    countprice = json['countprice'] != null
        ? Countprice.fromJson(json['countprice'])
        : null;
    if (json['datacart'] != null) {
      datacart = [];
      json['datacart'].forEach((v) {
        datacart?.add(Datacart.fromJson(v));
      });
    }
  }

  Countprice? countprice;
  List<Datacart>? datacart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countprice != null) {
      map['countprice'] = countprice?.toJson();
    }
    if (datacart != null) {
      map['datacart'] = datacart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// totalprice : "0"
/// totalcount : "0"

class Countprice {
  Countprice({
    this.totalprice,
    this.totalcount,
  });

  Countprice.fromJson(dynamic json) {
    totalprice = json['totalprice']?.toString();
    totalcount = json['totalcount']?.toString();
  }

  String? totalprice;
  String? totalcount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalprice'] = totalprice;
    map['totalcount'] = totalcount;
    return map;
  }
}

/// countprice : {"totalprice":"0","totalcount":"0"}
/// datacart : []

class RestCafe {
  RestCafe({
    this.countprice,
    this.datacart,
  });

  RestCafe.fromJson(dynamic json) {
    countprice = json['countprice'] != null
        ? Countprice.fromJson(json['countprice'])
        : null;
    if (json['datacart'] != null) {
      datacart = [];
      json['datacart'].forEach((v) {
        datacart?.add(Datacart.fromJson(v));
      });
    }
  }

  Countprice? countprice;
  List<Datacart>? datacart;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (countprice != null) {
      map['countprice'] = countprice?.toJson();
    }
    if (datacart != null) {
      map['datacart'] = datacart?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}