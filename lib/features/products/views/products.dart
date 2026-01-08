import 'package:flutter/material.dart';
import 'package:get440_test_app/features/products/data/dummy_data.dart';
import 'package:get440_test_app/features/products/views/product_card.dart';

class Products extends StatelessWidget {
  final bool shrinkWrap;
  const Products({super.key, this.shrinkWrap = false});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap
          ? const NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(top: 8),
      itemCount: dummyProducts.length - 1, // Cater for deal of the day
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) {
        return ProductCard(product: dummyProducts[index + 1]);
      },
    );
  }
}
