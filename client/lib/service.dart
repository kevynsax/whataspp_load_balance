import 'model/message.dart';

class Service{
  static Future<List<Message>> ListMessages() =>
      Future.delayed(const Duration(seconds: 30))
        .then((onValue) => <Message>[
          Message(
            id: '1441',
            text: 'Test 1 de envio de mensagem',
            phones: <String>[
              '+5561985891092', '+5561983273504', '+5561981123705'
            ],
            active: true
          ),
          Message(
            id: '1331',
            text: 'Test 2 de envio',
            phones: <String>[
              '+556181195356'
            ],
            active: true
          )
      ].toList());
}