import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hellow_github/controllers/theme_controller.dart';
import 'package:get/get.dart';
import 'package:hellow_github/controllers/user_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final themeController = Get.find<ThemeController>();
  final UserController userController= Get.put(UserController());
  final TextEditingController _controller = TextEditingController();

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
        child: Padding(padding: EdgeInsets.all(12),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Github username',
                border: OutlineInputBorder()
              ),
            ),
            ElevatedButton(onPressed: ()async{
              final username = _controller.text.trim();
              if(username.isEmpty){
                Get.snackbar('Error', 'Please enter a username');
                return;
              }
              final isUserExist = await userController.fetchUser(username);
              if(isUserExist){
                print('user ==== $isUserExist');
                //Get.to(() => HomeScreen())
              }else{
                Get.snackbar('Error', userController.error.value?? 'Unknown error');
              }
            }, 
            child: Text('Search'))
          ],
        ),
        ),
      ),
    );
  }
}