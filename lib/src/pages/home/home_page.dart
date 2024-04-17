import 'package:flutter/material.dart';
import 'package:food_off/src/pages/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {

  HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () => controller.signOut(),
          child: const Text(
            'Cerrar sesión',
            style: TextStyle(
              color: Colors.black            
              ),
          ),
        ),
      ),
    );
  }
}