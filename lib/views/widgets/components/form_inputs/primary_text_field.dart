import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? Function(dynamic)? validator;
  final void Function(dynamic)? onChanged;
  final String label;
  final Icon? icon;
  final bool? obscure;

  PrimaryTextField(
      {this.controller,
      this.validator,
      required this.label,
      this.icon,
      this.onChanged,
      this.obscure});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.controller ?? null,
      validator: this.validator ?? null,
      onChanged: onChanged,
      decoration: InputDecoration(
        icon: icon,
        hintText: label,
        labelText: label,
      ),
      obscureText: this.obscure??false,
    );
  }
}
