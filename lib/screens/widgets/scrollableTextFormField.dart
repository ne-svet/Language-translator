import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ScrollableTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final double height;

  const ScrollableTextFormField({
    Key? key,
    required this.controller,
    this.height = 200.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: SingleChildScrollView(
        child: TextFormField(
          controller: controller,
          maxLines: null, // Разрешить многострочный ввод
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Type your text here',
          ),
        ),
      ),
    );
  }
}
