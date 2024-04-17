import 'dart:convert';

ResponseApi responseApiFromJson(String str) => ResponseApi.fromJson(json.decode(str));

String responseApiToJson(ResponseApi data) => json.encode(data.toJson());

class ResponseApi {
    bool? ok;
    String? msg;
    String? token;
    dynamic data;

    ResponseApi({
        this.ok,
        this.msg,
        this.data,
        this.token,
    });

    factory ResponseApi.fromJson(Map<String, dynamic> json) => ResponseApi(
        ok: json["ok"],
        msg: json["msg"],
        data: json["data"],
        token: json["token"],
    );

    Map<String, dynamic> toJson() => {
        "ok": ok,
        "msg": msg,
        "data": data,
        "token": token,
    };
}
