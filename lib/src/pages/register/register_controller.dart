

import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_off/src/models/response_api.dart';
import 'package:food_off/src/models/user_cliente_.dart';
import 'package:food_off/src/providers/users_clientes_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

class RegisterController extends GetxController {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  ClienteProvider clienteProvaider = ClienteProvider();

  final ImagePicker picker = ImagePicker();
  File? imageFile;

  void register() async {
    String correo = emailController.text.trim();
    String nombre = nameController.text.trim();
    // String lastName = lastNameController.text.trim();
    String phone = phoneController.text.trim();
    // int phone =  int.parse(phoneController.text.trim()); 
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if ( isValidForm(correo, nombre, int.parse(phone), password, confirmPassword) ) {
        
      Cliente cliente = Cliente(
        nombre: nombre,
        celular: int.parse(phone),
        correo: correo,
        password: password,
      );

      // Stream stream = await clienteProvaider.createWithImage(cliente, imageFile!);
      // ResponseApi response = await clienteProvaider.createUserWithImageGetX(cliente, imageFile!);
      Stream stream = await clienteProvaider.createUser(cliente, );

      stream.listen((res) {
        ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

        if(responseApi.ok == true) {
          GetStorage().write('cliente', responseApi.data); //Datos del usuario en sesion
          goToHomePage();
        }
        else {
          Get.snackbar('Registto fallido', responseApi.msg ?? 'lamentable');
        }
      });
    }
  }


  void goToHomePage() {
    Get.offNamedUntil('/home', (route) => false); // offName.. para que no pueda regresar, si regresa se sale de la app
  }

  bool isValidForm(
        String email, 
        String nombre, 
        int phone, 
        String password , 
        String confirmPassword
  ) {

    if(!GetUtils.isEmail(email)) {
      Get.snackbar('Formulario no válido', 'El email no es válido');
      return false;
    }

    if (email.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el email');
      return false;
    }

    if (nombre.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el nombre');
      return false;
    }

    // if (lastName.isEmpty) {
    //   Get.snackbar('Formulario no válido', 'Debes ingresar el apellido');
    //   return false;
    // }

    if (phone.isNaN) {
      Get.snackbar('Formulario no válido', 'Debes ingresar el número teléfonico');
      return false;
    }

    if (password.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar la contraseña');
      return false;
    }

    if (confirmPassword.isEmpty) {
      Get.snackbar('Formulario no válido', 'Debes ingresar la confirmación de la contraseña');
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar('Formulacio no válido', 'los password no coinciden');
      return false;
    }
 
    // if (imageFile == null) {
    //   Get.snackbar('Formulacio no válido', 'debes selecicnar una imagen de perfil');
    //   return false;
    // }

    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if(image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
 
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
      } , 
      child: const Text(
        'Galería',
        style: TextStyle(
        color: Colors.black
        ),
      )    
    );

    Widget cameraButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.camera);
      } , 
      child: const Text(
        'Cámara',
        style: TextStyle(
        color: Colors.black
        ),
      )    
    );

    AlertDialog alertDialog = AlertDialog(
      title: const Text('Selecciona una opción'),
      actions: [
        galleryButton,
        cameraButton
      ]
    );

    showDialog(context: context, builder: (BuildContext context) {
      return alertDialog;
    });
  }

}