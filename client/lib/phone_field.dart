import 'package:flutter/cupertino.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  PhoneField({
    this.controller
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoTextField(
      controller: controller,
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
    );
  }
}
