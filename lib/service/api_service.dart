import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ApiService extends GetxController {
  final dio.Dio _dio = dio.Dio(
    dio.BaseOptions(
      baseUrl: 'https://staging3.hashfame.com/api/v1',
      connectTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 30000),
    ),
  );
  final isLoading = false.obs;
  final Map<String, Timer> _debounceTimers = {}; // Store timers by path+method

  ApiService() {
    _dio.interceptors.add(
      dio.InterceptorsWrapper(
        onRequest: (options, handler) async {
          return handler.next(options);
        },
        onError: (dio.DioException error, handler) {
          _handleError(error);
          return handler.next(error);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
      ),
    );
  }

  dio.Dio get dioInstance => _dio;

  Future<T?> apiRequest<T>({
    required String path,
    required T Function(Map<String, dynamic>)
        fromJson, // Pass the fromJson method
    String method = 'GET',
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    bool isDebounce = true, // Enable debounce by default
    Duration debounceDuration = const Duration(milliseconds: 500),
  }) async {
    if (method.toUpperCase() == 'GET' && body != null) {
      throw ArgumentError('GET requests should not contain a request body.');
    }

    final requestKey = '$method:$path';

    if (isDebounce) {
      if (_debounceTimers[requestKey]?.isActive ?? false) {
        return null; // Skip duplicate request
      }
      _debounceTimers[requestKey] = Timer(debounceDuration, () {});
    }

    try {
      final response = await _dio.request(
        path,
        data: (method.toUpperCase() != 'GET') ? body : null,
        queryParameters: queryParams,
        options: dio.Options(
          method: method,
          headers: headers,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          try {
            return fromJson(response.data); // Call the passed fromJson function
          } catch (e) {
            printError(info: 'API-$path -- $e');
          }
        } else {
          throw Exception("Invalid response format from $path");
        }
      }
      return null;
    } catch (error) {
      if (error is dio.DioException) {
        _handleError(error);
      }
      return null;
    }
  }

 
  void _handleError(dio.DioException error) {
    String message;

    if (error.response != null && error.response?.data != null) {
      final dynamic errorData = error.response?.data;
      if (errorData is Map<String, dynamic> &&
          errorData.containsKey('message')) {
        message = errorData['message'];
      } else {
        switch (error.response?.statusCode) {
          case 400:
            message = "Bad request. Please check your input.";
            break;
          case 401:
            message = "Unauthorized. Please login again.";
            break;
          case 403:
            message = "Forbidden. You don't have permission.";
            break;
          case 404:
            message = "Not found. Please check the URL.";
            break;
          case 422:
            message = error.response?.data["error"] ?? "Validation Error";
            break;
          case 500:
            message = "Internal server error. Please try again later.";
            break;
          default:
            message = "Unexpected error occurred.";
            break;
        }
      }
    } else {
      if (error.type == dio.DioExceptionType.connectionTimeout) {
        message = "Connection timeout. Please try again.";
      } else if (error.type == dio.DioExceptionType.receiveTimeout) {
        message = "Receive timeout. Please try again.";
      } else if (error.type == dio.DioExceptionType.sendTimeout) {
        message = "Send timeout. Please try again.";
      } else if (error.type == dio.DioExceptionType.cancel) {
        message = "Request was cancelled.";
      } else {
        message = "An unexpected error occurred.";
      }
    }
    Fluttertoast.showToast(msg: message);
  }
}