import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final TextEditingController controller;
  final double radius;
  final bool isSecure;
  final bool isLoading;
  final bool isRequired;
  final bool isPhoneNumber;
  final String phoneMask;
  final EdgeInsets padding;
  final bool isReadOnly; // Новый параметр для контроля редактирования
  final String? initialText; // Новый параметр для установки текста

  const CustomTextFieldWidget({
    required this.controller,
    super.key,
    this.hintText = '',
    this.labelText = '',
    this.isSecure = false,
    this.isLoading = false,
    this.radius = 8.0,
    this.isRequired = true,
    this.isPhoneNumber = false,
    this.phoneMask = '8 (000) 000-00-00',
    this.padding = const EdgeInsets.only(top: 14, left: 16, bottom: 15),
    this.isReadOnly = false, // По умолчанию редактирование разрешено
    this.initialText, // Изначально текст пустой
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Устанавливаем начальный текст, если он передан
    if (widget.initialText != null) {
      widget.controller.text = widget.initialText!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: widget.isPhoneNumber
          ? <TextInputFormatter>[MaskedInputFormatter(widget.phoneMask)]
          : <TextInputFormatter>[],
      controller: widget.controller,
      obscureText: widget.isSecure && !_isPasswordVisible,
      validator: (String? value) => widget.isRequired
          ? (value == null || value.isEmpty
              ? 'Поле не должно быть пустым'
              : null)
          : null,
      enabled: !widget.isLoading,
      readOnly: widget.isReadOnly, // Установка поля только для чтения
      decoration: InputDecoration(
        suffixIcon: widget.isSecure
            ? InkWell(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 12.0.w,
                    top: 15.0.h,
                    bottom: 11.0.h,
                  ),
                  child: SvgPicture.asset(
                    _isPasswordVisible
                        ? 'assets/vectors/show_password.svg'
                        : 'assets/vectors/hide_password.svg',
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : null,
        filled: true,
        fillColor: widget.isLoading
            ? Colors.white10
            : const Color.fromRGBO(246, 246, 246, 1),
        hintText: widget.hintText,
        labelStyle: TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: 14.sp,
          height: 17 / 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color.fromRGBO(189, 189, 189, 1),
        ),
        contentPadding: widget.padding,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade700, width: 1),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blue, width: 1.5),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(widget.radius),
        ),
      ),
    );
  }
}
