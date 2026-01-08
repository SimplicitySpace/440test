import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440text.dart';

class Get440button extends StatelessWidget {
  final String cta;
  final VoidCallback onPressed;
  final FontWeight fontWeight;
  final Widget prefix;
  final Color color;
  final double height;
  final double borderRadius;
  final Color? textColor;
  final Color borderColor;
  final bool isLoading;
  const Get440button({
    super.key,
    required this.cta,
    required this.onPressed,
    this.color = const Color(0xFFF77A11),
    this.fontWeight = FontWeight.w600,
    this.prefix = const SizedBox.shrink(),
    this.height = 48,
    this.borderRadius = 80,
    this.textColor,
    this.borderColor = const Color(0xFFF77A11),
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            prefix,
            if (prefix is! SizedBox) const SizedBox(width: 8),

            Container(
              child: isLoading
                  ? CupertinoActivityIndicator()
                  : Get440text(
                      text: cta,
                      fontWeight: fontWeight,
                      fontSize: 14,
                      color: textColor ?? Colors.white,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
