import 'package:flutter/material.dart';
import 'package:todo/app/core/utils/extensions.dart';

class Input extends StatelessWidget {
  const Input({super.key, this.label, this.controller, this.validator});

  final String? label;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label != null
            ? Padding(
                padding: EdgeInsets.only(bottom: 1.0.hp),
                child: Text(
                  label!,
                  style: TextStyled.bodyLarge
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              )
            : Container(),
        TextFormField(
          controller: controller,
          validator: validator,
        ),
        SizedBox(
          height: 2.0.hp,
        ),
      ],
    );
  }
}
