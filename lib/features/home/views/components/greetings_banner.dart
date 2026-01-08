import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/ui_store/app_colors.dart';

class GreetingsBanner extends StatefulWidget {
  const GreetingsBanner({super.key});

  @override
  State<GreetingsBanner> createState() => _GreetingsBannerState();
}

class _GreetingsBannerState extends State<GreetingsBanner> {
  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CircleAvatar(backgroundColor: AppColors.accent, radius: 28),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Get440text(text: "Hey, Get440"),
            Get440text(
              text: "Good Morning",
              fontWeight: FontWeight.w100,
              fontSize: 12,
            ),
          ],
        ),
      ],
    );
  }
}
