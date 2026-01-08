import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get440_test_app/components/get440text.dart';
import 'package:get440_test_app/features/products/model/product.dart';
import 'package:get440_test_app/ui_store/app_colors.dart';
import 'package:get440_test_app/ui_store/spacing.dart';
import 'package:go_router/go_router.dart';
import 'package:magicoon_icons/magicoon.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final bool inStock = product.stock > 0;

    return GestureDetector(
      onTap: () {
        context.push("/home/viewproduct", extra: product);
      },
      child: Card(
        elevation: 2,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CachedNetworkImage(
              imageUrl: product.imageUrl,
              height: 180,

              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: Colors.grey[300],
                child: const Icon(MagicoonFilled.imagePlus, size: 50),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Get440text(
                    text: product.name,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Get440text(
                        text: inStock
                            ? "In Stock: ${product.stock}"
                            : "Out of Stock",
                        fontSize: 12,
                        color: inStock ? Colors.grey[700]! : Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                      Get440text(
                        text: "Price \$${product.price.toStringAsFixed(2)}",
                        fontSize: 12,
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
