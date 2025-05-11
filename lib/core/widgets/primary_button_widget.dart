import 'package:booking_reserv/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final double textSize;
  final double radius;
  final double borderWidth;
  final FontWeight fontWeight;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;

  const PrimaryButtonWidget({
    required this.text,
    required this.onPressed,
    super.key,
    this.textSize = 16,
    this.fontWeight = FontWeight.w500,
    this.radius = 16,
    this.textColor = Colors.white,
    this.backgroundColor = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.borderWidth = 2.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPadding = EdgeInsets.symmetric(
      vertical: textSize * 0.6, // адаптивная высота от шрифта
      horizontal: textSize * 1.2, // ширина зависит от размера шрифта
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
          side: BorderSide(
            color: borderColor,
            width: borderWidth,
          ),
        ),
        padding: padding ?? defaultPadding,

       
        textStyle: TextStyle(
          fontSize: textSize.sp,
          fontWeight: fontWeight,
          color: textColor,
        ),
      ),
      child: Text(text),
    );
  }
}
