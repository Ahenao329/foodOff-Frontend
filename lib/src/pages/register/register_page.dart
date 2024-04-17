
import 'package:flutter/material.dart';
import 'package:food_off/src/pages/register/register_controller.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {

  RegisterController registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack( // posicionar elementos uno encima del otro
        children: [
          _backgroundCover(context),
          _boxForm(context),
          _imageUser(context),
          _buttonBack()
        ],
      ),
    );
  }

  Widget _buttonBack() {
    return SafeArea(
      child: Container(
          margin: const EdgeInsets.only(left: 20),
        alignment: Alignment.topLeft, 
        child: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _backgroundCover(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      color: Colors.amber,
    ); 
  }

    Widget _boxForm(BuildContext context) {
    return Container( 
      height: MediaQuery.of(context).size.height * 0.65,
      margin: EdgeInsets.only( top: MediaQuery.of(context).size.height * 0.3, left: 50, right: 50 ),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black54,
            blurRadius: 15,
            offset: Offset(0, 0.75)
          )
        ]
      ),
      child:  SingleChildScrollView(
        child: Column(
          children: [
            _textYourInfo(),
            _textFieldEmail(),
            _textFieldName(),
            _textFieldLastName(),
            _textFieldPhone(),
            _textFieldPassword(),
            _textFieldConfirmPassword(),
            _buttonRegister()
            
          ],
        ),
      ),
    );
  }

  Widget _imageUser(BuildContext context) {
    return SafeArea( //Para que se adapte y no se sobreponga a las herramientas del celular donde muestra la bateria...
      child: Container(
        margin: const EdgeInsets.only(top: 25),
          alignment: Alignment.topCenter,
          child: GestureDetector(
            onTap: () => registerController.showAlertDialog(context),
            child:  GetBuilder<RegisterController>(
              builder: (value) => CircleAvatar(
              backgroundImage: registerController.imageFile != null 
              ? FileImage(registerController.imageFile!)
              : const AssetImage('assets/img/user_profile.png') as ImageProvider,
              radius: 60,
              backgroundColor: Colors.white,
            ),
            )
          ),
      ),
    );
  }

  Widget _textYourInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: const Text(
        'Ingresa esta información',
        style: TextStyle(
          color: Colors.black
        ),
      ),
    );
  }

  Widget _textFieldEmail() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Correo electronico',
          prefixIcon: Icon(Icons.email)
        ),
      ),
    );
  }

  Widget _textFieldName() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.nameController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Nombre',
          prefixIcon: Icon(Icons.person)
        ),
      ),
    );
  }

  Widget _textFieldLastName() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.lastNameController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          hintText: 'Apellido',
          prefixIcon: Icon(Icons.person_outline)
        ),
      ),
    );
  }

  Widget _textFieldPhone() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.phoneController,
        keyboardType: TextInputType.phone,
        decoration: const InputDecoration(
          hintText: 'Teléfono',
          prefixIcon: Icon(Icons.phone)
        ),
      ),
    );
  }

  Widget _textFieldPassword() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Contraseña',
          prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget _textFieldConfirmPassword() {
    return  Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      child:  TextField(
        controller: registerController.confirmPasswordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: 'Confirmar contraseña',
          prefixIcon: Icon(Icons.lock)
        ),
      ),
    );
  }

  Widget  _buttonRegister() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      child: ElevatedButton(
        onPressed: () => registerController.register(), 
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15)
        ),
        child: const Text(
          'Registrarse',
          style: TextStyle(
            color: Colors.black
          ),
        )
      ),
    );
  }


}