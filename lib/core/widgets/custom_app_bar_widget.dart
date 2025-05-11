import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;
  final double fontSize;
  final bool canGoBack;

  const CustomAppBarWidget({
    required this.title,
    super.key,
    this.fontSize = 20,
    this.canGoBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(26),
        bottomRight: Radius.circular(26),
      ),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              /// Кнопка "Назад" слева
              Align(
                alignment: Alignment.centerLeft,
                child: Material(
                  color: Colors
                      .transparent, // Прозрачный фон, чтобы эффект работал
                  child: canGoBack
                      ? InkWell(
                          borderRadius:
                              BorderRadius.circular(80.r), // Округление эффекта
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                            padding: const EdgeInsets.all(
                              6,
                            ), // Увеличенный отступ для удобного нажатия
                            child: SvgPicture.asset(
                              'assets/vectors/back_icon.svg',
                              width: 8.w,
                              height: 14.h,
                            ),
                          ),
                        )
                      : SizedBox(),
                ),
              ),

              /// Заголовок по центру
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(65.h);
}
