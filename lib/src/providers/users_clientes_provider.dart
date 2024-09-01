import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path/path.dart';
import 'package:food_off/src/environment/environment.dart';
import 'package:food_off/src/models/response_api.dart';
import 'package:food_off/src/models/user_cliente_.dart';
import 'package:get/get.dart';

class ClienteProvider extends GetConnect {

  String url = '${Environment.API_URL}api';


  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
       '$url/login/cliente',
        {
          'correo': email,
          'password': password
        }
    ); 

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    
    return responseApi;
  }

  Future<Stream> createUser(Cliente cliente) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/clientes');
    final request = http.Request('POST', uri);

    request.headers['Content-Type'] = 'application/json';
    request.body = json.encode(cliente.toJson());

    // print('Enviando cliente: ${json.encode(cliente.toJson())}');

    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  Future<Stream> createWithImage(Cliente cliente, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/clientes/creeearConImagen');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['cliente'] = json.encode(cliente);

    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
  //  */
  Future<ResponseApi> createUserWithImageGetX(Cliente cliente, File image) async { //todo: con Get ex
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'cliente': json.encode(cliente)  /* * GET X */
    });
    Response response = await post('$url/clientes/crearConImagen', form);

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

}