import 'package:flutter/material.dart';
import 'package:food_off/src/models/user_cliente_.dart';
import 'package:food_off/src/pages/home/home_page.dart';
import 'package:food_off/src/pages/login/login_page.dart';
import 'package:food_off/src/pages/register/register_page.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// import 'package:get/get_navigation/get_navigation.dart';
  Cliente clienteSesion = Cliente.fromJson(GetStorage().read('user') ?? {});
void main() async {
  await GetStorage.init(); 
  runApp(const MyApp());
}


  class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      print('Usuario de sesión: ${clienteSesion.id}');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Off',
      initialRoute: clienteSesion.id != null ? '/home':'/', //todo: significa entonces
      getPages: [
        GetPage( name: '/', page: () =>  LoginPage() ),
        GetPage( name: '/register', page: () =>  RegisterPage() ),
        GetPage( name: '/home', page: () =>   HomePage() ),
      ],
 theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          primary: Colors.amber,
          secondary: Colors.amberAccent,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          onPrimary: Colors.grey,
          surface: Colors.amber,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          onSecondary: Colors.amber,
          background: Colors.white
        )
      ),
      navigatorKey: Get.key,
    );
  }
}