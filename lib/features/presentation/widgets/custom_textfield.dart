import 'package:bullbear/core/utils/app_colors.dart';
import 'package:bullbear/core/utils/constants.dart';
import 'package:flutter/material.dart';


class CustomTextfield extends StatelessWidget {
  const CustomTextfield(
      {super.key,
      required this.hint,
      this.suffix,
      this.validator,
      this.controller,
      this.focusNode,
      this.onChanged,
      this.head,
      this.onTapSuffix,
      this.obscureText,
       this.white,
      this.readOnly});
  final bool? white;
  final String hint;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? head;
  final VoidCallback? onTapSuffix;
  final bool? obscureText;
  final bool? readOnly;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (head != null) ...[
          Text(
            head!,
            style: TextStyle(
              color:white??false? Colors.black:AppColors.primarycolor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Constants.spaceHight10,
        ],
        TextFormField(
          focusNode: focusNode,
          readOnly: readOnly ?? false,
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText ?? false,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 214, 214, 214),
              ),
            ),
            fillColor: AppColors.primarycolor,
            filled: true,
            suffixIcon: suffix != null
                ? GestureDetector(
                    onTap: onTapSuffix,
                    child: suffix,
                  )
                : null,
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w100,
              color: Colors.grey.shade500,
            ),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.none,
                width: 0.2,
                strokeAlign: BorderSide.strokeAlignCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
