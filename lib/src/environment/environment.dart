import 'package:flutter/foundation.dart';

class Environment {

  static const  String API_URL = kIsWeb //kIsWeb evaluamos si viene desde la web, existen kIsAndroid, kIsIOS.....
    ? "http://localhost:3000/" // navegador
    : "http://192.168.157.1:3000/"; // móvil


  static const  String API_URL_OLD = kIsWeb //kIsWeb evaluamos si viene desde la web, existen kIsAndroid, kIsIOS.....
  ? "localhost:3000" // navegador
  : "192.168.157.1:3000"; // móvil
    

}