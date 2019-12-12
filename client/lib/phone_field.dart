import 'package:flutter/cupertino.dart';

class PhoneField extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;

  TextEditingController _controller = TextEditingController();

  PhoneField({
    this.value,
    this.onChanged
  }): assert(value != null),
      assert(onChanged != null){
    _controller.text = value;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: _controller,
      prefix: Icon(
        CupertinoIcons.phone,
        color: CupertinoColors.lightBackgroundGray,
        size: 28,
      ),
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      clearButtonMode: OverlayVisibilityMode.editing,
      keyboardType: TextInputType.number,
      autocorrect: false,
      placeholder: 'Phone',
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 0, color: CupertinoColors.inactiveGray))
      ),
      onEditingComplete: () => this.onChanged(_controller.value.text),
      onSubmitted: (text){
        FocusScope.of(context).requestFocus(FocusNode());
        this.onChanged(text);
      },
    );
  }
}
