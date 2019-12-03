import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_load_balance/edit_message.dart';
import 'package:whatsapp_load_balance/model/app_state_model.dart';
import 'package:whatsapp_load_balance/styles.dart';

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
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(message.text,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.messageRowItemName,
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(message.phones.join(', '),
                    overflow: TextOverflow.ellipsis,
                    style: Styles.messageRowItemPhones,
                  )
                ],
              ),
            ),
          ),
          CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.forward,
              semanticLabel: 'Open',
            ),
            onPressed: (){
              final model = Provider.of<AppStateModel>(context);
              model.selectMessage(message);
              Navigator.pushNamed(context, EditMessage.routeName)
            },
          )
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
            color: Styles.messageRowDivider,
          ),
        )
      ],
    );
  }
}
