import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_load_balance_clinet/model/app_state_model.dart';
import 'package:whatsapp_load_balance_clinet/model/message.dart';
import 'package:whatsapp_load_balance_clinet/phone_field.dart';
import 'package:whatsapp_load_balance_clinet/service.dart';

class EditMessage extends StatefulWidget {
  static String routeName = 'message/edit';

  @override
  _EditMessageState createState() => _EditMessageState();
}

class _EditMessageState extends State<EditMessage> {
  List<TextEditingController> _phoneControllers;
  final _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void addPhone(){
    setState(() {
      _phoneControllers.add(TextEditingController());
    });
  }

  Widget title(String text){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, model, child) {
      _phoneControllers = model.selectedMessage.phones.map((phone) => TextEditingController()..text = phone).toList();
      _textController.text = model.selectedMessage.text;

      void saveMessage(){
        model.saveMessage(Message(
          active: true,
          id: model.selectedMessage.id,
          phones: _phoneControllers.where((phone) => phone.value.text.length > 0).map((c) => c.value.text).toList(),
          text: _textController.value.text
        ));

        Navigator.pop(context);
      }

      void deleteMessage(){
        model.deleteMessage();
        Navigator.pop(context);
      }

      final trashButton = CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(
          CupertinoIcons.delete_solid,
          semanticLabel: 'Delete',
        ),
        onPressed: deleteMessage,
      );

      final shareButton = CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(
          CupertinoIcons.share_up,
          semanticLabel: 'Share',
        ),
        onPressed: () => Share.text('Link to redirect', '$baseUrl/${model.selectedMessage.id}', 'text/pain'),
      );

      final saveButton = CupertinoButton(
        padding: EdgeInsets.zero,
        child: const Icon(
          CupertinoIcons.check_mark_circled,
          semanticLabel: 'Save',
        ),
        onPressed: saveMessage,
      );

      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Edit Message'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: model.selectedMessage.id.length > 0 ?
              [trashButton, saveButton, shareButton] :
              [saveButton],
          ),
        ),
        child: CupertinoScrollbar(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        title('Phones'),
                        CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Icon(
                            CupertinoIcons.plus_circled,
                            semanticLabel: 'Add Number',
                          ),
                          onPressed: addPhone,
                        )
                      ],
                    ),
                      ..._phoneControllers.map((phone) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhoneField(
                              controller: phone,
                            ),
                          )
                      ).toList(),
                    Padding(
                      padding: const EdgeInsets.all(8),
                    ),
                    title('Text'),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CupertinoTextField(
                        padding: EdgeInsets.all(8),
                        controller: _textController,
                        placeholder: 'Text',
                        maxLines: 5,
                        onSubmitted: (text){
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 0, color: CupertinoColors.inactiveGray))
                        )
                      ),
                    )
                  ]
                ),
              )
            ],
          )
        )
      );
    });
  }
}