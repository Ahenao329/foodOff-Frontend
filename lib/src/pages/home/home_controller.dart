
import 'package:food_off/src/models/user_cliente_.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  
  Cliente user = Cliente.fromJson(GetStorage().read('user') ?? {});

  HomeController() {
    print('Usuario de sesión: ${user.toJson()}');
  }

  void signOut() {
    GetStorage().remove('user');
    Get.offNamedUntil('/', (route) => false);//Elimina el historial de pantallas, asi que no permitiria ir a atras
  }

  

}