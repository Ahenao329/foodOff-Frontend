// To parse this JSON data, do
//
//     final cliente = clienteFromJson(jsonString);

import 'dart:convert';

Cliente clienteFromJson(String str) => Cliente.fromJson(json.decode(str));

String clienteToJson(Cliente data) => json.encode(data.toJson());

class Cliente {
    String? id;
    String? nombre;
    int? celular;
    String? correo;
    String? password;
    String? foto;
    String? sessionToken;

    Cliente({
        this.id,
        this.nombre,
        this.celular,
        this.correo,
        this.password,
        this.foto,
        this.sessionToken,
    });

    factory Cliente.fromJson(Map<String, dynamic> json) => Cliente(
        id: json["id"],
        nombre: json["nombre"],
        celular: json["celular"],
        correo: json["correo"],
        password: json["password"],
        foto: json["foto"],
        sessionToken: json["sessionToken"].toString(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "celular": celular,
        "correo": correo,
        "password": password,
        "foto": foto,
        "sessionToken": sessionToken,
    };
}