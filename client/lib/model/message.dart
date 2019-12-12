
import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Message{
  final String id;
  final String text;
  final List<String> phones;
  final bool active;

  Message({
    @required this.id,
    @required this.text,
    @required this.phones,
    @required this.active
  }): assert(text != null),
      assert(phones != null),
      assert(active != null);
  
  factory Message.fromJson(Map<String, dynamic> json) =>
      Message(
        id: json['_id'],
        text: json['text'],
        phones: List<String>.from(json['phones']),
        active: json['active'] == 'true'
      );

  String toJson() =>
      '{"_id": "$id", "text": "$text", "phones": ["${phones.join('", "')}"], "active": $active}';
}