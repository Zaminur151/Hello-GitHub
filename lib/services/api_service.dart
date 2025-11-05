import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;
  ApiService._internal(this._dio);

  factory ApiService(){
    final dio = Dio(BaseOptions(
      baseUrl: 'https://api.github.com',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10)
    ));
    return ApiService._internal(dio);
  }
  Future getUser(String userName) async{
    return _dio.get('/users/$userName');
  }
}
