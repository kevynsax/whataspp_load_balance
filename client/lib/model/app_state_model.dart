import 'package:flutter/foundation.dart';
import 'package:whatsapp_load_balance/model/message.dart';
import 'package:whatsapp_load_balance/service.dart';

class AppStateModel extends ChangeNotifier{
  List<Message> _messages = [];
  Message _selectedMessage;

  List<Message> getMessages() => _messages;

  void loadMessages(){
    Service.ListMessages()
        .then((val){
          _messages = val;
          notifyListeners();
        });
  }

  Message get selectedMessage => _selectedMessage;

  void selectMessage(Message msg){
    _selectedMessage = msg;
    notifyListeners();
  }

  void newMessage(){
    selectMessage(Message());
  }
}