import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'model/message.dart';

class MessageRowItem extends StatelessWidget {
  final Message message;
  final int index;
  final bool lastItem;

  MessageRowItem({
    @required this.message,
    @required this.index,
    @required this.lastItem
  });

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
      top: false,
      bottom: false,
      minimum: EdgeInsets.only(
        left: 16,
        top: 8,
        right: 8,
        bottom: 8
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Text(message.text),
                  Text(message.phones.join(', '))
                ],
              ),
            ),
          ),
        ],
      ),
    );

    if(lastItem)
      return row;

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            height: 1,
            color: Color(0xFFD9D9D9),
          ),
        )
      ],
    );
  }
}
