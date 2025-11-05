import 'package:dio/dio.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hellow_github/models/user_model.dart';
import 'package:hellow_github/services/api_service.dart';

class UserController extends GetxController{
  final ApiService api = ApiService();
  final user = Rxn<UserModel>();
  final loading = false.obs;
  final error = RxnString();

  Future<bool> fetchUser(String userName)async{
    loading.value = true;
    error.value = null;
    try {
      final response = await api.getUser(userName);
      user.value = UserModel.fromJson(response.data);
      return true;
    }on DioException catch (e) {
      if(e.response?.statusCode== 404){
        error.value = 'User not found';
      }else{
        error.value = e.message;
      }
      return false;
    } catch(e) {
      error.value = e.toString();
      return false;
    }finally{
      loading.value = false;
    }
  }
}