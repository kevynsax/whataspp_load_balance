import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whatsapp_load_balance/model/app_state_model.dart';
import 'package:whatsapp_load_balance/model/message.dart';
import 'package:whatsapp_load_balance/phone_field.dart';

class EditMessage extends StatefulWidget {
  static String routeName = 'message/edit';

  @override
  _EditMessageState createState() => _EditMessageState();
}

class _EditMessageState extends State<EditMessage> {
  List<String> phones;

  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void addPhone(){
    setState(() {
      phones.add('');
    });
  }

  void changePhone(int index, String val){
    setState(() {
      phones[index] = val;
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
      phones = model.selectedMessage.phones;
      _textController.text = model.selectedMessage.text;

      void saveMessage(){
        model.updateMessage(Message(
          active: true,
          id: model.selectedMessage.id,
          phones: phones.where((e) => e.length > 0).toList(),
          text: _textController.value.text
        ));

        Navigator.pop(context);
      }

      void deleteMessage(){
        model.deleteMessage();
        Navigator.pop(context);
      }

      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Edit Message'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.delete_solid,
                  semanticLabel: 'Delete',
                ),
                onPressed: deleteMessage,
              ),
              CupertinoButton(
                padding: EdgeInsets.zero,
                child: const Icon(
                  CupertinoIcons.check_mark_circled,
                  semanticLabel: 'Save',
                ),
                onPressed: saveMessage,
              ),

            ],
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
                      ...phones.map((phone) =>
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PhoneField(
                              value: phone,
                              onChanged: (text) => changePhone(phones.indexOf(phone), text),
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
