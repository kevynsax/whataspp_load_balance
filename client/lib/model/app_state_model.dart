import 'package:flutter/foundation.dart';
import 'package:whatsapp_load_balance/model/message.dart';
import 'package:whatsapp_load_balance/service.dart';

class AppStateModel extends ChangeNotifier{
  List<Message> _messages = [];

  List<Message> getMessages() => _messages;

  void loadMessages(){
    Service.ListMessages()
        .then((val){
          _messages = val;
          notifyListeners();
        });
  }
}