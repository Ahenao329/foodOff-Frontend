
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

  Future<Response> create(Cliente cliente) async {
    Response response = await post(
       '$url/clientes',
       cliente.toJson(),

    );
    return response;
  }

  // create(Cliente cliente) async { //todo tambien funciona
  //   var response = await post(
  //      url,
  //      cliente.toJson(),
  //   );
  //   return response;
  // }

  Future<ResponseApi> login(String email, String password) async {
    Response response = await post(
       '$url/login/cliente',
        {
          'correo': email,
          'password': password
        }

    ); // espera a que el servidor nos retorne la respuesta

    if (response.body == null) {
      Get.snackbar('Error', 'No se pudo ejecutar la petición');
      return ResponseApi();
    }

    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    
    return responseApi;
  }



  Future<Stream> createWithImage(Cliente cliente, File image) async {
    Uri uri = Uri.http(Environment.API_URL_OLD, '/api/clientes/crearConImagen');
    final request = http.MultipartRequest('POST', uri);
    request.files.add(http.MultipartFile(
      'image',
      http.ByteStream(image.openRead().cast()),
      await image.length(),
      filename: basename(image.path)
    ));
    request.fields['user'] = json.encode(cliente);
    final response = await request.send();
    return response.stream.transform(utf8.decoder);
  }

  /*
  * GET X
   */
  Future<ResponseApi> createUserWithImageGetX(Cliente cliente, File image) async { //todo: con Get ex
    FormData form = FormData({
      'image': MultipartFile(image, filename: basename(image.path)),
      'user': json.encode(cliente)  /* * GET X */
    });
    Response response = await post('$url/clientes/createWithImage', form);

    if (response.body == null) {
      Get.snackbar('Error en la peticion', 'No se pudo crear el usuario');
      return ResponseApi();
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }



}