import 'package:arm_chat/src/core/components/custom_text.dart';
import 'package:arm_chat/src/core/resources/colors/pallet.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? labelText;
  final String? initialValue, hintText;

  final bool obscureText, enabled;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String?)? onSaved, onChanged;
  final String? Function(String?)? validator;
  final VoidCallback? iconPressed;

  const CustomTextFormField(
      {Key? key,
      this.labelText,
      this.obscureText = false,
      this.initialValue,
      this.enabled = true,
      this.hintText,
      this.iconPressed,
      this.keyboardType = TextInputType.text,
      this.controller,
      this.onSaved,
      this.onChanged,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          labelText != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: CustomText(
                    text: labelText!,
                  ),
                )
              : const SizedBox(
                  height: 0,
                ),
          Center(
            child: TextFormField(
              controller: controller,
              onSaved: onSaved,
              validator: validator,
              initialValue: initialValue,
              keyboardType: keyboardType,
              enabled: enabled,
              onChanged: onChanged,
              obscureText: obscureText,
              cursorColor: Pallet.primary,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: Colors.grey.withOpacity(0.1),
                filled: true,
                hintStyle: const TextStyle(
                  color: Pallet.blackNeutral,
                ),
                disabledBorder: InputBorder.none,
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallet.primary,
                    width: 1.8,
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallet.secondary,
                    width: 1,
                  ),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallet.secondary,
                    width: 1.8,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallet.primary,
                    width: 1.8,
                  ),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Pallet.primary,
                    width: 1.8,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
