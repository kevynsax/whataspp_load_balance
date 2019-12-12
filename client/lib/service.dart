import 'dart:convert';
import 'package:http/http.dart';
import 'model/message.dart';

const String baseUrl = 'https://kevyn.com.br/whats/message';

const headers = <String, String>{
  "Content-Type": "application/json"
};
class Service{
  static Future<List<Message>> listMessages() =>
      get(baseUrl)
          .then((r) => (json.decode(r.body) as List)
            .map((x) => Message.fromJson(x)).toList());

  static Future<Message> updateMessage(Message msg) =>
      put('$baseUrl/${msg.id}', body: msg.toJson(), headers: headers)
        .then((r) => json.decode(r.body))
        .then((val) => Message.fromJson(val));
}