import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Get440text extends StatelessWidget {
  final String text;
  final FontWeight fontWeight;
  final double fontSize;
  final Color color;
  final int? maxLines;
  final bool obscureText;

  const Get440text({
    super.key,
    required this.text,
    this.fontWeight = FontWeight.w600,
    this.color = Colors.black87,
    this.fontSize = 14,
    this.maxLines,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: maxLines != null ? TextOverflow.ellipsis : null,
      style: GoogleFonts.viga(
        fontWeight: fontWeight,
        color: color,
        fontSize: fontSize,
      ),
    );
  }
}
