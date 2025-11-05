import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hellow_github/controllers/theme_controller.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx((){
            return IconButton(
              onPressed: () => themeController.toggleTheme(), 
              icon: Icon(themeController.themeMode.value == ThemeMode.dark? Icons.wb_sunny : Icons.nights_stay)
              );
          })
        ],
      ),
      body: Center(
        
      ),
    );
  }
}