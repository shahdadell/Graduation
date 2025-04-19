// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:graduation_project/API_Services/dio_provider.dart';
// import 'package:graduation_project/API_Services/endpoints.dart';
// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/add_to_favourite.dart';
// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/favourite_view_response.dart';
// import 'package:graduation_project/home_screen/data/model/Favourite_model_response/remove_from_favourite.dart';

// class FavouriteRepository {
//   Future<AddToFavourite> addToFavourite(int itemId, int userId) async {
//     try {
//       const String endpoint = AppEndpoints.addToFavourite;
//       final FormData formData = FormData.fromMap({
//         'itemsid': itemId.toString(),
//         'usersid': userId.toString(),
//       });
//       log('Add to Favourite Request: $formData');
//       final response = await DioProvider.post(
//         endpoint: endpoint,
//         data: formData,
//         contentType: 'multipart/form-data', // زي الكوليكشن
//       );
//       log('Add to Favourite Response: ${response.data}');
//       if (response.statusCode == 200) {
//         if (response.data == null) {
//           throw Exception('Response data is null');
//         }
//         return AddToFavourite.fromJson(response.data);
//       }
//       throw Exception('Failed to add item to favourite - Status: ${response.statusCode}');
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timeout while adding to favourite');
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception('Receive timeout while adding to favourite');
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw Exception('Connection error: Please check your internet connection');
//       } else {
//         throw Exception('Error adding to favourite: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('Error adding to favourite: $e');
//     }
//   }

//   Future<RemoveFromFavourite> removeFromFavourite(int itemId, int userId) async {
//     try {
//       const String endpoint =  AppEndpoints.removeFavourite;
//       final FormData formData = FormData.fromMap({
//         'itemsid': itemId.toString(),
//         'usersid': userId.toString(),
//       });
//       log('Remove from Favourite Request: $formData');
//       final response = await DioProvider.post(
//         endpoint: endpoint,
//         data: formData,
//         contentType: 'multipart/form-data',
//       );
//       log('Remove from Favourite Response: ${response.data}');
//       if (response.statusCode == 200) {
//         if (response.data == null) {
//           throw Exception('Response data is null');
//         }
//         return RemoveFromFavourite.fromJson(response.data);
//       }
//       throw Exception('Failed to remove item from favourite - Status: ${response.statusCode}');
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timeout while removing from favourite');
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception('Receive timeout while removing from favourite');
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw Exception('Connection error: Please check your internet connection');
//       } else {
//         throw Exception('Error removing from favourite: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('Error removing from favourite: $e');
//     }
//   }

//   Future<FavouriteViewResponse> fetchFavourites(int userId) async {
//     try {
//       const String endpoint =  AppEndpoints.viewFavourite;
//       final FormData formData = FormData.fromMap({
//         'id': userId.toString(),
//       });
//       log('Fetch Favourite Request: $formData');
//       final response = await DioProvider.post(
//         endpoint: endpoint,
//         data: formData,
//         contentType: 'multipart/form-data',
//       );
//       log('Fetch Favourite Response: ${response.data}');
//       if (response.statusCode == 200) {
//         if (response.data == null) {
//           throw Exception('Response data is null');
//         }
//         return FavouriteViewResponse.fromJson(response.data);
//       }
//       throw Exception('Failed to fetch favourites - Status: ${response.statusCode}');
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timeout while fetching favourites');
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception('Receive timeout while fetching favourites');
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw Exception('Connection error: Please check your internet connection');
//       } else {
//         throw Exception('Error fetching favourites: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('Error fetching favourites: $e');
//     }
//   }

//   Future<RemoveFromFavourite> deleteFromFavourite(int favouriteId) async {
//     try {
//       const String endpoint = AppEndpoints.removeFavourite;
//       final FormData formData = FormData.fromMap({
//         'id': favouriteId.toString(),
//       });
//       log('Delete from Favourite Request: $formData');
//       final response = await DioProvider.post(
//         endpoint: endpoint,
//         data: formData,
//         contentType: 'multipart/form-data',
//       );
//       log('Delete from Favourite Response: ${response.data}');
//       if (response.statusCode == 200) {
//         if (response.data == null) {
//           throw Exception('Response data is null');
//         }
//         return RemoveFromFavourite.fromJson(response.data);
//       }
//       throw Exception('Failed to delete from favourite - Status: ${response.statusCode}');
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout) {
//         throw Exception('Connection timeout while deleting from favourite');
//       } else if (e.type == DioExceptionType.receiveTimeout) {
//         throw Exception('Receive timeout while deleting from favourite');
//       } else if (e.type == DioExceptionType.badResponse) {
//         throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
//       } else if (e.type == DioExceptionType.connectionError) {
//         throw Exception('Connection error: Please check your internet connection');
//       } else {
//         throw Exception('Error deleting from favourite: ${e.message}');
//       }
//     } catch (e) {
//       throw Exception('Error deleting from favourite: $e');
//     }
//   }
// }
