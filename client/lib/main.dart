import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_load_balance/list_messages.dart';
import 'package:whatsapp_load_balance/model/app_state_model.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(ChangeNotifierProvider(
    child: WhatsAppLoadBalance(),
    builder: (_) => AppStateModel()..loadMessages(),
  ));
}

class WhatsAppLoadBalance extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: App()
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListMessages(),
    );
  }
}