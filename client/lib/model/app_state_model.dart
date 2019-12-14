import 'package:flutter/foundation.dart';
import 'package:whatsapp_load_balance/model/message.dart';
import 'package:whatsapp_load_balance/service.dart';

class AppStateModel extends ChangeNotifier{
  List<Message> _messages = [];
  Message _selectedMessage;

  List<Message> getMessages() => _messages;

  void loadMessages(){
    Service.listMessages()
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
    selectMessage(Message(
      text: '',
      phones: <String>[],
      active: true,
      id: ''
    ));
  }

  void saveMessage(Message msg){
    final action = msg.id.length > 0
        ? Service.updateMessage
        : Service.insertMessage;

    action(msg)
      .then((val) => this.loadMessages());
  }

  void deleteMessage(){
    Service.deleteMessage(_selectedMessage.id)
        .then((val) => this.loadMessages());
  }
}