import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/home/views/components/greetings_banner.dart';
import 'package:get440_test_app/features/products/data/dummy_data.dart';
import 'package:get440_test_app/features/products/views/product_card.dart';
import 'package:get440_test_app/features/products/views/products.dart';
import 'package:get440_test_app/ui_store/spacing.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
            vertical: AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GreetingsBanner(),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: AppSpacing.xl),
                      const Get440text(
                        text: "DEAL OF THE DAY",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      ProductCard(product: dummyProducts[0]),
                      const SizedBox(height: AppSpacing.xl),
                      const Get440text(
                        text: "Products",
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      const Products(shrinkWrap: true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
