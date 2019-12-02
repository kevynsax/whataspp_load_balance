import 'package:flutter/cupertino.dart';

import 'model/message.dart';

class ListMessages extends StatefulWidget {
  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {
  List<Message> msgs;

  

  @override
  Widget build(BuildContext context) {
    return CustomScrollView();
  }
}
