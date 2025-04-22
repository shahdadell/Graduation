import 'package:dio/dio.dart';
import 'package:graduation_project/API_Services/dio_provider.dart';
import '../model/orders_model_response/ArchiveResponse.dart';
import '../model/orders_model_response/DeleteResponse.dart';
import '../model/orders_model_response/PendingResponse.dart';

class OrdersRepo {
  // جلب الطلبات الجارية (pending)
  static Future<PendingResponse> fetchPendingOrders({
    required int userId,
  }) async {
    try {
      const String endpoint = 'https://abdulra7manar.com/outbye/orders/pending.php';
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
      });
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return PendingResponse.fromJson(response.data);
      }
      throw Exception('Failed to fetch pending orders - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching pending orders');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching pending orders');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection error: Please check your internet connection');
      } else {
        throw Exception('Error fetching pending orders: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching pending orders: $e');
    }
  }

  // جلب الطلبات المؤرشفة (archive)
  static Future<ArchiveResponse> fetchArchivedOrders({
    required int userId,
  }) async {
    try {
      const String endpoint = 'https://abdulra7manar.com/outbye/orders/archive.php';
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
      });
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return ArchiveResponse.fromJson(response.data);
      }
      throw Exception('Failed to fetch archived orders - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while fetching archived orders');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while fetching archived orders');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection error: Please check your internet connection');
      } else {
        throw Exception('Error fetching archived orders: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error fetching archived orders: $e');
    }
  }

  // حذف طلب
  static Future<DeleteResponse> deleteOrder({
    required int userId,
    required int orderId,
  }) async {
    try {
      const String endpoint = 'https://abdulra7manar.com/outbye/orders/delete.php';
      final FormData formData = FormData.fromMap({
        'usersid': userId.toString(),
        'ordersid': orderId.toString(),
      });
      final response = await DioProvider.post(
        endpoint: endpoint,
        data: formData,
      );
      if (response.statusCode == 200) {
        if (response.data == null) {
          throw Exception('Response data is null');
        }
        return DeleteResponse.fromJson(response.data);
      }
      throw Exception('Failed to delete order - Status: ${response.statusCode}');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        throw Exception('Connection timeout while deleting order');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        throw Exception('Receive timeout while deleting order');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Bad response: ${e.response?.statusCode} - ${e.response?.data}');
      } else if (e.type == DioExceptionType.connectionError) {
        throw Exception('Connection error: Please check your internet connection');
      } else {
        throw Exception('Error deleting order: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error deleting order: $e');
    }
  }
}