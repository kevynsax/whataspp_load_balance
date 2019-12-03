import 'dart:convert';

import 'package:http/http.dart';

import 'model/message.dart';

const String baseUrl = 'https://kevyn.com.br/whats/message';

class Service{
  static Future<List<Message>> listMessages() =>
      get(baseUrl).then((r) =>
          (json.decode(r.body) as List).map((x) => Message.fromJson(x)).toList());
}