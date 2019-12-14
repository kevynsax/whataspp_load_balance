import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_load_balance_clinet/edit_message.dart';
import 'package:whatsapp_load_balance_clinet/message_row_item.dart';

import 'model/app_state_model.dart';

class ListMessages extends StatefulWidget {
  @override
  _ListMessagesState createState() => _ListMessagesState();
}

class _ListMessagesState extends State<ListMessages> {

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(
      builder: (context, model, child){
        final messages = model.getMessages();

        void newMessage(){
          model.newMessage();
          Navigator.pushNamed(context, EditMessage.routeName);
        }

        return CupertinoPageScaffold(
          child: CustomScrollView(
            semanticChildCount: messages.length,
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
                middle: Text('WhatsApp Balance'),
                largeTitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Messages'),
                    CupertinoButton(
                        child: const Icon(
                          CupertinoIcons.plus_circled,
                          semanticLabel: 'Add Message',
                        )
                        , onPressed: newMessage),
                  ],
                ),
              ),
              SliverSafeArea(
                top: false,
                minimum: const EdgeInsets.only(top: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (context, index){
                        if(index >= messages.length)
                          return null;

                        return MessageRowItem(
                          index: index,
                          message: messages[index],
                          lastItem: messages.length - 1 == index,
                        );
                      }
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}
