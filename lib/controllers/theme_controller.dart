import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController{
  final _box = GetStorage();
  final themeMode = ThemeMode.system.obs;
  final _key = 'isDark';

  @override
  void onInit() {
    bool? isDark = _box.read(_key);
    if(isDark != null){
      themeMode.value = isDark? ThemeMode.dark : ThemeMode.light;
    }
    super.onInit();
  }

  void toggleTheme(){
    if(themeMode.value == ThemeMode.dark){
      themeMode.value = ThemeMode.light;
      _box.write(_key, false);
    }else{
      themeMode.value = ThemeMode.dark;
      _box.write(_key, true);
    }
  }
}