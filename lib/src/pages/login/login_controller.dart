import 'package:flutter/material.dart';
import 'package:food_off/src/models/response_api.dart';
import 'package:food_off/src/providers/users_clientes_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ClienteProvider clienteProvaider = ClienteProvider();

  void goToRegisterPage() {
    Get.toNamed('/register');
  }

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (isValidForm(email, password)) {
      try {
        ResponseApi responseApi = await clienteProvaider.login(email, password);

        print('Response Api ${responseApi.toJson()}');

        if (responseApi.ok == true) {
          GetStorage().write('user', responseApi.data); // Guardar datos del usuario en sesión
          goToHomePage();
        } else {
          Get.snackbar('Login inválido', responseApi.msg ?? 'Error desconocido');
        }
      } catch (e) {
        Get.snackbar('Error', 'No se pudo conectar al servidor. Inténtalo de nuevo.');
      }
    }
  }


  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false); // offName.. para que no pueda regresar, si regresa se sale de la app
  }

  bool isValidForm(String email, String password) {

    if(!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no valido', 'El email no es valido');
      return false;
    }

    if (email.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el email');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no valido', 'Debes ingresar el password');
      return false;
    }
    return true;
  }

}